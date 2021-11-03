$env:path += ";$env:userprofile\node_modules\.bin"
$env:path += ";$env:userprofile\Code\powershell"
$env:path += ";$env:userprofile\scoop\apps\python\current\Scripts"
Set-Alias -Name java -Value "$env:userprofile\scoop\apps\openjdk\current\bin\java.exe" -Scope Global

# Edit important files
function global:vc { nvim $env:userprofile\AppData\Local\nvim\init.vim }
function global:pc { nvim $env:userprofile\Code\powershell\p.ps1 }

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
	Remove-Item "$basefile.class"
	javac $filename
	java $basefile
}

# Search Youtube and return video url
function global:syt {
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string] $query
	)
	$GoogleApiKey = "AIzaSyARpjRn7-t39LyzGTSgoiPZcU8QVA7fi0I"
	$searchUri = "https://www.googleapis.com/youtube/v3/search?q=`"$query`"&key=$GoogleApiKey&maxResults=20&part=snippet&type=video"
	$response = Invoke-RestMethod -Uri $searchUri -Method Get
	for ( $i = 1; $i -le $response.items.count; $i++ ) {
		Write-Host "$i. $($response.items[$i-1].snippet.title)" -ForegroundColor Cyan
	}
	$Selection = Read-Host "Selection"
	if ($Selection -ge 0 -and $Selection -lt 21) {
		return "https://youtube.com/watch?v=$($response.items[$selection - 1].id.videoId)"
	}
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
			$selection = syt $search
			if ($selection) {
				mpv $selection
			}
		}
	} while (!($search.equals("exit")))
}

# Changes directory and displays greeting
Set-Location $env:userprofile
figlet "PowerShell Advanced" | rainbow
