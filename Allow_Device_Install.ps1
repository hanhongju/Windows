# Win10系统提示“系统策略禁止安装此设备，请与系统管理员联系”
# 安装PolicyFileEditor模块
Install-PackageProvider   -Name NuGet            -Confirm
Set-PSRepository          -Name PSGallery        -InstallationPolicy Trusted
Install-Module            -Name PolicyFileEditor
Set-ExecutionPolicy       Unrestricted    -Force
Import-Module             -Name PolicyFileEditor
# 本地组策略编辑器-计算机配置-管理模板-系统-设备安装-设备安装限制-启用“允许管理员忽略设备安装限制策略”
Set-PolicyFileEntry       -Path C:/Windows/system32/GroupPolicy/Machine/Registry.pol `
                          -Key  Software\Policies\Microsoft\Windows\DeviceInstall\Restrictions `
                          -ValueName AllowAdminInstall        -Type DWord      -Data 1
gpupdate





# 参考文献
# https://www.itsvse.com/thread-10340-1-1.html
# https://stackoverflow.com/questions/69295465/windows-10-local-group-policy-edit-via-powershell
# https://gerane.github.io/powershell/Local-gpo-powershell/
# https://bbs.csdn.net/topics/320018136
# https://superuser.com/questions/1192405/why-gpedit-and-the-corresponding-registry-entries-are-not-synchronized
