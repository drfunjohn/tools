#!/usr/bin/env bash
#
layouts="us,ua,il"
layouts_num=3

toggle_time=$(date +"%s") 
toggle_file=toggle-kb

function next_layout(){
	index=$1
	((new = ( index + 1 ) % layouts_num)) 
	((start = new * layouts_num))
	new_layout_str=${layouts:${start}:2}
	echo ${new_layout_str}
}

current_layout=$(setxkbmap -query | awk '$1~/layout/ {print $2}')
index=${layouts%%${current_layout}*}
index=${#index}
echo "Current position ${index}" 
((current_layout_index = (index + 0) / 3))
echo "Current layout:${current_layout} is [${current_layout_index}]" 

last_toggle=$(date -r ${toggle_file} +"%s")
((elapsed = toggle_time - last_toggle))

if [ ${current_layout_index} -ne 0 ] && [ ${elapsed} -gt 1 ]; then
	new_layout=${layouts:0:2}
else
	new_layout=$(next_layout ${current_layout_index})
fi

echo New layout is ${new_layout}
setxkbmap ${new_layout}
kill -SIGUSR1 i3status
touch ${toggle_file}

