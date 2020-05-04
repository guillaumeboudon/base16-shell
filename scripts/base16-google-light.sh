#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Google Light scheme by Seth Wright (http://sethawright.com)

tee "${BASE16_VIM_FILE:-"$HOME/.base16_colors.vim"}" << EOF > /dev/null
let g:base16_color_00 = "ffffff"
let g:base16_color_01 = "e0e0e0"
let g:base16_color_02 = "c5c8c6"
let g:base16_color_03 = "b4b7b4"
let g:base16_color_04 = "969896"
let g:base16_color_05 = "373b41"
let g:base16_color_06 = "282a2e"
let g:base16_color_07 = "1d1f21"
let g:base16_color_08 = "CC342B"
let g:base16_color_09 = "F96A38"
let g:base16_color_0A = "FBA922"
let g:base16_color_0B = "198844"
let g:base16_color_0C = "3971ED"
let g:base16_color_0D = "3971ED"
let g:base16_color_0E = "A36AC7"
let g:base16_color_0F = "3971ED"
EOF

color00="ff/ff/ff" # Base 00 - Black
color01="CC/34/2B" # Base 08 - Red
color02="19/88/44" # Base 0B - Green
color03="FB/A9/22" # Base 0A - Yellow
color04="39/71/ED" # Base 0D - Blue
color05="A3/6A/C7" # Base 0E - Magenta
color06="39/71/ED" # Base 0C - Cyan
color07="37/3b/41" # Base 05 - White
if [ -n "$BASE16_SHELL_DEFAULT_VARIANT" ]; then
  color08="b4/b7/b4" # Base 03 - Bright Black
  color09="F9/6A/38" # Base 09
  color10="e0/e0/e0" # Base 01
  color11="c5/c8/c6" # Base 02
  color12="96/98/96" # Base 04
  color13="28/2a/2e" # Base 06
  color14="39/71/ED" # Base 0F
  color15="1d/1f/21" # Base 07 - Bright White
else
  color08="b4/b7/b4" # Base 03 - Bright Black
  color09=$color01 # Base 08 - Bright Red
  color10=$color02 # Base 0B - Bright Green
  color11=$color03 # Base 0A - Bright Yellow
  color12=$color04 # Base 0D - Bright Blue
  color13=$color05 # Base 0E - Bright Magenta
  color14=$color06 # Base 0C - Bright Cyan
  color15="1d/1f/21" # Base 07 - Bright White
  color16="F9/6A/38" # Base 09
  color17="39/71/ED" # Base 0F
  color18="e0/e0/e0" # Base 01
  color19="c5/c8/c6" # Base 02
  color20="96/98/96" # Base 04
  color21="28/2a/2e" # Base 06
fi;
color_foreground="37/3b/41" # Base 05
color_background="ff/ff/ff" # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

if [ -z "$BASE16_SHELL_DEFAULT_VARIANT" ]; then
  # 256 color space
  put_template 16 $color16
  put_template 17 $color17
  put_template 18 $color18
  put_template 19 $color19
  put_template 20 $color20
  put_template 21 $color21
fi

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg 373b41 # foreground
  put_template_custom Ph ffffff # background
  put_template_custom Pi 373b41 # bold color
  put_template_custom Pj c5c8c6 # selection color
  put_template_custom Pk 373b41 # selected text color
  put_template_custom Pl 373b41 # cursor
  put_template_custom Pm ffffff # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
