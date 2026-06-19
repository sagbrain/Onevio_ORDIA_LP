Add-Type -AssemblyName System.Speech
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$utf8 = New-Object System.Text.UTF8Encoding($false)
$lines = [System.IO.File]::ReadAllLines((Join-Path $dir 'narration_lines.txt'), $utf8) | Where-Object { $_.Trim() -ne '' }

$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
try { $synth.SelectVoice('Microsoft Haruka Desktop') } catch { }
$synth.Rate = -1
$synth.Volume = 100

$i = 1
$all = ''
foreach ($line in $lines) {
  $out = Join-Path $dir ("scene{0:D2}.wav" -f $i)
  $synth.SetOutputToWaveFile($out)
  $synth.Speak($line)
  Write-Output ("generated: scene{0:D2}.wav" -f $i)
  $i++
  $all += $line + '   '
}

$synth.SetOutputToWaveFile((Join-Path $dir 'full.wav'))
$synth.Speak($all)
Write-Output 'generated: full.wav'

$synth.Dispose()
Write-Output 'DONE'
