WinFade(winID:="", transparency:=128, increment:=100, delay:= 1) {
	winID := (winID = "") ? ("ahk_id " WinActive("A")) : winID
	transparency := (transparency > 255) ? 255 : (transparency<0 ) ? 0 : transparency
	WinGet s, Transparent, %winID%
	s := (s = "") ? 255 : s ;prevent trans unset bug
	WinSet Transparent, %s%, %winID%
	increment := (s < transparency) ? abs(increment) : -1 * abs(increment)
	while (k:=(increment < 0) ? (s > transparency) : (s < transparency) && WinExist(winID)) {
		if !(WinExist(winID))
			break
		WinGet s, Transparent, %winID%
		s+=increment
		WinSet Transparent, %s%, %winID%
		Sleep, %delay%
	}

}

WinMoveFunc(hwnd, position:="b r", h_offset:=0, v_offset:=0) {
	global x, y
	SysGet, Mon, MonitorWorkArea
	WinGetPos,ix,iy,w,h, ahk_id %hwnd%
	x := InStr(position,"l") ? MonLeft + h_offset
	: InStr(position,"hc") ? ((MonRight-w)/2) + h_offset
	: InStr(position,"r") ? MonRight - w + h_offset
	: ix

	y := InStr(position,"t") ? MonTop + v_offset
	: InStr(position,"vc") ? (MonBottom-h)/2 + v_offset
	: InStr(position,"b") ? MonBottom - h + v_offset
	: iy
		
	WinMove, ahk_id %hwnd%,,x,y
}