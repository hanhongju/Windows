$proxyUrl = "http://127.0.0.1:8081"
$proxy = New-Object System.Net.WebProxy
$proxy.Address = $proxyUrl
[System.Net.WebRequest]::DefaultWebProxy = $proxy
[System.Net.WebRequest]::DefaultWebProxy




# powershell设置临时代理
