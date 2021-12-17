# Linuxize Your PC

## Preface

This guide will require you to use PowerShell.
I'll guide you through the way though so don't worry if you don't have
experienceor aren't "Tech literate". Also as I've stated in the license just
don't be stupid. You can follow these steps by simply opening up PowerShell (you
can search for PowerShell in Windows search) and copy and pasting the commands below.

## Install Instructions

1. Change into your home directory

```powershell
Set-Location $env:userprofile
```

2. Set the execution policy in PowerShell to allow you to run scripts from the
git repository. If a prompt appears, type `A` and press enter.

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

3. Run my modified installer

```powershell
iwr -useb https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/src/powershell/scoop-install.ps1 | iex
```

4. Open the ttf file for FiraCode nerdfont through PowerShell. You will see a
button that says `install`. Click that button to install the font to your user fonts.

```powershell
Start-Process $env:userprofile\Downloads\FiraCode-NF.ttf
```

5. Enter the current version of PowerShell installed with scoop

```powershell
pwsh -NoProfile
```

6. Allow for the execution of scripts such as the PowerShell startup script.
If a prompt appears, type `A` and press enter.

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

7. Open windows terminal (pin it to the task-bar so that you can find it easily later).

```powershell
wt
```

## Features

### Scoop package manager

Scoop is a package manager for Windows. It has very similar functionality to APT
on Debian or Brew on Mac. The difference between scoop and these other package
managers is that scoop installs packages directly to your ~/scoop directory.
Therefore it doesn't require you to have admin rights to install software. If
you've never used a package manager before here's a brief introduction.

Suppose you want to install Google Chrome. Conventionally you would follow these
steps:
1. Open Edge and search for "Google Chrome" in the search bar.
2. Click on the first link that pops up
3. Realize that the first result was actually an ad and click
on the second link.
4. Click on the `download` button and uncheck all the software
you don't need.
5. Click the second download button on the select screen.
6. Wait for the program to download
7. Double click on the executable file
8. Wait for chrome to extract from the executable.

Using scoop, the chrome installation process is this.

```powershell
scoop install googlechrome
```

This is an example of how a quite annoying and insecure
process (how do you know that the site you downloaded
from is the real site and not a fishing/malware site?) can be simplified by
using a package manager.

In order to find software with scoop type

```powershell
scoop-search software
```

to find out if scoop has a version of that
software available. If it does type

```powershell
scoop install software
```

To learn more about scoop visit [scoop](https://scoop.sh/)

### Customized Neovim

During the install process my vim config and plugins are installed.
Neovim is very good editor originally based on Bill Joy's VI. Because
Neovim is based on the VI editor which was designed to work on computers
in the 1980's, it is extremely lightweight and perfect for school machines.
Neovim is a very ergenomic editor that uses keyboard shortcuts rather than
a mouse. If you wish to learn how to use neovim enter this command into
PowerShell to open the vim tutorial.

```powershell
nvim -c "Tutor"
```

You can learn more about Neovim and what diffrentiates it from other versions
of VI at the [neovim](https://neovim.io/doc/user/) official docs.

### Updated Java

School computers come installed with a version of the JRE (Java Runtime Environment).
This version of the JRE is often massively out of date and lacks the features of
the full JDK (Java Development Kit) which includes various utilities to help
Java programmers compile, debug, and run their code. The PowerShell startup
script installed during the installation process has utilities to compile and
run Java class files. To compile and run a Java file enter this command into
Powershell.

```powershell
jc File.java
```

### PowerShell YouTube

The command line version of youtube that I created has various utilities to
watch youtube videos. It also has the added benefit of allowing you to watch
videos without ads and to bypass google admin blocks on videos when you are
not on school wifi. To watch YouTube enter the following command into
PowerShell

```powershell
yt
```

You will then be prompted to search for a YouTube video. Once you enter a query
you will be given up to 20 results. Enter the number of the result you wish to
view and the video will launch (because school computers are slow it may take a
few seconds for the video to load.

## External software installed by this guide

The following software is installed by default by the scoop-install script:
mingit
aria2
ffmpeg
nodejs
openjdk
curl
windows-terminal
neovim
autohotkey
pwsh
figlet
rainbow
yt-dlp
mpv
youtube-dl
python
scoop-search

## Q&A

### Why does PowerShell give me errors when I run the scoop-install script?

There is one primary reason why you will receive errors when running the script.
Before you download the config files for MPV, Vim, and Windows-Terminal, the
directories wherein they reside must exist. Therefore as a precautionary measure
before the download of any config files a directory is created with the `mkdir`
command. If the directory happens to exist already then PowerShell will give you
an error and then continue executing the rest of the script.

### Why did you create this project?

I created this project originally for myself. I wanted to have a convenient way
to have all the Unix utilities I was used to on a school laptop. Creating these
simplified instructions was no easy task. It took weeks of finding ways to get
around blocks and install software without using admin rights. Overtime the
instructions have become easier to follow and less verbose. In the future the
instructions may become even shorter, though I doubt that they may become shorter
than they currently are without diminishing returns.

### Is installing this illegal/does this contain viruses?

Short answer: no.
Long answer: This project does not contain any proprietary or copyrighted code.
In my personal opinion code and algorithms should not even count as intellectual
property but that's a story for another time. This installation guide and the
programs that are installed with it are all open source so you can simply look
over the source code if you wish to find if they have viruses. If you don't know
how to program or don't want to manually verify that the code is virus free
then you may feel confident in the fact that thousands of uber-nerds have viewed
and sent bug-fixes to the programs installed by this guide and if they wished
to place some sort of machine-crippling virus in their programs they would have
to keep all of the malicious code in plain site in front of said uber-nerds.

### I have your IP address and I am going to report you

This would only be a threat if I wasn't using NordVPN. NordVPN is a Virtual Private Network with over 5000+ servers in 60 countries! It allows you to access Geolocked content and stay safer online. Enter code INTERNETHISTORIAN for 73% off a 2 year plan! or go to [https://nordvpn.com/internethistorian](https://nordvpn.com/internethistorian)
