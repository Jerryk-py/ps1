& "getmac" /?
[Console]::outputEncoding = [Text.Encoding]::GetEncoding('Windows-1251') # костыль для корректного отображения кириллицы
$allcerts = C:\Program` Files\Crypto` Pro\CSP\csptest.exe -keyset -enum_cont -verifycontext -fqcn  
try
{
  foreach($cert in $allcerts){
   if($cert -like '\\.\REGISTRY\*')
   
  {
    $name_conteiner = C:\Program` Files\Crypto` Pro\CSP\csptest.exe -keyset -container $cert -check 
    
    foreach($x in $name_conteiner)
   {
        if ($x -like "*Expired or not yet valid license")
        {
        Write-Host($x)
        C:\Program` Files\Crypto` Pro\CSP\csptest.exe -keyset -deletekeyset -container $cert
        }
    }
  }
  }
 }
 
catch [System.Management.Automation.RemoteException]
{ [Management.Automation.ErrorRecord]$e = $_
 
  $info = [PSCustomObject]@{
    Exception = $e.Exception.Message
    Reason    = $e.CategoryInfo.Reason
    Target    = $e.CategoryInfo.TargetName
    Script    = $e.InvocationInfo.ScriptName
    Line      = $e.InvocationInfo.ScriptLineNumber
    Column    = $e.InvocationInfo.OffsetInLine
  }
  $info
}

$pathCert = "Cert:\CurrentUser\My"
$certmgmt = (Get-ChildItem $pathCert) 
$date_now = get-date
 foreach($1cert in $certmgmt){
        if($date_now -gt $1cert.NotAfter )
     {Remove-Item ($pathCert + '\\'  + $1cert.Thumbprint)}
     }   
 [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
 [System.Windows.Forms.MessageBox]::Show('Мусор вынесен.','УСПЕХ!')
