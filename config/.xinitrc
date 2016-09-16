cd

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for file in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$file" ] && . "$file"
    done
    unset file
fi

feh --bg-fill /usr/share/backgrounds/space.png

compton &
start-pulseaudio-x11 &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xfsettingsd &
pcmanfm -d &
pasystray -n &

pactl upload-sample "$HOME/.local/share/sounds/sosumi.wav" x11-bell
pactl load-module module-x11-bell sample=x11-bell display=$DISPLAY
xset b 100

exec xfce4-session
