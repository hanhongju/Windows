download_MAS_and_activate () {
#需使用http:8081代理，否则连不上github
Invoke-WebRequest -Proxy "http://127.0.0.1:8081" `
                  -Uri "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/refs/heads/master/MAS/All-In-One-Version-KL/MAS_AIO.cmd" `
                  -OutFile "C:\Users\Public\Downloads\MAS_AIO.cmd"

Start-Process     "C:\Users\Public\Downloads\MAS_AIO.cmd"

}



manage_windows_key () {
cd             "C:\Windows\System32"
cscript.exe    slmgr.vbs    /skms   kms.03k.org
cscript.exe    slmgr.vbs    /ipk    W269N-WFGWX-YVC9B-4J6C9-T83GX
cscript.exe    slmgr.vbs    /ato

}




manage_office_key () {
cd             "C:\Program Files\Microsoft Office\Office16"
cd             "C:\Program Files (x86)\Microsoft Office\Office16"
cscript.exe    ospp.vbs    /dstatus
cscript.exe    ospp.vbs    /sethst:kms.03k.org
cscript.exe    ospp.vbs    /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH
cscript.exe    ospp.vbs    /act
# cscript.exe  ospp.vbs    /unpkey:

}





# 参考文献
# Windows和Office激活脚本
# WINDOWS密钥https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys
# OFFICE密钥https://learn.microsoft.com/zh-cn/office/volume-license-activation/gvlks
# https://learn.microsoft.com/zh-cn/office/ltsc/2024/deploy
# configuration.xml can be created from https://config.office.com/deploymentsettings
