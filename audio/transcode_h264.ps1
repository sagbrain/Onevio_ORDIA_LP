# 録画(HEVC)をH.264 MP4へ変換（VLC使用）
$ErrorActionPreference = 'Stop'
$doc = [Environment]::GetFolderPath('MyDocuments')
$recDir = Join-Path $doc 'CyberLink\ScreenRecorder\4.0'
Write-Output ("recDir: " + $recDir)

# 最新の.mp4を変換元にする
$src = Get-ChildItem -Path $recDir -Filter *.mp4 | Sort-Object LastWriteTime -Descending | Select-Object -First 1
Write-Output ("source: " + $src.FullName + "  " + [math]::Round($src.Length/1MB,2) + "MB")

# 完全化のためASCIIパスへコピー
$srcCopy = 'C:\Users\sahib\Desktop\ORDIA_src.mp4'
Copy-Item $src.FullName $srcCopy -Force
Write-Output ("copied to: " + $srcCopy + "  " + [math]::Round((Get-Item $srcCopy).Length/1MB,2) + "MB")

$out = 'C:\Users\sahib\Desktop\ORDIA_explainer_h264.mp4'
if (Test-Path $out) { Remove-Item $out -Force }

$vlc = 'C:\Program Files\VideoLAN\VLC\vlc.exe'
$sout = '--sout=#transcode{vcodec=h264,vb=8000,acodec=mp4a,ab=128,channels=2,samplerate=44100}:standard{access=file,mux=mp4,dst=' + $out + '}'
$argList = @('-I','dummy','--no-repeat','--no-loop','--play-and-exit', $srcCopy, $sout, 'vlc://quit')

Write-Output 'transcoding...'
& $vlc @argList
Start-Sleep -Seconds 2

if (Test-Path $out) {
  Write-Output ("OUTPUT: " + $out + "  " + [math]::Round((Get-Item $out).Length/1MB,2) + "MB")
} else {
  Write-Output 'OUTPUT: not created'
}
Write-Output 'DONE'
