# 任意格式字幕用mkv封装
ffmpeg   -i input.mp4   -i eng.srt   -i chs.srt   -c copy   -map 0:v   -map 0:a   -map 1   -map 2   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chs   output.mkv


ffmpeg   -i input.mp4   -i chs.srt   -c copy   -metadata:s:s:0 language=chs   output.mkv


# srt字幕用mp4封装
ffmpeg   -i input.mp4   -i eng.srt   -i chs.srt   -c:v copy   -c:a copy   -c:s mov_text   -map 0:v   -map 0:a   -map 1:s   -map 2:s   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chs   output.mp4


# 提取字幕文件
ffmpeg   -i output.mkv   -c:s copy   output.srt


# 将mp4容器中的视频转为AVC编码
ffmpeg   -i input.mp4   -c:v libx264   output.mp4


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
