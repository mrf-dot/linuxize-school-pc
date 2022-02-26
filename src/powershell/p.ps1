# Turn off syntax highlighting
Set-PSReadLineOption -Colors @{
	Comment=$Host.UI.RawUI.ForegroundColor
	Keyword=$Host.UI.RawUI.ForegroundColor
	String=$Host.UI.RawUI.ForegroundColor
	Operator=$Host.UI.RawUI.ForegroundColor
	Variable=$Host.UI.RawUI.ForegroundColor
	Command=$Host.UI.RawUI.ForegroundColor
	Parameter=$Host.UI.RawUI.ForegroundColor
	Type=$Host.UI.RawUI.ForegroundColor
	Number=$Host.UI.RawUI.ForegroundColor
	Member=$Host.UI.RawUI.ForegroundColor
}

# Adds directories to path
$env:path += ";$env:userprofile\scoop\apps\openjdk\current\bin"
$env:path += ";$env:userprofile\node_modules\.bin"
$env:path += ";$env:userprofile\scoop\apps\python\current\Scripts"

# Set aliases
Set-Alias -Name java -Value "$env:userprofile\scoop\apps\openjdk\current\bin\java.exe" -Scope Global

# Edit important files
function global:vc { nvim $env:userprofile\AppData\Local\nvim\init.vim }
function global:pc { nvim $env:userprofile\p.ps1 }
function global:mpvc { nvim $env:userprofile\scoop\persist\mpv\portable_config\mpv.conf }

# View command history
function global:hist { Get-Content (Get-PSReadlineOption).HistorySavePath | less }
# Enter the gpa program without changing directories
function global:gpa {
	Set-Location "$env:userprofile\Code\personal\src\main\python"
	python gpa_calc.py
	Set-Location -
}

