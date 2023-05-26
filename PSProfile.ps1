Import-Module -Name Terminal-Icons
oh-my-posh init pwsh --config C:\Users\JAAL\Git\TerminalConfiguration\ADJ.json | Invoke-Expression

function Get-GitChanges{
    $Folders = Get-ChildItem -Directory
    foreach($Folder in $Folders){
        Write-Host "> $($Folder.Name)"
        Push-Location $Folder.FullName
        & git pull
        Pop-Location
    }
}

Set-Alias -Name GGC -Value Get-GitChanges
Set-Alias -Name subl -Value 'C:\Program Files\Sublime Text\subl.exe'
