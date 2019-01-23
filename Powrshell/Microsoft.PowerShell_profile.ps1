<#
Most of this stuff came from Matthey Hodgkins and Joon Roo
h
along with 
#>

# Import module from previous step
Import-Module -Name posh-git
Import-Module PSReadline
Import-Module Get-ChildItemColor

# Color code Get-Childitem
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColor -Option AllScope

# Some general history capability, basically saves state between 
# Shell Windows, more like zsh on linux
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -HistorySaveStyle SaveIncrementally
Set-PSReadlineOption -MaximumHistoryCount 4000

#history Substring search
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab Completion
Set-PSReadlineKeyHandler -Chord 'Shift+Tab' -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# http://serverfault.com/questions/95431
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

<# dress up the prompt
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    if (Test-Administrator) {  # Use different username if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    Write-Host "$ENV:USERNAME@" -NoNewline -ForegroundColor DarkYellow
    Write-Host "$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Magenta

    if ($s -ne $null) {  # color for PSSessions
        Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
    }

    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Blue
    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus

    Write-Host ""

    return "> "

    Set-Alias ls Get-ChildItemColor -Option AllScope -Force
    Set-Alias dir Get-ChildItemColor -Option AllScope -Force
}
#>
function prompt {
    # https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt
    $origLastExitCode = $LastExitCode
    Write-VcsStatus

    if (Test-Administrator) {  # if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    Write-Host "$env:USERNAME@" -NoNewline -ForegroundColor DarkYellow
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Magenta
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower()))
    {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }

    Write-Host $curPath -NoNewline -ForegroundColor Blue
    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta
    Write-Host " : " -NoNewline -ForegroundColor DarkGray
    $LastExitCode = $origLastExitCode
    "`n$('>' * ($nestedPromptLevel + 1)) "
}

$global:GitPromptSettings.BeforeText = '['
$global:GitPromptSettings.AfterText  = '] '

<# 
function cddash {
    if ($args[0] -eq '-') {
        $pwd = $args[0];
    }
    $tmp = pwd;

    if ($pwd) { 
        Set-Location $pwd;
        }
        Set-Variable -Name OLDPWD -Value $tmp -Scope global;
}

Set-Alias -Name cd -Value cddash -Option AllScope
#>

<# Boost startup speed
$env:Path = [System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()
[System.AppDomain]::CurrentDomain.GetAssemblies() | % {
    if (! $_.location) { continue}
    $Name = Split-Path $_.location -Leaf
    Write-Host -ForegroundColor Yellow "NGENing : $Name"
    ngen install $_.location | % {"`t$_"}

}
#>

# SIG # Begin signature block
# MIIFlQYJKoZIhvcNAQcCoIIFhjCCBYICAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUm3tb7uEwAGjNEWBLoKvmABf3
# vy+gggMtMIIDKTCCAhGgAwIBAgIQHtEomvhLu5NJPF0a4AqZCDANBgkqhkiG9w0B
# AQsFADAdMRswGQYDVQQDDBJzYW1wbGUuY29udG9zby5jb20wHhcNMTkwMTIzMDQz
# ODMzWhcNMjAwMTIzMDQ1ODMzWjAdMRswGQYDVQQDDBJzYW1wbGUuY29udG9zby5j
# b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAOAUcSCdMoFSVxuQ2
# TYI6C8irlf37yGfLGTgL/w9DJPgR6O+bsVThk17K1P61PdGH+lbrByiSDkzaDwXm
# 4wjSlhYFB7Bxv2hwPcqyUJciT9envw+XqALQx3RY4pG5EnH3cAVEQ18F8DZgGloO
# xiw6167hz/F6HUFKim8vYHHzIO+vXsb5kbxbpy4WR3D2WsTcZLNp1fF+OvDQNieZ
# HjzShzz3eZWTuMm+5Ovmn1b7cUdGGm3OU2sJfutSgf/uzYcSBmhRQlF/D71bEf9g
# Df3akP9l5MuiyJWBCpAfLg77P2Dq/HoEgqJYfAw8WHwliCk8ojLLgYB+Pbk1yy/o
# CcJBAgMBAAGjZTBjMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcD
# AzAdBgNVHREEFjAUghJzYW1wbGUuY29udG9zby5jb20wHQYDVR0OBBYEFPNqZLCc
# azm9WbSjRFRYo4DSBvTXMA0GCSqGSIb3DQEBCwUAA4IBAQCbHtDUVzuoqzb6owj2
# J4GIk+p/pWaQQw+WDCDe9kD1V948DI4h3JPqnm1EmBW20vNALQkXqTbu4hECmv8n
# O3ewNngR9sx4BNg56ZvOuycPxqbd5HpMbc09yTxtoL7ZD44zYPryYBI73FO7LugS
# 7sy9e+jdvUq6uEV4NXuMrPBp7/Qhe+nXS3uBJnhlV6uXTuvFXA/Hzshmv4kRqb9X
# JjKU1cs3cD9KRTuF3Zzn6dNC6en42+E1DNtUVA6WrjawdDQL2hX+FgGzzQfw/bAN
# 7NE32zybbqqE46PAjCTEtOgzFPPW/SBuLFRpKsIIHugfVfhM+1hEyCMuKHFR/jYR
# JnugMYIB0jCCAc4CAQEwMTAdMRswGQYDVQQDDBJzYW1wbGUuY29udG9zby5jb20C
# EB7RKJr4S7uTSTxdGuAKmQgwCQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAI
# oAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIB
# CzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFOC3k75W2W0JbErwl7kt
# Sbf5IigfMA0GCSqGSIb3DQEBAQUABIIBAKeqff9Gm/w46w8JRCUIs1x9GrToj7iy
# 4n1k9sPA9VyDL1XRcXkia1BZQbpjELij9BMrczKlgaIV5PCt0CxX0Pn8EaKXXIAU
# E2GMP5PUpVozyJ8l1RKF/xa7LLN61++wznZsuNvT+rlBjoVtaG8qqFJkJScTTjDo
# evuthJrpM5OO2KgR6ZYeQOLxkbHwKbBDvFmrwv3Iq2M89bhz0RVtruHr0hW0p3Wx
# xF8k/h8K28jwn6tnlwC1gLQnRPl+2wnUNmZi3Uds3woJFlSP6RQspvvsVi81D3Vd
# hgy9A8AGKLjGs1F2m7FkS5Nvydmq84KQON9Wv9SVOvb8GD/YSFzDMu8=
# SIG # End signature block
