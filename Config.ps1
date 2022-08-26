#Requires -RunAsAdmin

if((Get-PSRepository -Name PSGallery).InstallationPolicy -ne "Trusted"){
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}
Install-Module -Name Terminal-Icons
Install-Module CredentialManager
winget install JanDeDobbeleer.OhMyPosh
$WebRequest = Invoke-WebRequest https://raw.githubusercontent.com/AlCpwnd/TerminalConfiguration/main/PSProfile.ps1
$WebRequest.Content | Out-File $PROFILE