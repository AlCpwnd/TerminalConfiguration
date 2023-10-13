#Requires -RunAsAdmin

# Defining PSGallery as a trusted repository.
if((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted'){
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

# Installing package provider.
$PackageProviders = 'NuGet'
foreach($PackageProvider in $PackageProviders){
    Install-PackageProvider -Name $PackageProvider -Force
}

# Installing modules.
$Modules = 'Terminal-Icons','PSWindowsUpdate'
foreach($Module in $Modules){
    Install-Module -Name $Module -Force
}

# Setting up PowerShell profile.
## OhMyPosh installation.
winget install --exact --id JanDeDobbeleer.OhMyPosh --accept-source-agreements --accept-package-agreements
## Profile download from GitHub repository.
$ProfileUrl = 'https://raw.githubusercontent.com/AlCpwnd/TerminalConfiguration/main/PSProfile.ps1'
Invoke-WebRequest -Uri $ProfileUrl -UseBasicParsing -OutFile $PROFILE