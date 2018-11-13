# How to do the Profile thing

For security reasons I like to sign all my scripts just paranoia maybe or something about security I don't remember which, could be both. 

##  Create a Self Signed Cert, unless you are a baller then buy one

```powershell
$cert = New-SelfSignedCertificate -DnsName sample.contoso.com -Type CodeSigning -CertStoreLocation Cert:\CurrentUser\My
```

## Now what

We need to put this cert somewhere we can trust it to do this we need to place the cert we created in the Trusted root and trusted publishers

```powershell
$a = gci Cert:\CurrentUser\My\ | where Subject -eq CN=sample.contoso.com
Export-PfxCertificate $a -FilePath $env:TEMP\ccsigncert.pfx -Password (ConvertTo-SecureString "pass@word1" -Force -AsPlainText)
Import-PfxCertificate $env:temp\ccsigncert.pfx -CertStoreLocation Cert:\LocalMachine\Trust -Password (ConvertTo-SecureString "pass@word1" -Force -AsPlainText)
Import-PfxCertificate $env:temp\ccsigncert.pfx -CertStoreLocation Cert:\LocalMachine\TrustedPublisher -Password (ConvertTo-SecureString "pass@word1" -Force -AsPlainText)
```

## And Then

### Take Precautions 

Lets take it for a spin, as a precaution I like to have my machine powershell policy to only allow Remote Signed, this should be the minimum security measure

Anyone we trust should at a minimum be digitally signing there stuff

Let's ensure we are there

```powershell
Get-ExecutionPolicy
``` 

Restricted is the default policy on Win8 and Server 2012, restricted only allows individual commands which makes things barely usable. 

More on Exectuion policy [here](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-6&viewFallbackFrom=powershell-Microsoft.PowerShell.Core)

```powershell 
Set-ExecutionPolicy RemoteSigned -Scop LocalMachine -Force
```

> Note:  -Force just means to confirm just do

### Let er rip

```powershell
Set-AuthenticodeSignature -Certificate (gci Cert:\CurrentUser\My\ -CodeSigningCert ) -FilePath .\Microsoft.PowerShell_profile.ps1
```
