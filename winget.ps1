winget install  --silent  Tencent.WeChat Baidu.BaiduNetdisk Mozilla.Firefox
winget settings --enable ProxyCommandLineOptions
winget install  --silent  --proxy http://127.0.0.1:5001  2dust.v2rayN
winget upgrade --all --proxy http://127.0.0.1:5001

winget search firefox
