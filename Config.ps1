#Requires -RunAsAdmin

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Terminal-Icons
Install-Module CredentialManager
winget install JanDeDobbeleer.OhMyPosh
winget install --id Git.Git -e --source winget
winget install -e --id Microsoft.VisualStudioCode
