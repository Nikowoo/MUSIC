# LogoutUser.ps1
# Plays an audio file from a URL, then logs out the current user silently in the background

Add-Type -AssemblyName presentationCore

$url = "https://nikowoo.github.io/MUSIC/gecs.mp3"

$mediaPlayer = New-Object System.Windows.Media.MediaPlayer
$mediaPlayer.Open([uri]$url)
$mediaPlayer.Play()

# Wait 2 seconds for media to load so duration becomes available
Start-Sleep -Seconds 2

$duration = $mediaPlayer.NaturalDuration
if ($duration.HasTimeSpan) {
    Start-Sleep -Seconds ([math]::Ceiling($duration.TimeSpan.TotalSeconds))
} else {
    Start-Sleep -Seconds 30  # fallback if duration not available
}

$mediaPlayer.Stop()
$mediaPlayer.Close()

# Log out silently
logoff
