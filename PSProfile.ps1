Import-Module -Name Terminal-Icons
oh-my-posh init pwsh --config $env:USERPROFILE\Git\TerminalConfiguration\ADJ.json | Invoke-Expression

function Get-GitChanges{
    [alias('ggc')]
    $Folders = Get-ChildItem -Directory
    foreach($Folder in $Folders){
        Write-Host "> $($Folder.Name)"
        Push-Location $Folder.FullName
        & git pull
        Pop-Location
    }
}

if(Test-Path 'C:\Program Files\7-Zip\7z.exe'){
    New-Alias -Name '7z' -Value 'C:\Program Files\7-Zip\7z.exe'
}

