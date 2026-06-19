# ナレーション入りMP4をWeb用に圧縮（VLC・音声込み）
# VLCはスペース入りパスを嫌うため、変換はデスクトップ直下(ASCII)で行う
$ErrorActionPreference = 'Stop'
$repo = 'C:\Users\sahib\Desktop\Claude\Onevio Lp\Onevio_ORDIA_LP'
$desk = 'C:\Users\sahib\Desktop'

# 変換元＝リポジトリ内で最大のmp4（出力候補は除外）
$src = Get-ChildItem -LiteralPath $repo -Filter *.mp4 |
  Where-Object { $_.Name -ne 'ordia_video.mp4' -and $_.Name -ne 'ORDIA_explainer_h264.mp4' } |
  Sort-Object Length -Descending | Select-Object -First 1
Write-Output ('source: ' + $src.Name + '  ' + [math]::Round($src.Length/1MB,2) + 'MB')

$srcCopy = Join-Path $desk 'ordia_src.mp4'
Copy-Item $src.FullName $srcCopy -Force
Write-Output ('copied: ' + [math]::Round((Get-Item $srcCopy).Length/1MB,2) + 'MB')

$out = Join-Path $desk 'ordia_video.mp4'
if (Test-Path $out) { Remove-Item $out -Force }

$vlc = 'C:\Program Files\VideoLAN\VLC\vlc.exe'
$sout = '--sout=#transcode{vcodec=h264,vb=2000,acodec=mp4a,ab=128,channels=2,samplerate=44100}:standard{access=file,mux=mp4,dst=' + $out + '}'
$argList = @('-I','dummy','--no-repeat','--no-loop','--play-and-exit', $srcCopy, $sout, 'vlc://quit')

Write-Output 'compressing...'
& $vlc @argList
Start-Sleep -Seconds 2

if (Test-Path $out) {
  $dst = Join-Path $repo 'ordia_video.mp4'
  Copy-Item $out $dst -Force
  Write-Output ('OUTPUT: ' + $dst + '  ' + [math]::Round((Get-Item $dst).Length/1MB,2) + 'MB')
} else { Write-Output 'OUTPUT: not created' }

Remove-Item $srcCopy -Force -ErrorAction SilentlyContinue
Write-Output 'DONE'
