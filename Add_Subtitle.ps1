# 任意格式字幕用mkv封装
ffmpeg   -i input.mp4   -i eng.srt   -i chs.srt   -c copy   -map 0:v   -map 0:a   -map 1   -map 2   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chs   output.mkv


ffmpeg   -i input.mp4   -i chs.srt   -c copy   -metadata:s:s:0 language=eng   output.mkv


# 提取字幕文件
ffmpeg   -i output.mkv   -c:s copy   output.srt


# srt字幕用mp4封装
ffmpeg   -i input.mp4   -i eng.srt   -i chs.srt   -c:v copy   -c:a copy   -c:s mov_text   -map 0:v   -map 0:a   -map 1:s   -map 2:s   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chs   output.mp4




# 参考文献 https://zhuanlan.zhihu.com/p/677539095
# 参考文献 https://zhuanlan.zhihu.com/p/1933086439920374147
