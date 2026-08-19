#Requires -RunAsAdministrator

# Checking the execution policy.
if((Get-ExecutionPolicy) -ne 'RemoteSigned'){
    Set-ExecutionPolicy RemoteSigned -Force
}

# Installing fonts.
Write-Host "> Installing fonts." -ForegroundColor Green
$fonts = Get-ChildItem -Path .\Font\* -Include *.ttf, *.otf
$shell = New-Object -ComObject Shell.Application
$fontsFolder = $shell.NameSpace(0x14)
foreach ($font in $fonts) {
    $fontsFolder.CopyHere($font.FullName)
}

## Recovering the default font name.
Add-Type -AssemblyName PresentationCore
$defaultFont = Get-ChildItem -Path .\Font\*Regular.ttf
$fontName = (New-Object -TypeName Windows.Media.GlyphTypeface -ArgumentList $defaultFont.FullName).Win32FamilyNames.Values

# Defining PSGallery as a trusted repository.
if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {
    Write-Host "> Defining repositories." -ForegroundColor Green
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

# Installing package provider.
$PackageProviders = @('NuGet')
foreach ($PackageProvider in $PackageProviders) {
    try {
        Get-PackageProvider -Name $PackageProvider -ErrorAction Stop | Out-Null
    }
    catch {
        Write-Host "> Installing package providers: $PackageProvider" -ForegroundColor Green
        Install-PackageProvider -Name $PackageProvider -Force
    }
}

# Installing modules.
$Modules = 'Terminal-Icons', 'PSWindowsUpdate', 'PS-Menu'
foreach ($Module in $Modules) {
    if (Get-Module -Name $Module) {
        Write-Host "> Updating module: $Module" -ForegroundColor Green
        Update-Module -Name $Module
    }
    else {
        Write-Host "> Installing module: $Module" -ForegroundColor Green
        Install-Module -Name $Module -Force
    }
}

# Copying VIM configuration
Write-Host "> Copying vim profile" -ForegroundColor Green
Copy-Item .\Profiles\.vimrc $HOME

# Using winget to install required programs.
$appFiles = Get-ChildItem -Path .\AppList\*.json
if($appFiles.Count -gt 1){
    Write-host "Please choose which template to use:"
    $selection = menu $appFiles.Name -ReturnIndex
    winget import --import-file $appFiles.FullName[$selection] --accept-package-agreements --accept-source-agreements
}

# Setting up PowerShell profile.
## Defining profile.
Write-Host "> Configuring PowerShell profile." -ForegroundColor Green
Get-Content -Path .\Profiles\PSProfile.ps1 | Out-File -FilePath $PROFILE -Force -Encoding utf8

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

## Setting the theme as default
if (Get-Member -InputObject $settings.profiles.defaults -Name 'colorScheme') {
    $settings.profiles.defaults.colorScheme = $theme.name
}
else {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name 'colorScheme' -Value $($theme.name)
}

## Configuring the fonts
if (Get-Member -InputObject $settings.profiles.defaults -Name 'font') {
    $settings.profiles.defaults.font.face = $fontName
}
else {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name 'font' -Value @{face=$fontName}
}

$settingsContents = $settings | ConvertTo-Json -Depth 3
$settingsContents | Out-File -FilePath $SettingsPath -Encoding utf8