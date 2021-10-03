$env:path += ';C:\Users\1433642\busybox'
$env:path += ';C:\Users\1433642\scoop\apps\python\3.9.7\Scripts'
Set-Alias -Name java -Value "C:\Users\1433642\scoop\apps\openjdk\current\bin\java.exe" -Scope Global

# Edit important files
function global:vc {nvim C:\Users\1433642\AppData\Local\nvim\init.vim}
function global:vp {nvim C:\Users\1433642\AppData\Local\nvim\vim-plug\plugins.vim}
function global:pc {nvim C:\Users\1433642\Powershell\p.ps1}
function global:bc {nvim C:\Users\1433642\AppData\Roaming\bug.n\Config.ini}

# Listen to your playlist in ~/Music on the command line
function global:music {mpv C:\Users\1433642\Music --shuffle --no-audio-display}

# Removes powershell unix aliases
Remove-Alias cat -Scope Global
Remove-Alias clear -Scope Global
Remove-Alias cp -Scope Global
Remove-Alias echo -Scope Global
Remove-Alias ls -Scope Global
Remove-Alias man -Scope Global
Remove-Alias mv -Scope Global
Remove-Alias ps -Scope Global
Remove-Alias pwd -Scope Global
Remove-Alias rm -Scope Global
Remove-Alias rmdir -Scope Global

# Compile java files
function global:jc {
    param (
    $filename
          )
    javac $filename
    java $(basename $filename .java)
}

# Changes directory and displays greeting
Set-Location C:\Users\$env:username
Invoke-Expression (&starship init powershell)
