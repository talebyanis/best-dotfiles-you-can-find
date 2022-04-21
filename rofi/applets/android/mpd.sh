#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="$HOME/.config/rofi/applets/android"
rofi_command="rofi -theme $dir/six.rasi"

# Gets the current status of mpd (for us to parse it later on)
status="$(pacmd list-sink-inputs)"
# Defines the Play / Pause option content
if [[ $status == *"state: RUNNING"* ]]; then
    play_pause=""
else
    play_pause=""
fi
active=""
urgent=""

# Display if repeat mode is on / off
tog_repeat=""
if [[ $status == *"repeat: on"* ]]; then
    active="-a 4"
elif [[ $status == *"repeat: off"* ]]; then
    urgent="-u 4"
else
    tog_repeat=" Parsing error"
fi

# Display if random mode is on / off
tog_random=""
if [[ $status == *"random: on"* ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
elif [[ $status == *"random: off"* ]]; then
    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
else
    tog_random=" Parsing error"
fi
stop=""
next=""
previous=""

# playlists
trap="💥"
lofi="☕"
epicness="⚔️"
working="📚"
jazz="🎷"
chill="🥱"
futurefunk="🌸"
deephouse="🏖️"

# Variable passed to rofi
options="$previous\n$play_pause\n$stop\n$next\n$trap\n$lofi\n$epicness\n$working\n$jazz\n$chill\n$futurefunk\n$deephouse"

# Spawn the mpd menu with the "Play / Pause" entry selected by default
chosen="$(echo -e "$options" | $rofi_command -p "  $current" -dmenu $active $urgent -selected-row 1)"
case $chosen in
    $previous)
        sp prev
		;;
    $play_pause)
        sp play
		;;
    $stop)
        sp pause
		;;
    $next)
		sp next
        ;;
	$trap)
		sp open spotify:playlist:37vg82G4lAER5Hxm6PtSqI
		;;
	$epicness)
        sp open spotify:playlist:6vfLUyOpmJNy10Xy43mJ7R
        ;;
	$lofi)
        sp open spotify:playlist:0vvXsWCC9xrXsKd4FyS8kM
        ;;
	$working)
        sp open spotify:playlist:1EBR55YTPSJDFBoiVVUmGV
        ;;
	$jazz)
        sp open spotify:playlist:37i9dQZF1DX2vYju3i0lNX
        ;;
	$chill)
		sp open spotify:playlist:12Z0qCTeEW8uzdRH5P6iqC
        ;;
	$futurefunk)
		sp open spotify:playlist:678bt8bSC7zHVMMxvarKVx
		;;
	$deephouse)
		sp open spotify:playlist:6vDGVr652ztNWKZuHvsFvx
		;;
esac
