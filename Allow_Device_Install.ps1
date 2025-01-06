# 本地组策略编辑器-计算机配置-管理模板-系统-设备安装-设备安装限制-启用“允许管理员忽略设备安装限制策略”
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions `
                  -Name AllowAdminInstall      -Type DWord   -Value 1





# 解除设备安装限制
