; Required libraries:
;   https://github.com/cocobelgica/AutoHotkey-JSON
;   https://github.com/jNizM/AHK_Scripts/blob/master/src/encoding_decoding/base64.ahk
; Remove the last two lines in Base64.ahk which begin with MsgBox 
; Put libaries in <Script Directory>/Lib/ 
#Include <JSON> 
#Include <Base64>

formatSeconds(secs) {
    time := 19990101  ; *Midnight* of an arbitrary date.
    time += secs, seconds
    FormatTime, mmss, %time%, mm:ss
    return Abs(secs) > 3600 ? secs//3600 ":" mmss : mmss
}

calculateExp(expTimestamp) {
    utcTimestamp := A_NowUTC
    EnvSub, utcTimestamp, 19700101, Seconds
    return expTimestamp - utcTimestamp
}

CustomMsgBox(Title,Message,Font="",FontOptions="",WindowColor="")
{

    Gui,66:Destroy
    Gui,66:Color,%WindowColor%
    Gui,66:Font,%FontOptions%,%Font%
    Gui,66:Add,Edit,,%Message%
    Gui,66:Font    
    Gui,66:Add,Button,% "Default y+10 w75 g66OK xp+" (TextW / 2) - 38 ,OK
    Gui,66:-MinimizeBox
    Gui,66:-MaximizeBox
    Gui,66:Show,,%Title%
    ControlSend,,{End},%Title%
    return
    GuiClose:
    GuiEscape:
    66OK:
    Gui,66:Destroy
    return
}

!0:: 
jwtBodyDecoded := b64Decode(StrSplit(Clipboard, ".")[2])
jwtBodyObj := JSON.Load(jwtBodyDecoded)
expTimestamp := jwtBodyObj["exp"]
expiresIn := calculateExp(expTimestamp)
jwtBodyFormatted := JSON.Dump(jwtBodyObj,, 4)
CustomMsgBox("JWT Inspector - Token expires in: " formatSeconds(expiresIn), jwtBodyFormatted)
return