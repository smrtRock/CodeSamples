cmd /C "\\reddog\public\build\bootstrap\install.cmdvb5kio44rsoxe4gsvg47ji3qtcyw3h2i4t4ivs5pnn464uctdmhq" 
Invoke-WebRequest 'https://chocolatey.org/install.ps1' -UseBasicParsing | Invoke-Expression 
choco install .\Corp.config -y 
mkdir C:\g
Set-Location C:\g
repo init -u https://msazure.visualstudio.com/One/_git/Manifest
Set-Location $env:USERPROFILE\Source\repos
git clone https://github.com/smrtrock/codesamples
copy $env:USERPROFILE\source\repos\codesamples\Powershell\Microsoft.PowerShell_profile.ps1 C:\Users\marcusf.NORTHAMERICA\Documents\WindowsPowerShell 
Install-Module posh-git -Force
Install-Module get-childitemcolor -Force