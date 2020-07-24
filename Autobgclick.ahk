;AuotoHotkey循环发送按键到后台窗口
Insert::
HotKey  =   {END}
SetTitleMatchMode, 2
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


Home::reload





