export LANG=ja_JP.UTF-8

# Font Config
xset +fp /usr/share/fonts/truetype/

# no beep
xset -b

# Japanese Input Methoad Settings
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx

# Cursor theme
xsetroot -cursor_name left_ptr

# Keybinding
xmodmap ~/.Xmodmap
#xmodmap -e 'keycode 255=space'; xmodmap -e 'keycode 65=Shift_L'; xcape -e '#65=space'

# Display Setting
~/.screenlayout/normal.sh
nitrogen --restore

# For automount


# Display Manager
exec xmonad
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xmonad
