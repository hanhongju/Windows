Invoke-WebRequest -Proxy "http://127.0.0.1:8081" `
                  -Uri "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/refs/heads/master/MAS/All-In-One-Version-KL/MAS_AIO.cmd" `
                  -OutFile "C:\Users\hj\Downloads\MAS_AIO.cmd"
                  
Start-Process     "C:\Users\hj\Downloads\MAS_AIO.cmd"





# Windows和Office激活脚本，需使用http:8081代理，否则连不上github
