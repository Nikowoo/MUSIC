$url = "https://nikowoo.github.io/MUSIC/gecs2.mp3"
$tmp = "$env:TEMP\__snd.mp3"
(New-Object System.Net.WebClient).DownloadFile($url, $tmp)
$vbs = "$env:TEMP\__play.vbs"
@"
Dim mp
Set mp = CreateObject("WMPlayer.OCX")
mp.URL = "$tmp"
mp.controls.play
Do While mp.playState <> 1
    WScript.Sleep 500
Loop
WScript.Sleep 1000
"@ | Set-Content $vbs -Encoding ASCII
Start-Process cscript.exe -ArgumentList "//Nologo //B `"$vbs`"" -WindowStyle Hidden
& "$env:SystemRoot\System32\logoff.exe"
