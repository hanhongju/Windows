;AuotoHotkey循环发送按键到后台窗口@Windows
Insert::                                               ;按下Insert开启脚本
HotKey  =   {F9}                                       ;定义热键
SetTitleMatchMode, 2
WinGetActiveTitle, Title                               ;读取当前窗口名字，并为所有同名窗口编号
Winget, windowid, List, %Title%
Loop
{
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid1%      ;对所有当前窗口同名窗口发送热键，即使为后台也没关系
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid2%
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid3%
random ,  outputvar  ,  4000  ,  7000                  ;生成随机数，单位毫秒
sleep  , %outputvar%                                   ;等待随机时间后重新发送按键
}
Return




Delete::reload                                         ;按下Delete键重新载入脚本



