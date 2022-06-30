#Requires -RunAsAdmin

if((Get-PSRepository -Name PSGallery).InstallationPolicy -ne "Trusted"){
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}
Install-Module -Name Terminal-Iclons
Install-Module CredentialManager
winget install JanDeDobbeleer.OhMyPosh
$WebRequest = Invoke-WebRequest https://raw.githubusercontent.com/AlCpwnd/TerminalConfiguration/main/PSProfile.ps1
$WebRequest.Content | Out-File $PROFILE

<#
    $TerminalConfigFile = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\Settings.json"
    $config = Get-Content $TerminalConfigFile | ConvertFrom-Json
    $config.Profiles.defaults.font.face = "CaskaydiaCove NF"
    $config.Profiles.defaults.font.size = 10
    ConvertTo-Json $config -Depth 32 | Set-Content $TerminalConfigFile
#>