# Show all 256ansi colors
# from https://duffney.io/usingansiescapesequencespowershell/
function global:colors {
	$esc=$([char]27)
	echo "`n$esc[1;4m256-Color Foreground & Background Charts$esc[0m"
	foreach ($fgbg in 38,48) {  # foreground/background switch
	  foreach ($color in 0..255) {  # color range
	    #Display the colors
	    $field = "$color".PadLeft(4)  # pad the chart boxes with spaces
	    Write-Host -NoNewLine "$esc[$fgbg;5;${color}m$field $esc[0m"
	    #Display 6 colors per line
	    if ( (($color+1)%6) -eq 4 ) { echo "`r" }
	  }
	  echo `n
	}
}

# Compile ms documents with groff
function global:groff {
	param (
		$filename
	)
	$basefile = [System.IO.Path]::GetFileNameWithoutExtension($filename)
	$filename = [System.IO.Path]::GetFileName($filename)
	Remove-Item "$basefile.pdf" -ErrorAction Ignore
	msys2 -c "tr -d '\015' < $filename > tmp.$filename && grog -Tpdf tmp.$filename --run > $basefile.pdf && rm tmp.$filename"
	Start-Process "$basefile.pdf"
}

# View manpages
function global:m {
	param (
		$manpage
	)
	msys2 -c "man $manpage"
}

# Play music on the command line
function global:music {
	param (
		$playlist
	)
	mpv $env:userprofile\Music\$playlist --shuffle --no-video --no-resume-playback
}

# Compile Java files in a project
function global:jp {
	param (
		$filename
	)
	$basefile = [System.IO.Path]::GetFileNameWithoutExtension($filename)
	$classpath = "../../../bin"
	mkdir $classpath -ErrorAction Ignore
	Remove-Item "$classpath/$basefile.class" -ErrorAction Ignore
	javac -d $classpath $filename
	java -cp $classpath $basefile
}

# Compile C files in a project
function global:cc {
	param (
		$filename
	)
	$basefile = [System.IO.Path]::GetFileNameWithoutExtension($filename)
	$classpath = "../../../bin"
	mkdir $classpath -ErrorAction Ignore
	Remove-Item "$classpath/$basefile.exe" -ErrorAction Ignore
        gcc "$basefile.c" -Og -o "$classpath/$basefile.exe"
        pwsh -NoProfile -c "$classpath/$basefile"
}

# Compile C++ files in a project
function global:ccpp {
	param (
		$filename
	)
	$basefile = [System.IO.Path]::GetFileNameWithoutExtension($filename)
	$classpath = "../../../bin"
	mkdir $classpath -ErrorAction Ignore
	Remove-Item "$classpath/$basefile.exe" -ErrorAction Ignore
        g++ "$basefile.cpp" -o "$classpath/$basefile.exe"
        pwsh -NoProfile -c "$classpath/$basefile"
}

# Compile java files
function global:jc {
	param (
		$filename
	)
	$basefile = [System.IO.Path]::GetFileNameWithoutExtension($filename)
	Remove-Item "$basefile.class" -ErrorAction Ignore
	javac $filename
	java $basefile
}

# Create a code project
function global:mproj {
	param (
		$projectName
	)
	if (mkdir $projectName) {
		Set-Location $projectName
		New-Item README.md -Value "# $projectName"
		New-Item LICENSE
		New-Item .gitignore -value "bin/"
		mkdir bin/
		mkdir src/main/resources
		mkdir src/test/resources
		git init
	}
}

# Define your google api key here
$env:GoogleApiKey = "AIzaSyARpjRn7-t39LyzGTSgoiPZcU8QVA7fi0I"

# Search Youtube and return video url
function global:syt {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string] $query
	)
	$query = $query -replace '\s+', '+'
	$searchUri = "https://www.googleapis.com/youtube/v3/search?q=$query&key=$env:GoogleApiKey&maxResults=20&part=snippet&type=video"
	$response = Invoke-RestMethod -Uri $searchUri -Method Get
	# Creates table of result number, video title, and channel
	$tbl = New-Object System.Data.DataTable "Search Results"
	$col0 = New-Object System.Data.DataColumn Result
	$col1 = New-Object System.Data.DataColumn Title
	$col2 = New-Object System.Data.DataColumn Channel
	$tbl.columns.add($col0)
	$tbl.columns.add($col1)
	$tbl.columns.add($col2)
	for ( $i = 1; $i -le $response.items.count; $i++ ) {
		$row = $tbl.NewRow()
		$row.Result = $i
		$row.Title = [System.Net.WebUtility]::HtmlDecode($response.items[$i - 1].snippet.title)
		$row.Channel = [System.Net.WebUtility]::HtmlDecode($response.items[$i - 1].snippet.channeltitle)
		$tbl.rows.add($row)
	}
	$tbl | Format-Table | Out-Host
	# Loops through number until input is correct
	do {
		try {
			$isNum = $true
			$Selection = Read-Host "Selection #"
			if ($Selection) {
				[int]$Selection = $Selection
			}
			else {
				return ""
			}
		}
		catch {
			$isNum = $false
		}
	} until ($Selection -ge 1 -and $Selection -le $response.items.count -and $isNum)
	return "https://youtube.com/watch?v=$($response.items[$selection - 1].id.videoId)"
}

function global:syp {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string] $query
	)
	$query = $query -replace '\s+', '+'
	$searchUri = "https://www.googleapis.com/youtube/v3/search?q=$query&key=$env:GoogleApiKey&maxResults=5&part=snippet&type=playlist"
	$response = Invoke-RestMethod -Uri $searchUri -Method Get
	# Creates table of result number, video title, and channel
	$tbl = New-Object System.Data.DataTable "Search Results"
	$col0 = New-Object System.Data.DataColumn Result
	$col1 = New-Object System.Data.DataColumn Title
	$tbl.columns.add($col0)
	$tbl.columns.add($col1)
	for ( $i = 1; $i -le $response.items.count; $i++ ) {
		$row = $tbl.NewRow()
		$row.Result = $i
		$row.Title = [System.Net.WebUtility]::HtmlDecode($response.items[$i - 1].snippet.title)
		$tbl.rows.add($row)
	}
	$tbl | Format-Table | Out-Host
	# Loops through number until input is correct
	do {
		try {
			$isNum = $true
			$Selection = Read-Host "Selection #"
			if ($Selection) {
				[int]$Selection = $Selection
			}
			else {
				return ""
			}
		}
		catch {
			$isNum = $false
		}
	} until ($Selection -ge 1 -and $Selection -le $response.items.count -and $isNum)
	return "https://youtube.com/playlist?list=$($response.items[$selection - 1].id.playlistId)"
}

# Download music from youtube to music directory
function global:yaudio {
	param (
		[string] $url,
		[string] $playlist
	)
	if ($url) {
		yt-dlp $url -i --restrict-filenames --extract-audio --audio-format mp3 --audio-quality 0 -o $env:USERPROFILE/music/$playlist/"%(title)s.(ext)s"
	}
}

# Download youtube url to videos directory
function global:youtube {
	param (
		[string] $url
	)
	if ($url) {
		yt-dlp $url --restrict-filenames -o "$env:userprofile/Videos/%(title)s.%(ext)s" --all-subs -f "bv[height<=?1080][fps<=?30]+ba"
	}
}

function global:dya {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string] $query,
		[Parameter(Mandatory = $true, Position = 1)]
		[string] $folder
		)
	yaudio $(syp $query) $folder
}

function global:dyt {
	youtube $(syt)
}

# Watch youtube videos over command line
function global:yt {
	$search = ""
	do {
		$query = Read-Host "Search for a video"
		if ($query) {
			$search = $query
		}
		if ($search -and !($search.equals("exit"))) {
			$selection = $(syt $search)
			if ($selection) {
				mpv $selection --no-terminal
			}
		}
	} until ($search.equals("exit"))
}

# Convert any text to a formatted pdf
function global:code2pdf {
	param (
		$filename
	)
	$basefile = [System.IO.Path]::GetFileNameWithoutExtension($filename)
        nvim --headless -c "TOhtml | write! $basefile.tmp.html | quitall!" $filename
        wkhtmltopdf -q "$basefile.tmp.html" "$basefile.pdf"
        Remove-Item "$basefile.tmp.html"
        Start-Process "$basefile.pdf"
}

# Displays the Greek alphabet
function global:greek {
	Get-Content $env:userprofile/Documents/greek_alphabet.txt
}
