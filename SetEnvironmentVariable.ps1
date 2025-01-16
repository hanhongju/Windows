

# 定义要添加的新路径
$newPath = "C:\Users\hj\Downloads\ffmpeg-master-latest-win64-gpl-shared\bin"

# 获取当前用户环境变量PATH的值
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
# 将新路径添加到当前PATH中，注意分号作为分隔符
$updatedPath = "$currentPath;$newPath"

# 将更新后的PATH值设置回环境变量中
[System.Environment]::SetEnvironmentVariable("PATH", $updatedPath, "Machine")

$updatedPath = "C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\"



Get-ChildItem Env:Path| Format-List
$Env:Path  -split ";"



