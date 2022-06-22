#Requires -RunAsAdmin

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Terminal-Icons
Install-Module CredentialManager
winget install JanDeDobbeleer.OhMyPosh

$TerminalConfigFile = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\Settings.json"
$config = Get-Content $TerminalConfigFile | ConvertFrom-Json
$config.Profiles.defaults.font.face = "CaskaydiaCove NF"
$config.Profiles.defaults.font.size = 10
ConvertTo-Json $config -Depth 32 | Set-Content $TerminalConfigFile