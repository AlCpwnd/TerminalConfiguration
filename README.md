# TerminalConfiguration

This project contains the necessary information to perosnalise the [**Windows Terminal**](https://learn.microsoft.com/en-us/windows/terminal/install) environment.

## Contents

[ADJ.json](ADJ.json)
: Json profile for OhMyPosh.

[Config.ps1](Config.ps1)
: Configuration script (See [Setup](#setup)).

[PSProfile.ps1](PSProfiles.ps1)
: PowerShell profile that is created upon running the configuration script.

## Prerequisites

The script will configure the `PSProfile.ps` as your `$PROFILE` and will be using [OhMyPosh](https://ohmyposh.dev/).
I therefore recommend you download one of the [NerdFonts](https://www.nerdfonts.com/#home) in order to have all icons show up properly.
> :information_source: I personally user [CascadiaCode](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip)

## Setup

> :warning: All the commands below need to be run as admin.

1. Enable local script execution: (For more info see [PowerShell Execution Policies](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4))

    ```ps
    Set-ExecutionPolicy RemoteSigned -Force
    ```

2. Run [Config.ps1](Config.ps1) within that PowerShell window
