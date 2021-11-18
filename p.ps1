# Adds directories to path
$env:path += ";$env:userprofile\node_modules\.bin"
$env:path += ";$env:userprofile\scoop\apps\python\current\Scripts"

# Set aliases
Set-Alias -Name java -Value "$env:userprofile\scoop\apps\openjdk\current\bin\java.exe" -Scope Global

# Edit important files
function global:vc { nvim $env:userprofile\AppData\Local\nvim\init.vim }
function global:pc { nvim $env:userprofile\p.ps1 }
function global:mpvc { nvim $env:userprofile\scoop\persist\mpv\portable_config\mpv.conf }

# Compile documents with groff
function global:groff {
	param (
	$filename
	      )
	$basefile = [System.IO.Path]::GetFileNameWithoutExtension($filename)
	msys2 -c "groff -ms -Tpdf $basefile.ms > $basefile.pdf"
	Start-Process "$basefile.pdf"
}

# View manpages
Remove-Alias -Name man -Scope Global
function global:man {
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
	mpv $env:userprofile\Music\$playlist --shuffle --no-audio-display
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

# Fizzbuzz implementation in powershell
function global:fizzbuzz {
	for ( $i = 1; $i -lt 101; $i++ ) {
		$FizzString = ""
		$FizzString += ($i % 3 -eq 0) ? "Fizz" : ""
		$FizzString += ($i % 5 -eq 0) ? "Buzz" : ""
		Write-Output $($FizzString.equals("") ? $i : $FizzString)
	}
}

# Search Youtube and return video url
function global:syt {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string] $query
	)
	$query = $query -replace '\s+', '+'
	$GoogleApiKey = "AIzaSyARpjRn7-t39LyzGTSgoiPZcU8QVA7fi0I"
	$searchUri = "https://www.googleapis.com/youtube/v3/search?q=$query&key=$GoogleApiKey&maxResults=20&part=snippet&type=video"
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
		$row.Title = [System.Net.WebUtility]::HtmlDecode($response.items[$i-1].snippet.title)
		$row.Channel = [System.Net.WebUtility]::HtmlDecode($response.items[$i-1].snippet.channeltitle)
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
			} else {
				return ""
			}
		}
		catch {
			$isNum = $false
		}

	} until ($Selection -ge 1 -and $Selection -le 20 -and $isNum)
	return "https://youtube.com/watch?v=$($response.items[$selection - 1].id.videoId)"
}

# Download music from youtube to music directory
function global:yaudio {
	param (
		[string] $url,
		[string] $playlist = "custom"
	)

	if ($url) {
		yt-dlp $url -i --extract-audio --audio-format mp3 --audio-quality 0 -o $env:USERPROFILE/music/$playlist/"%(title)s.(ext)s"
	}
}

# Download youtube url to videos directory
function global:youtube {
	param (
		[string] $url
	)
	if ($url) {
		yt-dlp $url -o "$env:userprofile/Videos/%(title)s.%(ext)s"
	}
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
				mpv $selection
			}
		}
	} while (!($search.equals("exit")))
}

# Changes directory and displays greeting
Set-Location $env:userprofile
figlet "PowerShell Advanced" | rainbow
