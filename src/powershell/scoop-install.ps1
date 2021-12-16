# get core functions
$core_url = 'https://raw.githubusercontent.com/lukesampson/scoop/master/lib/core.ps1'
Write-Output 'Initializing...'
Invoke-Expression (new-object net.webclient).downloadstring($core_url)

# prep
if (installed 'scoop') {
    write-host "Scoop is already installed. Run 'scoop update' to get the latest version." -f red
    # don't abort if invoked with iex that would close the PS session
    if ($myinvocation.mycommand.commandtype -eq 'Script') { return } else { exit 1 }
}
$dir = ensure (versiondir 'scoop' 'current')

# download scoop zip
$zipurl = 'https://github.com/lukesampson/scoop/archive/master.zip'
$zipfile = "$dir\scoop.zip"
Write-Output 'Downloading scoop...'
dl $zipurl $zipfile

Write-Output 'Extracting...'
Add-Type -Assembly "System.IO.Compression.FileSystem"
[IO.Compression.ZipFile]::ExtractToDirectory($zipfile, "$dir\_tmp")
Copy-Item "$dir\_tmp\*master\*" $dir -Recurse -Force
Remove-Item "$dir\_tmp", $zipfile -Recurse -Force

Write-Output 'Creating shim...'
shim "$dir\bin\scoop.ps1" $false

# download main bucket
$dir = "$scoopdir\buckets\main"
$zipurl = 'https://github.com/ScoopInstaller/Main/archive/master.zip'
$zipfile = "$dir\main-bucket.zip"
Write-Output 'Downloading main bucket...'
New-Item $dir -Type Directory -Force | Out-Null
dl $zipurl $zipfile

Write-Output 'Extracting...'
[IO.Compression.ZipFile]::ExtractToDirectory($zipfile, "$dir\_tmp")
Copy-Item "$dir\_tmp\*-master\*" $dir -Recurse -Force
Remove-Item "$dir\_tmp", $zipfile -Recurse -Force

ensure_robocopy_in_path
ensure_scoop_in_path

scoop config lastupdate ([System.DateTime]::Now.ToString('o'))
success 'Scoop was installed successfully!'

Write-Output "Type 'scoop help' for instructions."

$erroractionpreference = $old_erroractionpreference # Reset $erroractionpreference to original value

# Install software automatically with scoop
scoop install mingit
scoop bucket add extras
scoop bucket add java
scoop install aria2
scoop install ffmpeg
scoop install nodejs
scoop install openjdk
scoop install curl
scoop install windows-terminal
scoop install neovim
scoop install autohotkey
scoop install pwsh
scoop install figlet
scoop install rainbow
scoop install yt-dlp
scoop install mpv
scoop install youtube-dl
scoop install python
scoop install scoop-search

# Install mpv config
mkdir $env:userprofile\scoop\persist\mpv\portable_config
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/src/conf/mpv.conf" -Outfile "$env:userprofile\scoop\persist\mpv\portable_config\mpv.conf"

# Install powershell startup script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/src/powershell/p.ps1" -Outfile "$env:userprofile\p.ps1"

# Install windows-terminal profile
mkdir "$env:LocalAppData\Microsoft\Windows Terminal"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/src/json/settings.json" -OutFile "$env:LocalAppData\Microsoft\Windows Terminal\settings.json"

# Install vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Install vim config
mkdir $env:LocalAppData/nvim
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mrf-dot/linuxize-school-pc/main/src/vimscript/init.vim" -Outfile "$env:localappdata\nvim\init.vim"

# Install all of the vim-plugins in my vim config
nvim -c "PlugInstall | quitall"

# Download FiraCode NF
Invoke-WebRequest "https://github.com/mrf-dot/linuxize-school-pc/blob/main/bin/FiraCode-NF.ttf?raw=true" -OutFile $env:userprofile/Downloads/FiraCode-NF.ttf
