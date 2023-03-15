Import-Module -Name Terminal-Icons
oh-my-posh init pwsh --config https://raw.githubusercontent.com/AlCpwnd/TerminalConfiguration/main/ADJ.json | Invoke-Expression

function Get-GitChanges{
    $Folders = Get-ChildItem -Directory
    foreach($Folder in $Folders){
        Push-Location $Folder.FullName
        & git pull
        Pop-Location
    }
}

Set-Alias -Name GCC -Value Get-GitChanges
