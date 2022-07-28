$Modules = @(
    "CredentialManager",
    "MSOnline",
    "ExchangeOnlineManagement",
    "AzureAD",
    "PnP.PowerShell"
)

foreach($Module in $Modules){
    if(!(Get-Module -Name $Module -ListAvailable)){
        Write-Host "`t[i]:Installing $Module" -ForegroundColor Yellow
        Install-Module $Module
    }
    else{
        Write-Host "`t[u]:Updating $Module" -ForegroundColor Yellow
        Update-Module $Module
    }    
}