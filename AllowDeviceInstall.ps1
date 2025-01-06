Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions `
                  -Name AllowAdminInstall      -Type DWord   -Value 1





# 解除设备安装限制
