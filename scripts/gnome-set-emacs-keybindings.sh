#!/bin/bash

gconftool-2 --set /desktop/gnome/interface/gtk_key_theme Emacs --type string
gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
