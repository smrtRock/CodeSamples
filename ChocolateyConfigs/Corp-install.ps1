$repoRoot = "g"
Set-ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
cmd /C "\\reddog\public\build\bootstrap\install.cmd" 
Invoke-WebRequest 'https://chocolatey.org/install.ps1' -UseBasicParsing | Invoke-Expression 
mkdir "C:\$repoRoot"
Set-Location "C:\$repoRoot"
repo init -u https://msazure.visualstudio.com/One/_git/Manifest
Set-Location $env:USERPROFILE\Source\repos
git clone https://github.com/smrtrock/codesamples
choco source enable -n=chocolatey
choco install $env:USERPROFILE\source\repos\codesamples\ChocolateyConfigs\Corp.config -y
choco source disable -n=chocolatey
copy $env:USERPROFILE\source\repos\codesamples\Powershell\Microsoft.PowerShell_profile.ps1 $env:USERPROFILE\Documents\WindowsPowerShell 
Install-Module posh-git -Force
Install-Module get-childitemcolor -Force
