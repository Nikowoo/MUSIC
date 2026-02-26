# If not running in STA mode, relaunch self in STA (required for MediaPlayer)
if ([System.Threading.Thread]::CurrentThread.ApartmentState -ne 'STA') {
    $script = $MyInvocation.MyCommand.Path
    if ($script) {
        Start-Process powershell.exe -ArgumentList "-STA -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$script`"" -WindowStyle Hidden
    } else {
        $tmp = "$env:TEMP\__logout_sta.ps1"
        $MyInvocation.ScriptName | Out-Null
        $content = @'
Add-Type -AssemblyName presentationCore
$url = "https://nikowoo.github.io/MUSIC/gecs.mp3"
$mp = New-Object System.Windows.Media.MediaPlayer
$mp.Open([uri]$url)
$mp.Play()
Start-Sleep -Seconds 2
$d = $mp.NaturalDuration
if ($d.HasTimeSpan) { Start-Sleep -Seconds ([math]::Ceiling($d.TimeSpan.TotalSeconds)) } else { Start-Sleep -Seconds 30 }
$mp.Stop()
$mp.Close()
logoff
'@
        $content | Set-Content $tmp -Encoding UTF8
        Start-Process powershell.exe -ArgumentList "-STA -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$tmp`"" -WindowStyle Hidden
    }
    exit
}

Add-Type -AssemblyName presentationCore
$url = "https://nikowoo.github.io/MUSIC/gecs.mp3"
$mp = New-Object System.Windows.Media.MediaPlayer
$mp.Open([uri]$url)
$mp.Play()
Start-Sleep -Seconds 2
$d = $mp.NaturalDuration
if ($d.HasTimeSpan) { Start-Sleep -Seconds ([math]::Ceiling($d.TimeSpan.TotalSeconds)) } else { Start-Sleep -Seconds 30 }
$mp.Stop()
$mp.Close()
logoff
