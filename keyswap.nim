import winim
import std/random

type
    SendKeys = array[2, INPUT]

proc KeySwapHAHA() = 
            
    var inputs: SendKeys

    # A Key == 0x41
    inputs[0].type = INPUT_KEYBOARD
    inputs[0].ki.wVk = 0x41
    inputs[1].type = INPUT_KEYBOARD
    inputs[1].ki.wVk = 0x41
    inputs[1].ki.dwFlags = KEYEVENTF_KEYUP

    SendInput((UINT)len(inputs), &inputs[0], (int32)sizeof(INPUT));


# Run callback everytime key is pressed
proc HookCallback(nCode: int32, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} =    

    if (bool(lParam)):
        var kbd: PKBDLLHOOKSTRUCT = cast[ptr KBDLLHOOKSTRUCT](lparam)
        let diceroll = rand(1..5)
        # E Key == 0x45
        if (kbd.vkCode == 0x45) and (diceroll == 1):
            if (wParam == WM_KEYDOWN):
                KeySwapHAHA()
                return 1
            elif (wParam == WM_KEYUP):
                return 1

    return CallNextHookEx(0, nCode, wParam, lParam)


# Hook LowLevelKeyboardProc
var hook = SetWindowsHookEx(WH_KEYBOARD_LL, (HOOKPROC) HookCallback, 0,  0)
if bool(hook):
    try:
        PostMessage(0, 0, 0, 0)
        var msg: MSG
        while GetMessage(msg.addr, 0, 0, 0):
            discard
    
    finally:
        UnhookWindowsHookEx(hook)