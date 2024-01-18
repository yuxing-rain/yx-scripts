﻿#SingleInstance, force
StringCaseSense, On

Is_Upper(x) {
  return (X >= "A") and (X <= "Z")
}

Gui, +AlwaysOnTop
Gui, Add, Text,, BPM (beats per minute)
Gui, Add, Edit, w300 vBPM, 100
Gui, Add, Text,, music sheet (keys to press)
Gui, Add, Edit, R10 w300 vPianoMusic
Gui, Add, Text,, Numpad1: play
Gui, Add, Text,, Numpad2: pause/resume
Gui, Add, Text,, Numpad3: reopen script
Gui, Add, Text,, skidded (edited) by yx
Gui, Show

Numpad1::
Gui, Submit, Nohide
PianoMusic := RegExReplace(PianoMusic, "[\n\r/]", " ")
KeyDelay := (60000 / BPM)
X := 1
while (X := RegExMatch(PianoMusic, "U)(\[.*]|.)", Keys, X))
{
    X += StrLen(Keys)
    Keys := Trim(Keys, "[]")
    if (Keys = " ")
    {
        Sleep, KeyDelay * 0.5
    }
    else if (Keys = "|")
    {
        Sleep, KeyDelay
    }
    else if (Is_Upper(Keys))
    {
        SendInput +%Keys%
    }
    else
    {
        SendInput % Keys
    }
}
return

Numpad3::
newScript := A_ScriptDir . "\roblox piano.ahk"
Run, %newScript%
return

Numpad2::
Pause
Suspend
return

GuiClose:
ExitApp