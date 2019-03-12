
# Create Cert
$cert = New-SelfSignedCertificate -DnsName sample.contoso.com -Type CodeSigning -CertStoreLocation Cert:\CurrentUser\My

# Load Cert to the trusted stores
$a = gci Cert:\CurrentUser\My\ | where Subject -eq CN=sample.contoso.com
Export-PfxCertificate $a -FilePath $env:TEMP\ccsigncert.pfx -Password (ConvertTo-SecureString "pass@word1" -Force -AsPlainText)
Import-PfxCertificate $env:temp\ccsigncert.pfx -CertStoreLocation Cert:\LocalMachine\Trust -Password (ConvertTo-SecureString "pass@word1" -Force -AsPlainText)
Import-PfxCertificate $env:temp\ccsigncert.pfx -CertStoreLocation Cert:\LocalMachine\TrustedPublisher -Password (ConvertTo-SecureString "pass@word1" -Force -AsPlainText)

# Sign the profile
Set-AuthenticodeSignature -Certificate (gci Cert:\CurrentUser\My\ -CodeSigningCert ) -FilePath $profile.CurrentUserAllHosts