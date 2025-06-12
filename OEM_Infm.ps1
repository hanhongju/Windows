New-Item          -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Force
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Name Model  -Type String  -Value "A Property of Hanhongju"
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Name Manufacturer  -Type String  -Value "HASEE"
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Name SupportPhone  -Type String  -Value "18811108377"
Remove-Item       -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Recurse  -ErrorAction SilentlyContinue




# 修改设置-系统-关于-设备规格下面的一行字，这是系统OEM信息
# 参考文献https://blog.csdn.net/qq_44664783/article/details/135369233
