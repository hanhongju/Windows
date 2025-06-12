# 优先显示OEMInformation
New-Item                -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\ `
                        -Force
Set-ItemProperty        -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\ `
                        -Name Model  -Type String  -Value "A Property of Hanhongju"
Remove-Item             -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation\ `
                        -Recurse  -ErrorAction SilentlyContinue
# OEMInformation没有则显示下面的SystemInformation
Set-ItemProperty        -Path REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\SystemInformation\ `
                        -Name SystemProductName -Type String  -Value "N960K"
Remove-ItemProperty     -Path REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\SystemInformation\ `
                        -Name SystemProductName -ErrorAction SilentlyContinue




# 修改设置-系统-系统信息-设备名字下的一行字
