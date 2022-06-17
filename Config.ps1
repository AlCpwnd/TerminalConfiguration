#Requires -RunAsAdmin

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Terminal-Icons
winget install JanDeDobbeleer.OhMyPosh
winget install --id Git.Git -e --source winget
