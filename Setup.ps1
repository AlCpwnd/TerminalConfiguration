#Requires -RunAsAdministrator

# Installing fonts.
$fonts = Get-ChildItem -Path .\Font -Include *.ttf, *.otf
$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.NameSpace(0x14)
foreach($font in $fonts){
    $fontsFolder.CopyHere($font.FullName)
}

# Defining PSGallery as a trusted repository.
Write-Host "> Defining repositories." -ForegroundColor Green
if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

# Installing package provider.
$PackageProviders = @('NuGet')
foreach ($PackageProvider in $PackageProviders) {
    Write-Host "> Installing package providers: $PackageProvider" -ForegroundColor Green
    Install-PackageProvider -Name $PackageProvider -Force
}

# Installing modules.
$Modules = 'Terminal-Icons', 'PSWindowsUpdate'
foreach ($Module in $Modules) {
    Install-Module -Name $Module -Force
}

# Copying VIM configuration
Write-Host "> Copying vim profile"
Copy-Item .\Profiles\.vimrc $HOME

# Using winget to install required programs.
$apps = 'JanDeDobbeleer.OhMyPosh','vim.vim'
foreach($app in $apps){
    winget install --exact --id $app --accept-source-agreements --accept-package-agreements
}

# Setting up PowerShell profile.
## OhMyPosh installation.
## Profile download from GitHub repository.
$ProfileUrl = 'https://raw.githubusercontent.com/AlCpwnd/TerminalConfiguration/main/PSProfile.ps1'
Invoke-WebRequest -Uri $ProfileUrl -UseBasicParsing -OutFile $PROFILE

# Configures Windows Terminal settings.
Write-Host "> Importing Windows Terminal settings." -ForegroundColor Green
$SettingsPath = (Get-ChildItem -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json).FullName
$settings = Get-Content -Path $SettingsPath | ConvertFrom-Json

$themeFile = '.\Themes\Dracula.json' #File name containing the theme you want to apply.
$theme = Get-Content -Path $themeFile | ConvertFrom-Json

## Adding the theme to the terminal
if (-not ($settings.schemes | Where-Object { $_.name -eq $theme.name } )) {
    $settings.schemes += $theme
}

if (-not(Get-Member -InputObject $settings.profiles.defaults -Name 'colorScheme')) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name 'colorScheme' -Value $($theme.name)
}
else {
    $settings.profiles.defaults.colorScheme = $theme.name
}

$settingsContents = $settings | ConvertTo-Json -Depth 3
$settingsContents | Out-File -FilePath $SettingsPath -Encoding utf8