# Main installer script. Run this to configure your pc
# Todo:
# Download powershell
# Install scoop
# Install mingit
# Install windows terminal
# Install starship
# Install neovim
# Install firacode nf
# Install bugn
# Launch bugn at startup
# Print message to user saying that it is all done

# Downloads and unzips powershell
Set-Location ~
Invoke-WebRequest "https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/PowerShell-7.1.4-win-x86.zip" -OutFile ~/Powershell.zip
Expand-Archive ~/Powershell.zip ~/Powershell
Remove-Item Powershell.zip

# Installs scoop
# The version of scoop that I'm installing has a part of the script that triggers mcafee removed from the install script
# Allows the current user to run all scripts regardless of if they're signed
Set-ExecutionPolicy Bypass -Scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/scoop-install.ps1')
scoop bucket add extras

# Installs needed scoop packages
scoop install mingit
scoop install vcredist2019
scoop install windows-terminal
scoop install starship
scoop install neovim

# Installs firacode nerd font
Invoke-WebRequest -OutFile ~/AppData/Local/Microsoft/Windows/Fonts/FiraCode-Regular.ttf

# Configures windows terminal
Invoke-WebRequest -OutFile "~\AppData\Local\Microsoft\Windows Terminal\settings.json"
((Get-Content -path powershell-config.json -Raw) -replace '1433642','username') | Set-Content -Path powershell-config.json
# Installs bugn into startup
Invoke-WebRequest -OutFile "~/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"
Write-Output "The script has completed! Check the README to find out how to use this software"
