


# 设置环境变量
$envName = "ffmpeg"
$envValue = "C:\Users\hj\Downloads\ffmpeg-master-latest-win64-gpl-shared\bin"
$envTarget = "Machine" # 环境变量目标，可以是"Machine", "User", 或 "Process"
 
# 添加或更新环境变量
[Environment]::SetEnvironmentVariable($envName, $envValue, $envTarget)
 


Get-ChildItem Env:




