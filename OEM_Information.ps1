New-Item          -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation  -Force
New-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation  -Force  -PropertyType String  -Name Model  -Value NK50S5
Remove-Item       -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation  -Recurse
#  N960KR
#  P775TM
#  Z370PD3


# 修改系统设置-关于-设备规格下面的一行字，这是系统OEM信息
