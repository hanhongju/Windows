# 定义要添加的新路径
$NewPathArray = @(
"C:\Program Files\ffmpeg-7.1-full_build\bin"
"C:\Program Files\ebook2audiobook-2.0"
)
# 获取当前用户环境变量PATH的值
$CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "USER")
$CurrentPathArray = $CurrentPath  -split ";"
foreach ($NewPath in $NewPathArray) {
# 检查新路径是否已存在于Path中
     if  ($CurrentPathArray -contains $NewPath) {
         Write-Host "新路径已存在于用户Path变量中，无需添加。"
     }   else   {
# 如果不存在，将新路径添加到Path
         $UpdatedPath = "$CurrentPath;$NewPath"
         [Environment]::SetEnvironmentVariable("PATH", $UpdatedPath, "USER")
         Write-Host "新路径已添加到用户Path变量。"
# 循环中要用到的变量，都要及时更新
         $CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "USER")
         $CurrentPathArray = $CurrentPath  -split ";"
     }
}
# 更新$Env:Path，系统可正确运行程序
$MachinePath =  [Environment]::GetEnvironmentVariable("PATH", "MACHINE")
$UserPath    =  [Environment]::GetEnvironmentVariable("PATH", "USER")
$Env:Path    =  "$MachinePath;$UserPath"
$Env:Path    -split ";"




# 修改设置-系统-关于-高级系统设置-环境变量-用户变量-PATH
# 参考文献https://blog.csdn.net/weixin_42250302/article/details/117901436
# USER的环境变量PATH存储于REGISTRY::HKEY_CURRENT_USER\Environment\PATH中。
# MACHINE的环境变量PATH存储于REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment\PATH中。
# 参考文献https://superuser.com/questions/867728/user-vs-system-environment-variables-do-system-variables-override-user-variabl
# The User path is appended to the system path once you restart Powershell.
# [Environment]::GetEnvironmentVariable("PATH") abbreviated as $Env:Path is refreshed everytime we restart Powershell.
