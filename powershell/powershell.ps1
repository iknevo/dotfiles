oh-my-posh init pwsh --config 'E:\visual-studio\oh-my-posh\nevo.omp.json' | Invoke-Expression

Import-Module -Name Terminal-Icons

# Alias
Set-Alias code "C:\Users\nevoo\AppData\Local\Programs\Microsoft VS Code\bin\code.cmd"
Set-Alias -Name vim -Value nvim

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function AcceptSuggestion



Remove-Item alias:cd -Force

function cd {
    param (
        [Parameter(Mandatory = $false, Position = 0)]
        [string]$args
    )

    if ($args -eq "") { Set-Location } else { Set-Location $args }

    $curr_dir = GetCurrentDir(Get-Location)
    $title = $curr_dir
    wezterm cli set-tab-title $title;
}

function GetCurrentDir {
    param (
      [string]$path = ""
    )
    if ($path -eq "") {
      $path = Get-Location
    }

    if ($path -eq "$env:USERPROFILE") {
      return "~"
    }

    return Split-Path ($path) -Leaf
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
Invoke-Expression (& { (zoxide init powershell | Out-String) })