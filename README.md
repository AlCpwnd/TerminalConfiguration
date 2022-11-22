# TerminalConfiguration

This project contains the necessary information to perosnalise the [**Windows Terminal**](https://learn.microsoft.com/en-us/windows/terminal/install) environment.

## Contents
[ADJ.json](ADJ.json)
: Json profile for the OhMyPosh

[Config.ps1](Config.ps1)
: Configuration script (See [Setup](#setup))

[Modules.ps1](Modules.ps1)
: Script to install my most used PowerShell modules for Microsoft365 management

[PSProfile.ps1](PSProfiles.ps1)
: Profile that is created upon running the configuration script

## Prerequisites
The script will configure the `PSProfile.ps` as you `$PROFILE` and will be using [OhMyPosh](https://ohmyposh.dev/).
I therefore recommend you download one of the [NerdFonts](https://www.nerdfonts.com/#home) in order to have all icons show up properly.
> I personally user [CascadiaCode](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip)

## Setup
> All the commands below need to be run as admin.
1. Enable local script execition:
```ps
Set-ExecutionPolicy RemoteSigned
```
2. Run [Config.ps1](Config.ps1) within that PowerShell window