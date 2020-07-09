;AuotoHotkey循环发送按键到后台窗口@Windows
Insert::                                                ;按下Insert开启脚本
HotKey  =   {END}                                       ;定义热键
SetTitleMatchMode, 2
WinGetActiveTitle, Title                                ;读取当前窗口名字，并为所有同名窗口编号
Winget,  windowid, List , %Title%
Loop
{
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid1%       ;对当前窗口所有同名窗口发送热键
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid2%
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid3%
random ,  outputvar  ,  4000  ,  7000                   ;生成随机时间，单位毫秒
sleep  , %outputvar%                                    ;等待随机时间后循环发送热键
}
Return




Home::reload                                            ;按下Home键停止脚本





