# 使用管理员权限的powershell运行以下代码，重启后生效
# 设置-网络和Internet-状态-属性-网络配置文件：选择“专用”
Set-NetConnectionProfile   -Name  (Get-NetConnectionProfile).Name                 -NetworkCategory  Private
# 设置-网络和Internet-状态-更改适配器选项-当前网络连接属性-网络-此连接使用下列项目：勾选“Microsoft 网络的文件和打印机共享”
Enable-NetAdapterBinding   -Name  (Get-NetConnectionProfile).InterfaceAlias       -ComponentID  ms_server
# 设置-网络和Internet-状态-网络和共享中心-更改高级共享设置-专用-启用文件和打印机共享，英文版系统"File And Printer Sharing"
Set-NetFirewallRule        -DisplayGroup  "文件和打印机共享"    -Enabled  True     -Profile  Private
# SMBv1存在重大安全漏洞，强烈建议不要使用它。
Get-SmbServerConfiguration   |   Select  EnableSMB1Protocol, EnableSMB2Protocol
# 在SMB服务器上启用SMBv2和SMBv3，因为SMBv2和SMBv3共用一个栈，所以在启用或禁用 SMBv2时，也会启用或禁用SMBv3。
Set-SmbServerConfiguration       -EnableSMB2Protocol  $true          -Force
# 客户端主机开启SMB大型MTU支持提升文件传输效率，并禁用带宽限制。
Set-SmbClientConfiguration       -EnableBandwidthThrottling  0       -EnableLargeMtu  1      -Force
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-用户权限分配：将Guest从“拒绝从网络访问这台计算机”列表中删除
secedit.exe    /export     /cfg     C:\Users\hj\Documents\gp.inf     /quiet
$content       =    Get-Content     C:\Users\hj\Documents\gp.inf
$content       -replace     "SeDenyNetworkLogonRight = Guest", "SeDenyNetworkLogonRight ="    |    Set-Content     C:\Users\hj\Documents\gp.inf
secedit.exe    /configure   /db   gp.sdb   /cfg    C:\Users\hj\Documents\gp.inf    /quiet
gpupdate
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-安全选项：禁用“账户：使用空密码的本地帐户只允许进行控制台登录”
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Lsa `
                  -Name LimitBlankPasswordUse      -Type DWord   -Value 0
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-安全选项：禁用“网络访问: 不允许 SAM 帐户和共享的匿名枚举”
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Lsa `
                  -Name restrictanonymous          -Type DWord   -Value 0
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-安全选项：“网络访问: 本地帐户的共享和安全模型”更改为“仅来宾”
# 这将确保所有访问共享文件夹的用户都将以Guest身份进行验证，无需输入Guest用户名
Set-ItemProperty  -Path REGISTRY::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa `
                  -Name forceguest                 -Type DWord   -Value 1
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-安全选项：启用“帐户：来宾帐户状态”
Enable-LocalUser  -Name Guest
LocalUser
# 获取所有磁盘的根路径
$disks = Get-PSDrive -PSProvider FileSystem
# 共享选项卡作用于远程共享，安全选项卡作用于本地访问，但两者最小交集影响实际远程共享的权限
# 遍历所有磁盘，授予Everyone本地访问所有磁盘权限，即影响属性-安全选项卡的内容
foreach ($disk in $disks) {
    $drivePath = $disk.Root
    Write-Host "正在更新磁盘 $($disk.Name):"
    icacls $drivePath /grant "Everyone:(OI)(CI)(F)"
}




# 参考文献：https://www.tenforums.com/tutorials/49753-turn-off-file-printer-sharing-windows-10-a.html
# 参考文献：http://60.8.226.162:8098/?p=452
# 参考文献：https://3gstudent.github.io/%E6%B8%97%E9%80%8F%E6%8A%80%E5%B7%A7-%E9%80%9A%E8%BF%87%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%BC%80%E5%90%AFWindows%E7%B3%BB%E7%BB%9F%E7%9A%84%E5%8C%BF%E5%90%8D%E8%AE%BF%E9%97%AE%E5%85%B1%E4%BA%AB
