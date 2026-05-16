# 内挂eng.srt和chi.srt字幕进input.mp4，输出output.mp4
ffmpeg   -i input.mp4    -i eng.srt     -i chi.srt   -c copy   -c:s mov_text   -map 0   -map 1:s   -map 2:s   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chi   output.mp4

# 内挂chi.srt字幕进input.mp4，输出output.mp4
ffmpeg   -i input.mp4    -i chi.srt     -c copy      -c:s mov_text     -metadata:s:s language=chi     output.mp4

# 烧录chi.srt字幕进input.mp4，输出output.mp4
ffmpeg   -i input.mp4    -vf subtitles=chi.srt:force_style='FontSize=12'      -c:a copy      output.mp4

# 提取input.mp4的字幕文件，输出到output.srt
ffmpeg   -i input.mp4    -map 0:s:0     output0.srt
ffmpeg   -i input.mp4    -map 0:s:1     output1.srt

# 去除input.mp4的字幕文件，输出到output.mp4
ffmpeg   -i input.mp4    -c copy        -map 0:v     -map 0:a      output.mp4

# 将input.mp4中的视频转为AVC编码，输出到output.mp4
ffmpeg   -i input.mp4    -c:v libx264   output.mp4

# 使用ffmpeg将当前目录中的FLAC转换为WAV，需先将ffmpeg设置在系统环境变量PATH中
Set-Location   -Path   $PSScriptRoot
$Files = Get-ChildItem  -Filter  "*.flac"  -File
foreach ($File in $Files) {
    $inputFile   =   $File.FullName
    $outputFile  =   $File.BaseName  +  ".wav"
    ffmpeg  -i  $inputFile  $outputFile
}




# 参考文献 https://zhuanlan.zhihu.com/p/677539095
# 参考文献 https://zhuanlan.zhihu.com/p/1933086439920374147
