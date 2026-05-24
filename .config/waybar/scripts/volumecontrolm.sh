#!/usr/bin/env sh

ScrDir=$(dirname "$(realpath "$0")")
# source "$ScrDir/globalcontrol.sh"

# Define functions

print_error () {
    cat << "EOF"
    ./volumecontrol.sh -[device] <actions>
    ...valid device are...
        i   -- input device (microphone)
        o   -- output device (speaker)
        p   -- player application
    ...valid actions are...
        i   -- increase volume [+5%]
        d   -- decrease volume [-5%]
        m   -- toggle mute
EOF
    exit 1
}

notify_vol () {
    angle="$(( (($vol + 2) / 5) * 5 ))"
    ico="${icodir}/vol-${angle}.svg"
    bar=$(seq -s "." $(($vol / 15)) | sed 's/[0-9]//g')
    notify-send "Changed micro volume" -a "Volume Control" -r 333 -t 800 -i "${ico}" "${vol}%\n${bar}" 
}


notify_mute () {
    if [ "${mute}" = "yes" ]; then
        notify-send "Muted" -a "Volume Control" -r 333 -t 800 -i "${icodir}/muted-${dvce}.svg"  
    else
        notify-send "Unmuted" -a "Volume Control" -r 333 -t 800 -i "${icodir}/unmuted-${dvce}.svg"  
    fi
}

action_pactl () {
    case "$1" in
        i) pactl set-"${srce}"-volume @DEFAULT_"${srce_u}"@ +"${step}"% ;;
        d) pactl set-"${srce}"-volume @DEFAULT_"${srce_u}"@ -"${step}"% ;;
        m) pactl set-"${srce}"-mute @DEFAULT_"${srce_u}"@ toggle ;;
    esac
    vol=$(pactl get-"${srce}"-volume @DEFAULT_"${srce_u}"@ | awk '{print $5}' | sed 's/%//')
    mute=$(pactl get-"${srce}"-mute @DEFAULT_"${srce_u}"@ | awk '{print $2}')
}

action_playerctl () {
    case "$1" in
        i) playerctl --player="${srce}" volume 0."${step}"+ ;;
        d) playerctl --player="${srce}" volume 0."${step}"- ;;
        m) playerctl --player="${srce}" play-pause ;;
    esac
    vol=$(playerctl --player="${srce}" volume | awk '{ printf "%.0f\n", $0 * 100 }')
}

# Eval device option

while getopts iop: DeviceOpt; do
    case "${DeviceOpt}" in
        i)
            nsink=$(pactl list sources | grep -oP 'Name: \K.*' | head -n 1)
            if [ -z "${nsink}" ]; then
                echo "ERROR: Input device not found..."
                exit 1
            fi
            ctrl="pactl"
            srce="source"
            srce_u="SOURCE"
            dvce="mic"
            ;;
        o)
            nsink=$(pactl list sinks | grep -oP 'Name: \K.*' | head -n 1)
            if [ -z "${nsink}" ]; then
                echo "ERROR: Output device not found..."
                exit 1
            fi
            ctrl="pactl"
            srce="sink"
            srce_u="SINK"
            dvce="speaker"
            ;;
        p)
            nsink=$(playerctl --list-all | grep -w "${OPTARG}")
            if [ -z "${nsink}" ]; then
                echo "ERROR: Player ${OPTARG} not active..."
                exit 1
            fi
            ctrl="playerctl"
            srce="${nsink}"
            ;;
        *) print_error ;;
    esac
done

# Set default variables

icodir="/home/kostya/.config/waybar/icons/vol"
shift $((OPTIND - 1))
step="${2:-5}"

# Execute action

case "${1}" in
    i) action_${ctrl} i ;;
    d) action_${ctrl} d ;;
    m) action_${ctrl} m && notify_mute && exit 0 ;;
    *) print_error ;;
esac

# notify_vol
