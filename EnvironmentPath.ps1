# 定义要添加的新路径
$NewPath = "C:\Program Files\ffmpeg-7.1-full_build\bin"
# 获取当前用户环境变量PATH的值
$CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "USER")
# 检查新路径是否已存在于Path中
if  ($CurrentPath -like "*$newPath*")   {
    Write-Host "新路径已存在于用户Path变量中，无需添加。"
}   else   {
    # 如果不存在，将新路径添加到Path
    $UpdatedPath = "$CurrentPath;$NewPath"
    [Environment]::SetEnvironmentVariable("PATH", $UpdatedPath, "USER")
    Write-Host "新路径已添加到用户Path变量。"
}
# 更新$Env:Path
$MachinePath =  [Environment]::GetEnvironmentVariable("PATH", "MACHINE")
$UserPath    =  [Environment]::GetEnvironmentVariable("PATH", "USER")
$Env:Path    =  "$MachinePath;$UserPath"
$Env:Path    -split ";"  |  Format-List




# 参考文献https://blog.csdn.net/weixin_42250302/article/details/117901436
# USER的环境变量PATH存储于REGISTRY::HKEY_CURRENT_USER\Environment\PATH中。
# MACHINE的环境变量PATH存储于REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Environment\PATH中。
# 参考文献https://superuser.com/questions/867728/user-vs-system-environment-variables-do-system-variables-override-user-variabl
# The User path is appended to the system path once you restart Powershell.
# 参考文献https://learn.microsoft.com/en-us/answers/questions/1159843/machine-and-user-path-variables-are-not-combined-i
# Make sure that all paths in the env file are working and not linking to a removed folder.
# Otherwise, Machine and User Path variables will not combine in $Env:Path on restart.
