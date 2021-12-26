# Linuxize Your PC

## Preface

This guide will require you to use PowerShell. You can follow these steps by
opening an instance of PowerShell (look up PowerShell in Windows search) and
copy and pasting the commands below.

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

3. Run my modified installer. This may take a few minutes, especially if you have
a slow computer/internet connection.

```powershell
iwr -useb https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/src/powershell/scoop-install.ps1 | iex
```

4. Open the ttf file for FiraCode nerdfont through PowerShell. You will see a
button that says `install`. Click that button to install the font to your user fonts.

```powershell
Start-Process $env:userprofile\Downloads\FiraCode-NF.ttf
```

5. Enter the current version of PowerShell installed with Scoop.

```powershell
pwsh -NoProfile
```

6. Allow for the execution of scripts such as the PowerShell startup script.
If a prompt appears, type `A` and press enter.

```powershell
Set-ExecutionPolicy Bypass -Scope CurrentUser
```

7. Open Windows-Terminal (pin it to the task-bar so that you can find it easily later).

```powershell
wt
```

## Features

### Scoop Package Manager

Scoop is a package manager for Windows. It has very similar functionality to APT
on Debian or Brew on Mac. The difference between Scoop and these other package
managers is that Scoop installs packages directly to your ~/scoop directory.
Therefore, it doesn't require you to have admin rights to install software. If
you've never used a package manager before here's a brief introduction.

Suppose you want to install Google Chrome. You would follow these
steps:

1. Open Edge and search for "Google Chrome" in the search bar.
2. Click on the first link that pops up.
3. Realize that the first result was actually an ad and click
on the second link.
4. Click on the `download` button and uncheck all the software
you don't need.
5. Click the second download button on the select screen.
6. Wait for the program to download.
7. Double click on the executable file.
8. Wait for Chrome to extract from the executable.

Using Scoop, the Chrome installation process is this.

```powershell
scoop install googlechrome
```

This is an example of how a quite annoying and insecure
process (how do you know that the site you downloaded
from is the real site and not a fishing/malware site?) can be simplified by
using a package manager.

In order to find software with Scoop type

```powershell
scoop-search software
```

to find out if Scoop has a version of that
software available. If it does, enter this command.

```powershell
scoop install software
```

