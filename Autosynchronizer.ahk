;AutoHotkey同步器
WinGetActiveTitle, Title
Winget, windowid, List, %Title%
1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
-::
=::
Space::
G::
x::
Tab::
Shift::
Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
F1::
F2::
F3::
F4::
F5::
F6::
F7::
F8::
F9::
F10::
F11::
F12::
ControlSend,, {%A_ThisHotkey%}, ahk_id %windowid1%
ControlSend,, {%A_ThisHotkey%}, ahk_id %windowid2%
ControlSend,, {%A_ThisHotkey%}, ahk_id %windowid3%
ControlSend,, {%A_ThisHotkey%}, ahk_id %windowid4%
ControlSend,, {%A_ThisHotkey%}, ahk_id %windowid5%
Return










