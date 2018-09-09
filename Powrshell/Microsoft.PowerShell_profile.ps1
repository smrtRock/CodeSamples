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
# MIIFfQYJKoZIhvcNAQcCoIIFbjCCBWoCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUm3tb7uEwAGjNEWBLoKvmABf3
# vy+gggMbMIIDFzCCAf+gAwIBAgIQHmpbVLJacLlDpNESb3aYezANBgkqhkiG9w0B
# AQsFADAXMRUwEwYDVQQDDAxzbXJ0cm9jay5jb20wHhcNMTgwODI0MTI0OTE2WhcN
# MTkwODI0MTMwOTE2WjAXMRUwEwYDVQQDDAxzbXJ0cm9jay5jb20wggEiMA0GCSqG
# SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNhqfPh/M4iFCT5I3RnOmbWmABpo7YB2ng
# ge076BlW1+u+K0dFHmky4SwmuDLqS5VRYgcJOsQ74GKkvJHFMTFTH6HGuamgJKfh
# JkAxUE+GIfe+ilsEDQLweDktwmir7ttVVWgMjSnSsz0Nc/wdSFUe8fYRH3r0zHgI
# ANvRwBydsbiIMV65Z8v3YjpzOxsxtqWLFgNxaJEH2g1bM4oyJOa905CUAEcYFNWd
# lWTTuqkAFMXzy0MfQ6/aC1Hx72vB/+9329jltp4gSntfD/nV7uMoWNeeuhCaHUvN
# cjdfQ7NmISBUfwfb3ovfK6/0lwm6YgzZ7dArqUzSGaSrk8w1JgndAgMBAAGjXzBd
# MA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAXBgNVHREEEDAO
# ggxzbXJ0cm9jay5jb20wHQYDVR0OBBYEFAIu2SzVGfsm+hnO8YT6ChklAa01MA0G
# CSqGSIb3DQEBCwUAA4IBAQAJ/Bjtoav9mLdk67pWFqUMJmVgAdMYVSTQPP9zvUdP
# 8e/Kw1qc2Erl0F3uts/qYMEDr9QFb38vI40OLl2TXAqw5cTsQyrWExgiAK4cCJn9
# 8FYAFXD4Z4Tk0xayZMxRXftGoDNIFJ8j5VQiPWbTzdV3svJ5pBeZxZ8zg41sDcWS
# GVPijBJRpCRC3s8TbFSPBIcqd/Q8SKaBBH5UsL2wO/6pwAtJVnbh1P4YjxXjfb8a
# OtHz3ZBwogq/SY66wpjZblq8GFN7y/oBzOV/NBVpsjXl4AigxbCgknGBS8jAopUe
# A4Xyrbkqazu9pmcd9yYfSXPyhDOEt6xzUH8auZFu3ZceMYIBzDCCAcgCAQEwKzAX
# MRUwEwYDVQQDDAxzbXJ0cm9jay5jb20CEB5qW1SyWnC5Q6TREm92mHswCQYFKw4D
# AhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwG
# CisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZI
# hvcNAQkEMRYEFOC3k75W2W0JbErwl7ktSbf5IigfMA0GCSqGSIb3DQEBAQUABIIB
# AFP2Kwy0Frn8u+woqjGAfMf2eA1ZYh7rxpjtgFDrRsAjL2XYqp5N7P6dzq0aqrlN
# 6Ud+izdP2Dnpn6dmhA/WcIdh0803EjXs7Wbmg3QeiRmMDbQ3aRG+jhiw9H+8cXzQ
# Ra9fnrzLypDhnhpJQu/scOgWmDCfQumhrn1JUK7BdbHq0vptDwMOyCo9dRWL43kj
# SQkA0t28gLQXHpR0MHbvEKunRiq31UO8B7xyLqtMu8TfliknAMgCVZm+nwl7sdWI
# OzlGiFEJQVdJVF5ytJNyY8ITtRRqdEsIaZJ5hUyaL8pR+rgucMnf2JXQIO6+VR65
# 43iCEgxFdqr6k/JPRDHKc5k=
# SIG # End signature block
