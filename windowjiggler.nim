import os
import std/random
import winim


var hWndOrig = GetForegroundWindow()
var windowCoords: RECT
GetWindowRect(hWndOrig, &windowCoords)

while true:
    var hWndNew = GetForegroundWindow()
    
    if (hWndNew != hWndOrig):
        hWndOrig = hWndNew
        GetWindowRect(hWndOrig, &windowCoords)

    var
        newX = rand(windowCoords.left - 1 .. windowCoords.left + 1)
        newY = rand(windowCoords.top - 1 .. windowCoords.top + 1)

    SetWindowPos(hWndOrig, 0x0, (int32)newX, (int32)newY, 0, 0, (SWP_NOSIZE or SWP_NOZORDER))
