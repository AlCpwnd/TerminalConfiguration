Import-Module -Name Terminal-Icons
oh-my-posh init pwsh --config $env:USERPROFILE\Git\TerminalConfiguration\ADJ.json | Invoke-Expression

function Get-GitChanges{
    $Folders = Get-ChildItem -Directory
    $UiColor = $Host.UI.RawUI
    $WindowWidth = $Host.UI.RawUI.WindowSize.Width
    foreach($Folder in $Folders){
        Write-Host ""
        $Spaces = " " * ($WindowWidth - ($Folder.Name.Length + 2))
        Write-Host "> $($Folder.Name)$Spaces" -BackgroundColor $UiColor.ForegroundColor -ForegroundColor $UiColor.BackgroundColor
        Push-Location $Folder.FullName
        & git pull
        Pop-Location
    }
}

New-Alias -Name GGC -Value Get-GitChanges

if(Test-Path 'C:\Program Files\7-Zip\7z.exe'){
    New-Alias -Name '7z' -Value 'C:\Program Files\7-Zip\7z.exe'
}
