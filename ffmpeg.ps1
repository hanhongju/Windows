# 内挂eng.srt和chs.srt字幕进input.mp4，输出output.mkv
ffmpeg   -i input.mp4    -i eng.srt     -i chs.srt   -c copy   -map 0:v   -map 0:a   -map 1   -map 2   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chs   output.mkv

# 内挂chs.srt字幕进input.mp4，输出output.mkv
ffmpeg   -i input.mp4    -i chs.srt     -c copy   -metadata:s:s:0 language=chs   output.mkv

# 内挂eng.srt和chs.srt字幕进input.mp4，输出output.mp4
ffmpeg   -i input.mp4    -i eng.srt     -i chs.srt   -c:v copy   -c:a copy   -c:s mov_text   -map 0:v   -map 0:a   -map 1:s   -map 2:s   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chs   output.mp4

# 烧录chs.srt字幕进input.mp4，输出output.mp4
ffmpeg   -i input.mp4    -c:a copy      -vf  subtitles=chs.srt:force_style='FontSize=9'   output.mp4

# 提取input.mkv的字幕文件，输出到output.srt
ffmpeg   -i input.mkv    -map 0:s:0     output0.srt
ffmpeg   -i input.mkv    -map 0:s:1     output1.srt

# 提取input.mp4的字幕文件，输出到output.srt
ffmpeg   -i input.mp4    -map 0:s:0     output0.srt
ffmpeg   -i input.mp4    -map 0:s:1     output1.srt

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
