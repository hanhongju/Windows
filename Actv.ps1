# Powershell设置临时代理
$Proxy = New-Object System.Net.WebProxy
$Proxy.GetType()
$Proxy.Address = "http://127.0.0.1:5001"
[System.Net.WebRequest]::DefaultWebProxy = $Proxy




# 下载MAS激活windows和office
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/refs/heads/master/MAS/All-In-One-Version-KL/MAS_AIO.cmd" `
                  -OutFile "C:\Users\Public\Downloads\MAS_AIO.cmd"
Start-Process     "C:\Users\Public\Downloads\MAS_AIO.cmd"




# KMS激活windows
cd             "C:\Windows\System32"
cscript.exe    slmgr.vbs    /skms   kms.03k.org
cscript.exe    slmgr.vbs    /ipk    W269N-WFGWX-YVC9B-4J6C9-T83GX
cscript.exe    slmgr.vbs    /ato




# KMS激活office
cd             "C:\Program Files\Microsoft Office\Office16"
cd             "C:\Program Files (x86)\Microsoft Office\Office16"
cscript.exe    ospp.vbs    /dstatus
cscript.exe    ospp.vbs    /sethst:kms.03k.org
cscript.exe    ospp.vbs    /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH  # ProPlus2021Volume
cscript.exe    ospp.vbs    /inpkey:KNH8D-FGHT4-T8RK3-CTDYJ-K2HT4  # VisioPro2021Volume
cscript.exe    ospp.vbs    /inpkey:FTNWT-C6WBT-8HMGF-K9PRX-QV9H8  # ProjectPro2021Volume
cscript.exe    ospp.vbs    /act
# cscript.exe  ospp.vbs    /unpkey:




# 激活程序@ Windows 10/11
# 参考文献
# WINDOWS密钥https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys
# OFFICE密钥https://learn.microsoft.com/zh-cn/office/volume-license-activation/gvlks
# https://learn.microsoft.com/zh-cn/office/ltsc/2024/deploy
# configuration.xml can be created from https://config.office.com/deploymentsettings
