cd

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for file in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$file" ] && . "$file"
    done
    unset file
fi

export QT_QPA_PLATFORMTHEME=qt5gtk2

feh --no-fehbg --bg-fill /usr/share/backgrounds/highway.png

compton &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xfsettingsd &
numlockx on &
conky &
pcmanfm -d &
nm-applet &
pasystray -n &

xset s off
xset s noblank
xset -dpms

pacmd set-sink-volume alsa_output.pci-0000_00_1b.0.iec958-stereo 60%
pacmd set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo 60%
pacmd set-source-volume alsa_input.pci-0000_00_1b.0.analog-stereo 30%
pacmd set-source-volume alsa_output.pci-0000_00_1b.0.analog-stereo.monitor 100%

pacmd load-sample sosumi "$HOME/.local/share/sounds/sosumi.wav"
pacmd load-module module-x11-bell sample=sosumi display=$DISPLAY
xset b 100

exec xfce4-session
