New-Item          -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Force
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Name Model  -Type String  -Value "A Property of Hanhongju"
Remove-Item       -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Recurse  -ErrorAction SilentlyContinue




# 修改设置-系统-关于-设备规格下面的一行字，这是系统OEM电脑型号
