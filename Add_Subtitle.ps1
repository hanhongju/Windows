ffmpeg   -i input.mp4   -i eng.srt   -i chs.srt   -c copy   -map 0:v   -map 0:a   -map 1   -map 2   -metadata:s:s:0 language=eng   -metadata:s:s:1 language=chs   output.mkv




# 参考文献 https://zhuanlan.zhihu.com/p/677539095
