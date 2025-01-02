# 打开网络连接；查看网络属性；勾选“Microsoft 网络的文件和打印机共享”
# 使用管理员权限的powershell运行以下代码
# 将当前网络改为专有网络
Set-NetConnectionProfile         -Name  (Get-NetConnectionProfile).Name        -NetworkCategory  Private
# SMBv1存在重大安全漏洞，强烈建议不要使用它。
Get-SmbServerConfiguration   |   Select  EnableSMB1Protocol, EnableSMB2Protocol
# 在SMB服务器上启用SMBv2和SMBv3，因为SMBv2和SMBv3共用一个栈，所以在启用或禁用 SMBv2时，也会启用或禁用SMBv3。
Set-SmbServerConfiguration       -EnableSMB2Protocol  $true          -Force
# 客户端主机开启SMB大型MTU支持提升文件传输效率，并禁用带宽限制。
Set-SmbClientConfiguration       -EnableBandwidthThrottling  0       -EnableLargeMtu  1      -Force
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-用户权限分配：将Guest添加到“从网络访问此计算机”列表，并从“拒绝从网络访问这台计算机”和“拒绝本地登录”列表中删除
[byte[]]$Value = @("66","00","00","00")
Set-ItemProperty  -Path "HKLM:\SECURITY\Policy\Accounts\S-1-5-*-501\ActSysAc"    -Name "(Default)"     -Value $Value

secedit       /export            /cfg           security.inf
(Get-Content  security.inf)       -replace      "SeDenyNetworkLogonRight.*" , "SeDenyNetworkLogonRight =" | Set-Content "security.inf"
secedit       /configure         /cfg           security.inf        /db        security.sdb
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-安全选项："LimitBlankPasswordUse"= 0 表示禁用“账户：使用空密码的本地帐户只允许进行控制台登录”
Set-ItemProperty  -Path "HKLM:\SYSTEM\ControlSet001\Control\Lsa"       -Name LimitBlankPasswordUse     -Type DWord   -Value 0
# 本地组策略编辑器-计算机配置-Windows设置-安全设置-本地策略-安全选项：启用“帐户：来宾帐户状态”
net    user    guest    /active:yes
# 获取所有磁盘的根路径
$disks = Get-PSDrive -PSProvider FileSystem
# 遍历所有磁盘，授予Everyone访问所有磁盘权限
foreach ($disk in $disks) {
    $drivePath = $disk.Root
    Write-Host "正在更新磁盘 $($disk.Name):"
    icacls $drivePath /grant "Everyone:(OI)(CI)(F)"
}
