; Required libraries:
;   https://github.com/cocobelgica/AutoHotkey-JSON
;   https://github.com/jNizM/AHK_Scripts/blob/master/src/encoding_decoding/base64.ahk
; Remove the last two lines in Base64.ahk which begin with MsgBox 
; Put libaries in <Script Directory>/Lib/ 
#Include <JSON> 
#Include <Base64>

CustomMsgBox(Title,Exp,Message) {
    Gui,New
    Gui,-MinimizeBox
    Gui,-MaximizeBox
    Gui,Font,s12,%Font%
    Gui,Add,Edit,% "h"A_ScreenHeight*.80 ReadOnly,%Message%
    Gui,Add,Text, ,% "Token expires in: " Exp " seconds."
    Gui,Show,,%Title%
    ControlSend,,{Left},%Title% ;deselects the text
    return
    GuiClose:
    GuiEscape:
    Gui,Destroy
    return
}

!0:: 
jwtBodyObj := JSON.Load(b64Decode(StrSplit(Clipboard, ".")[2]))
utcTimestamp := A_NowUTC
EnvSub, utcTimestamp, 19700101, Seconds
expiresIn := jwtBodyObj.exp - utcTimestamp
jwtBody := JSON.Dump(jwtBodyObj,, 4)
title := "JWT Inspector" 
CustomMsgBox(title,expiresIn,jwtBody)
return
