## Download the Image
$cultureInfo = [cultureinfo]::CurrentCulture
$weekNumber = $cultureInfo.Calendar.GetWeekOfYear($(Get-Date), $cultureInfo.DateTimeFormat.CalendarWeekRule, $cultureInfo.DateTimeFormat.FirstDayOfWeek)
$currentKali = "kali-linux-$((Get-date).year)-W$($weekNumber)-amd64.iso"
$kaliUrl = "https://cdimage.kali.org/kali-weekly/$($currentKali)"
$kaliOutFile = "C:\Users\Public\Documents\Hyper-V\ISOs\$($currentKali)"
Invoke-WebRequest $kaliUrl -UseBasicParsing -OutFile $kaliOutFile

## Create the Hash
$kaliHash = Invoke-WebRequest "https://cdimage.kali.org/kali-weekly/SHA256SUMS" -UseBasicParsing
$hash = Get-FileHash $kaliOutFile -Algorithm SHA256 
if ($kaliHash.RawContent.Contains($hash))
{
    ## Update the Gallery File
    $content = (get-content .\Gallery_Local.json) |  ConvertFrom-Json 
    foreach ($image in $content.images)
    {
        if ($image.name -eq "[Local] - Kali")
        {
            $image.disk.uri = $kaliOutFile
            $image.disk.hash = $hash.Hash
        }
    }

    $content | ConvertTo-Json -Depth 10 | Out-File .\Gallery_Local.json 
    Write-Host "Updated Gallery"
}