cd

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for file in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$file" ] && . "$file"
    done
    unset file
fi

feh --no-fehbg --bg-fill /usr/share/backgrounds/megumin.png

compton &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
xfsettingsd &
numlockx on &
conky &
pcmanfm -d &
nm-applet &
pasystray -n &

pactl upload-sample "$HOME/.local/share/sounds/sosumi.wav" x11-bell
pactl load-module module-x11-bell sample=x11-bell display=$DISPLAY
xset b 100

exec xfce4-session
