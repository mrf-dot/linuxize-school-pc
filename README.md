# Linuxize Your School PC
## Preface
This guide will require you to use Powershell. I'll guide you through the way though so don't worry if you don't have experience or aren't "Tech literate". Also as I've stated in the license just don't be stupid and don't lead the school to take action.
## General Steps
### Download Powershell
### Install and configure scoop
1. Change into your home directory
```powershell
cd ~
```
2. Set the execution policy in Powershell to allow you to run scripts regardless of if they were signed
```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```
3. Run my modified installer
```powershell
iwr -useb https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/scoop-install.ps1 | iex
```
### Configure Windows Terminal
1. Download my powershell startup script (p.ps1) to your home directory
```powershell
wget https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/powershell-startup.ps1 -O p.ps1
```
2. Download and install the FiraCode nerd font to your user fonts
```powershell
wget https://github.com/mrf-dot/linuxize-school-pc/blob/main/FiraCode-NF.ttf?raw=true -O AppData\Local\Microsoft\Windows\Fonts
```
3. Download the windows terminal config to the windows terminal config directory
```powershell
wget https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/powershell-config.json -O "AppData\Local\Microsoft\Windows Terminal\settings.json"
```
4. Replace all instances of the word "username" in my powershell config script to your username
```powershell
(Get-Content "AppData\Local\Microsoft\Windows Terminal\settings.json").replace('username', $env:username) | Set-Content "AppData\Local\Microsoft\Windows Terminal\settings.json"
```
### Install bugn
1. Download the bugn executable I compiled to your startup folder
```powershell
wget https://github.com/mrf-dot/linuxize-school-pc/blob/main/bugn.exe?raw=true -O "AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\bugn.exe"
```
2. Restart your computer for these changes to take effect
```powershell
Restart-Computer
```
## Afterword
Now your system is configured to be "advanced". Learn how to use [bugn](https://github.com/fuhsjr00/bug.n/wiki), [neovim](https://neovim.io/doc/user/), and [scoop](https://scoop.sh/) by reading their docs.
