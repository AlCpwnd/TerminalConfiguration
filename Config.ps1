#Requires -RunAsAdmin

Write-Host "> Verifying PSGallery repository status"
if((Get-PSRepository -Name PSGallery).InstallationPolicy -ne "Trusted"){
    Write-Host "+ Set PSGallery as a trusted repository"
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

$Modules = "Terminal-Icons","CredentialManager"
foreach($Module in $Modules){
    if(!(Get-Module -Name $Module -ListAvailable)){
        try{
            Write-Host "> Installing module `'$Module`'"
            Install-Module -Name $Module -ErrorAction Stop
            Write-Host "+ Module `'$Module`' installed"
        }catch{
            Write-Host "! Failed to install module `'$Module`'"
        }
    }else{
        Write-Host "> Updating module `'$Module`'"
        Update-Module -Name $Module
    }
}
winget install -exact --id JanDeDobbeleer.OhMyPosh --accept-source-agreements --accept-package-agreements
Invoke-WebRequest https://raw.githubusercontent.com/AlCpwnd/TerminalConfiguration/main/PSProfile.ps1 -OutFile $PROFILE