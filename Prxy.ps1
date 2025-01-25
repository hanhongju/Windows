# 使.NET命令使用代理
$Proxy = New-Object System.Net.WebProxy
$Proxy.GetType()
$Proxy.Address = "http://127.0.0.1:8081"
[System.Net.WebRequest]::DefaultWebProxy = $Proxy
# 使外部命令使用代理
$env:https_proxy = "http://127.0.0.1:8081"




# powershell设置临时代理
