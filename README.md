# Linuxize Your School PC
## Preface
This guide will require you to use Powershell. I'll guide you through the way though so don't worry if you don't have experience or aren't "Tech literate". Also as I've stated in the license just don't be stupid and don't lead the school to take action. You can follow these steps by simply opening up powershell (you can just search for powershell in windows search) and copy and pasting the commands below.
## General Steps
### Install and configure scoop
1. Change into your home directory
```powershell
Set-Location $env:userprofile
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
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/p.ps1" -Outfile "$env:userprofile\p.ps1"
```
2. Download and install FiraCode to your user fonts by downloading the ttf file and starting it through powershell. You will see a button that says 'install'. Click that button to install the font to your user fonts.
```powershell
Invoke-WebRequest "https://github.com/mrf-dot/linuxize-school-pc/blob/main/FiraCode-NF.ttf?raw=true" -OutFile $env:userprofile/Downloads/FiraCode-NF.ttf
Start-Process $env:userprofile\Downloads\FiraCode-NF.ttf
```
3. Download my windows terminal profile to the windows-terminal profile directory
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/settings.json" -OutFile "$env:LocalAppData\Microsoft\Windows Terminal\settings.json"  
```
### Configure Neovim
1. Install vim-plug to use vim plugins like code completion and bracket matching
```powershell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```
2. Download my vim config (init.vim) to your ~/AppData/Local/nvim folder
```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/init.vim" -Outfile "$env:localappdata\nvim\init.vim"
```
3. Replace all instances of "username" in init.vim to your username
```powershell
((Get-Content -path $env:LocalAppData/nvim/init.vim -Raw) -replace 'username', "$env:username") | Set-Content -Path $env:LocalAppData/nvim/init.vim
```
## Afterword
Now your system is configured to be "advanced". Learn how to use [neovim](https://neovim.io/doc/user/) and [scoop](https://scoop.sh/) by reading their docs.
