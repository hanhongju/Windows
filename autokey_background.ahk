;AuotoHotkey循环发送按键到后台窗口@Windows
;按下Insert开启脚本
INSERT::
;定义热键
HotKey  =   {END}
;读取当前窗口名字，并为所有同名窗口编号
SetTitleMatchMode, 2
WinGetActiveTitle, Title
Winget, windowid , List , %Title%
;对所有当前窗口同名窗口发送热键，即使为后台也没关系
Loop
{
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid1%
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid2%
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid3%
random ,  outputvar  ,  4000  ,  7000
sleep  , %outputvar%
}
Return




;按下Delete键重新载入脚本
HOME::reload



