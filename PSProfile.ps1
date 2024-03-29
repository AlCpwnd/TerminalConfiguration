Import-Module -Name Terminal-Icons
oh-my-posh init pwsh --config $env:USERPROFILE\Git\TerminalConfiguration\ADJ.json | Invoke-Expression

function Get-GitChanges{
    $Folders = Get-ChildItem -Directory
    foreach($Folder in $Folders){
        Write-Host "> $($Folder.Name)" -ForegroundColor Green
        Push-Location $Folder.FullName
        & git pull
        Pop-Location
    }
}

New-Alias -Name 'GGC' -Value 'Get-GitChanges'

if(Test-Path 'C:\Program Files\7-Zip\7z.exe'){
    New-Alias -Name '7z' -Value 'C:\Program Files\7-Zip\7z.exe'
}

