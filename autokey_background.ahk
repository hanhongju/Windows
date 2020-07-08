;AuotoHotkey循环发送按键到后台窗口@Windows
Insert::                     ;按下Insert开启脚本
WinGetActiveTitle, Title     ;读取当前窗口名字
Loop
{
ControlSend,   ,  {F12}  ,   %Title%            ;对当前窗口发送按键F12，即使该窗口变为后台也没关系
random, outputvar,     2000,  6000              ;生成随机数，单位毫秒
sleep, outputvar                                ;等待随机时间后重新发送按键
}
Return


Delete::ExitApp              ;按下Delete键退出按键程序




