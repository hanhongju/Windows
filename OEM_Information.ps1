New-Item          -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Force
New-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Force  -Type String  -Name Model  -Value "A Property of Hanhongju"
Remove-Item       -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation `
                  -Recurse  -ErrorAction SilentlyContinue





# 修改系统设置-关于-设备规格下面的一行字，这是系统OEM信息
