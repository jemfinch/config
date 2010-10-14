source ~/.envrc
xrdb -merge ~/.Xresources
xset m 1 1
# Disabled because it's distracting with the composited unfocused windows.
#feh --bg-center Pictures/dijkstra.jpg
xcompmgr -n &
hsetroot -solid \#888888
emacs --daemon
killall gnome-screensaver
xscreensaver -no-splash &
redshift -l 37.423269:-122.082667 -t 5500:3700 &

xmodmap ~/.xmodmap

xmonad

