# 定义要添加的新路径
$NewPath = "C:\Program Files\ffmpeg-7.1-full_build\bin"
# 获取当前用户环境变量PATH的值
$CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
# 检查新路径是否已存在于Path中
if  ($CurrentPath -like "*$newPath*")   {
    Write-Host "新路径已存在于系统Path变量中，无需添加。"
}   else   {
    # 如果不存在，将新路径添加到Path
    $UpdatedPath = "$CurrentPath;$NewPath"
    [Environment]::SetEnvironmentVariable("PATH", $UpdatedPath, "Machine")
    # 重新加载环境变量，使更改生效
    $Env:Path = [Environment]::GetEnvironmentVariable("Path","Machine")
    Write-Host "新路径已添加到系统Path变量。"
}
# 验证PATH环境变量是否已成功更新
$Env:Path  -split ";" | Format-List





# 添加环境变量PATH
