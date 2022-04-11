# JWT-Inspector  
Displays decoded JWT that you have copied to the clipboard and the time until the token is expired.  

## Prerequisites
* [AutoHotkey](https://www.autohotkey.com/download/?)

## Dependencies
JWT-Inspector needs following libraries:  

https://github.com/cocobelgica/AutoHotkey-JSON  
https://github.com/jNizM/AHK_Scripts/blob/master/src/encoding_decoding/base64.ahk  

Remove the last 2 lines from base64.ahk then copy both files to a [function library folder](https://www.autohotkey.com/docs/Functions.htm#lib).  

## How it works
With a JWT copied to the clipboard, press Alt + 0 to display the decoded JWT. 

![JWT Inspector](https://i.imgur.com/Ra1LkFS.png)
