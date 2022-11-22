#Requires -RunasAdmin

$Modules = @(
    "CredentialManager",
    "MSOnline",
    "ExchangeOnlineManagement",
    "AzureAD",
    "PnP.PowerShell"
)

foreach($Module in $Modules){
    if(!(Get-Module -Name $Module -ListAvailable)){
        Write-Host "> Installing $Module"
        Install-Module $Module
    }
    else{
        Write-Host "> Updating $Module" -ForegroundColor Yellow
        Update-Module $Module
    }    
}