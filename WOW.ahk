#定义Message内容
/script msg="Hello, world!";






#广播
/script SendChatMessage(msg,"YELL");SendChatMessage(msg,"CHANNEL",nil,1);SendChatMessage(msg,"CHANNEL",nil,2);SendChatMessage(msg,"CHANNEL",nil,3);SendChatMessage(msg,"CHANNEL",nil,4);









;AuotoHotkey后台窗口自动按键
Home::
HotKey  =   {Del}
SetTitleMatchMode, 3
WinGetActiveTitle, Title
Winget,  windowid, List , %Title%
Loop
{
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid1%
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid2%
ControlSend,  ,  %HotKey%  ,   ahk_id %windowid3%
random ,  outputvar  ,  5000  ,  10000
sleep  , %outputvar%
}
Return
End::reload










;获取鼠标位置,并点击几个特定位置
Del::
MouseGetPos, X,Y
MsgBox ,%X%,%Y%
Return
Home::
sleeptime  =    500
Loop
{
Click, right, 960, 626
sleep  %sleeptime%
Click, 79, 347
sleep  %sleeptime%
Click, 104, 666
sleep  %sleeptime%
Click
sleep  %sleeptime%
}
Return
End::reload













;连续右键点击
Home::
Loop
{
Click, right
sleep  100
}
Return
End::reload
















