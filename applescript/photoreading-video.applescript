#!/usr/bin/osascript
(* Photoreading for video
Run fast forward rewind video in Opera browser
*)
activate application "Opera"
repeat 60 times
	repeat 6 times -- fast forward 6x10 seconds
		-- fast forward 10 seconds
		tell application "System Events"
			key code 124 using command down
			delay (0.1)
		end tell
	end repeat
	delay (3)
end repeat