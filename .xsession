source ~/.envrc
xrdb -merge ~/.Xresources
xset m 1 1
# Disabled because it's distracting with the composited unfocused windows.
#feh --bg-center Pictures/dijkstra.jpg
xcompmgr -n &
hsetroot -solid \#888888
ls /home/build/public/eng/elisp/google.el > /dev/null  # prime cache
emacs --daemon
killall gnome-screensaver
xscreensaver -no-splash &
redshift -l 37.423269:-122.082667 -t 5500:5000 &

xmodmap ~/.xmodmap

xmonad

