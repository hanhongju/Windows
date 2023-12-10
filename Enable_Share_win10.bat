
#将当前网络改为专有网络
Set-NetConnectionProfile   -Name    (Get-NetConnectionProfile).Name     -NetworkCategory    Private
#启用Guest用户
net    user    guest    /active:yes
#将Guest用户从策略“拒绝从网络访问这台计算机”中移除
secedit       /export              /cfg           security.inf
(Get-Content security.inf)   -replace   "SeDenyNetworkLogonRight.*" , "SeDenyNetworkLogonRight =" | Set-Content "security.inf"
secedit       /configure         /cfg           security_new.inf         /db        security.sdb
#禁用“空白密码只允许控制台登录”
reg add HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Lsa /v LimitBlankPasswordUse /t reg_dword /d 0 /f
#强制刷新组策略，立即生效
gpupdate /force




