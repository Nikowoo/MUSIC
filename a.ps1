Add-Type -AssemblyName presentationCore

$url = "https://nikowoo.github.io/MUSIC/gecs\2.mp3"

$mediaPlayer = New-Object System.Windows.Media.MediaPlayer
$mediaPlayer.Open([uri]$url)
$mediaPlayer.Play()
Start-Sleep -Seconds 0

$duration = $mediaPlayer.NaturalDuration
if ($duration.HasTimeSpan) {
    Start-Sleep -Seconds ([math]::Ceiling($duration.TimeSpan.TotalSeconds))
} else {
    Start-Sleep -Seconds 30 
}

$mediaPlayer.Stop()
$mediaPlayer.Close()
logoff