To learn more about Scoop, visit the [Scoop](https://scoop.sh/) docs.

### Customized Neovim

During the install process my Vim config and plugins are installed.
Neovim is an editor originally based on Bill Joy's VI. Because
Neovim is based on the VI editor which was designed to work on computers
in the 1980's, it is extremely lightweight and perfect for school machines.
Neovim is a very ergonomic editor that uses keyboard shortcuts rather than
a mouse. If you wish to learn how to use Neovim enter this command into
PowerShell to open the Vim tutorial.

```powershell
nvim -c "Tutor"
```

You can learn more about Neovim and what differentiates it from other versions
of VI at the [neovim](https://neovim.io/doc/user/) official docs.

### Updated Java

School computers come installed with a version of the JRE (Java Runtime Environment).
This version of the JRE is often massively out of date and lacks the features of
the full JDK (Java Development Kit), which includes various utilities to help
Java programmers compile, debug, and run their code. The PowerShell startup
script installed during the installation process has utilities to compile and
run Java class files. To compile and run a Java file enter this command into
PowerShell.

```powershell
jc File.java
```

### PowerShell YouTube

The command line version of YouTube that I created has various utilities to
watch YouTube videos. It also has the added benefit of allowing you to watch
videos without ads and to bypass google admin blocks on videos when you are
not on school WiFi. To watch YouTube enter the following command into
PowerShell

```powershell
yt
```

You will then be prompted to search for a YouTube video. Once you enter a query
you will be given up to 20 results. Enter the number of the result you wish to
view and the video will launch (because school computers are slow it may take a
few seconds for the video to load). If you're curious about the specs of the program
this is what goes on behind the scenes:

1. The query entered by the client is made URL-safe and sent to Google's search API.
2. Google's API sends back a JSON file which has information on 20 videos which are
relevant to the query.
3. These videos are formatted automatically with a PowerShell table that shows the
videos' name, channel, and a number reference.
4. The client enters the number of the video they wish to watch into the program.
5. The program supplies the URL of the video that the client selected to MPV.
6. MPV uses YouTube-DL to download the video to cache.
7. The video is shown to the user through MPV.
8. The video exits when finished or when the client exits the video.
9. The client is again prompted to enter a query and the process starts again.

### Convert Code to PDF

In the PowerShell startup script (`p.ps1`), there is a function called
`code2pdf`. This function allows you to convert any plaintext file (text files,
source code, markdown, etc) into a PDF. The PDF will look exactly as it does
when you open it in Neovim. To convert source code into a PDF, enter this
command into PowerShell.

```powershell
code2pdf File.ext
```

### Code Projects

#### Creating Projects
A code project is a directory that is formatted in a professional way to allow
you to work on various source code files that comprise a single git repository.
Inside the PowerShell startup script there are various functions that may be
used to create and compile code within a project. A code project typically is
comprised of various directories for code testing, releases, and binaries.
These directories can be created automatically with the `mproj` command. To
create a code project enter this command.

```powershell
mproj ProjectName
```

This creates the following directory structure.

```
ProjectName
|   .gitignore
|   LICENSE
|   README.md
|
+---bin
\---src
    +---main
    |   \---resources
    \---test
        \---resources
```

You must separate your code by coding language. For example if you were writing
Java code in your project the source file would either have to be in
`ProjectName/src/main/java/` or `ProjectName/src/test/java/`.

#### Compile Java

To compile and run a Java class file within the project you may use the `jp`
command.

```powershell
jp File.java
```

#### Compile C and C++
Support for compiling C and C++ code requires you to install GCC and G++. You
can do this with Scoop by running this command.

```powershell
scoop install mingw-nuwen
```

To compile and run a C source code file run the `cc` command.

```powershell
cc File.c
```

To compile and run a C++ source code file run the `ccpp` command.

```powershell
ccpp File.cpp
```
### FiraCode Nerd Font

The font `FiraCode` is installed by the scoop-install script. FiraCode allows
for the display of nerd characters and coding ligatures. To learn about
FiraCode you can visit the [FiraCode homepage](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode).

### AutoHotKey Remaps

Inside the `/src/ahk/` directory of the repository, there is a script called
`remaps.ahk`. Within that script there are three keys that have been remapped.
The first remap is a switch of the `ESC` and `CAPSLOCK` keys. This is especially
helpful for using VI, where the `ESC` key is used to go into normal mode (which
you will use quite often) and the `CAPSLOCK` key will make the commands within VI
act in a peculiar way (`j` goes down one line but `J` concatenates two lines).
The other part of the script maps `ALT`+`1` to open Google Chrome and `ALT`+`2` to
open Windows-Terminal. To use the script, compile it with ahk2exe and output the
binary to your startup directory (this is typically
`C:\Users\Username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`).

## External Software Installed by This Guide

The following software is installed by the scoop-install script (in
order of installation):

- mingit
- aria2
- ffmpeg
- nodejs
- openjdk
- curl
- windows-terminal
- neovim
- autohotkey
- pwsh
- figlet
- rainbow
- yt-dlp
- mpv
- youtube-dl
- python
- scoop-search
- wkhtmltopdf

You can view the homepages of these programs by using the scoop home command.

```powershell
scoop home software
```

## Q&A

### Why Does PowerShell Give Me Errors When I Run the scoop-install Script?

There is one primary reason why you will receive errors when running the script.
Before you download the config files for MPV, Vim, and Windows-Terminal, the
directories wherein they reside must exist. Therefore as a precautionary measure
before the download of any config files a directory is created with the `mkdir`
command. If the directory happens to exist already then PowerShell will give you
an error, and then it will continue executing the rest of the script.

### Why Did You Create This Project?

I created this project originally for myself. I wanted to have a convenient way
to have all the Unix utilities I was used to on a school laptop. Creating these
simplified instructions was no easy task. It took weeks of finding ways to get
around blocks and install software without using admin rights. Overtime, the
instructions have become easier to follow and less verbose. In the future the
instructions may become even shorter, though I doubt that they will become shorter
than they currently are without diminishing returns.

### Is Installing This Illegal/Does This Contain Viruses?

Short answer: No.

Long answer: This project does not contain any proprietary code. In my personal
opinion code and algorithms should not even count as intellectual property but
that's a story for another time. This installation guide and the programs that
are installed with it are all open source so you can simply look over the source
code if you wish to find if they have viruses. If you are not a programmer or
don't want to manually verify that the code is virus free then you may feel
confident in the fact that thousands of uber-nerds have viewed and sent
bug-fixes to the programs installed by this guide. If these programs wished to place
some sort of machine-crippling virus in their programs they would have to keep
all of the malicious code in plain site in front of said uber-nerds.
