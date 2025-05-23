Import-Module -Name Terminal-Icons
$OMPProfile = "$env:USERPROFILE\Git\TerminalConfiguration\ADJ.omp.json"
if(!(Test-Path -Path $OMPProfile)){
    Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/AlCpwnd/TerminalConfiguration/main/ADJ.omp.json' -OutFile $OMPProfile
}
oh-my-posh init pwsh --config $OMPProfile | Invoke-Expression

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

$Aliases = @{
    GGC = "Get-GitChanges";
    '7z' = 'C:\Program Files\7-Zip\7z.exe'
}

foreach($Alias in $Aliases.GetEnumerator()){
    try{
        Get-Alias -Name $Alias.Name -ErrorAction Stop
    }catch{
        New-Alias -Name $Alias.Name -Value $Alias.Value -ErrorAction SilentlyContinue
    }
}