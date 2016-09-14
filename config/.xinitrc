feh --bg-fill /usr/share/backgrounds/space.png

pactl upload-sample "$HOME/.local/share/sounds/sosumi.wav" x11-bell
pactl load-module module-x11-bell sample=x11-bell display=$DISPLAY
xset b 100

exec xfce4-session
