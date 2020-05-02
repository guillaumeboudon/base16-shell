#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Material Darker scheme by Nate Peterson

export BASE16_COLOR_00="212121"
export BASE16_COLOR_01="303030"
export BASE16_COLOR_02="353535"
export BASE16_COLOR_03="4A4A4A"
export BASE16_COLOR_04="B2CCD6"
export BASE16_COLOR_05="EEFFFF"
export BASE16_COLOR_06="EEFFFF"
export BASE16_COLOR_07="FFFFFF"
export BASE16_COLOR_08="F07178"
export BASE16_COLOR_09="F78C6C"
export BASE16_COLOR_0A="FFCB6B"
export BASE16_COLOR_0B="C3E88D"
export BASE16_COLOR_0C="89DDFF"
export BASE16_COLOR_0D="82AAFF"
export BASE16_COLOR_0E="C792EA"
export BASE16_COLOR_0F="FF5370"

color00="21/21/21" # Base 00 - Black
color01="F0/71/78" # Base 08 - Red
color02="C3/E8/8D" # Base 0B - Green
color03="FF/CB/6B" # Base 0A - Yellow
color04="82/AA/FF" # Base 0D - Blue
color05="C7/92/EA" # Base 0E - Magenta
color06="89/DD/FF" # Base 0C - Cyan
color07="EE/FF/FF" # Base 05 - White
if [ -n "$BASE16_SHELL_DEFAULT_VARIANT" ]; then
  color08="4A/4A/4A" # Base 03 - Bright Black
  color09="F7/8C/6C" # Base 09
  color10="30/30/30" # Base 01
  color11="35/35/35" # Base 02
  color12="B2/CC/D6" # Base 04
  color13="EE/FF/FF" # Base 06
  color14="FF/53/70" # Base 0F
  color15="FF/FF/FF" # Base 07 - Bright White
else
  color08="4A/4A/4A" # Base 03 - Bright Black
  color09=$color01 # Base 08 - Bright Red
  color10=$color02 # Base 0B - Bright Green
  color11=$color03 # Base 0A - Bright Yellow
  color12=$color04 # Base 0D - Bright Blue
  color13=$color05 # Base 0E - Bright Magenta
  color14=$color06 # Base 0C - Bright Cyan
  color15="FF/FF/FF" # Base 07 - Bright White
  color16="F7/8C/6C" # Base 09
  color17="FF/53/70" # Base 0F
  color18="30/30/30" # Base 01
  color19="35/35/35" # Base 02
  color20="B2/CC/D6" # Base 04
  color21="EE/FF/FF" # Base 06
fi;
color_foreground="EE/FF/FF" # Base 05
color_background="21/21/21" # Base 00

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
  put_template_custom Pg EEFFFF # foreground
  put_template_custom Ph 212121 # background
  put_template_custom Pi EEFFFF # bold color
  put_template_custom Pj 353535 # selection color
  put_template_custom Pk EEFFFF # selected text color
  put_template_custom Pl EEFFFF # cursor
  put_template_custom Pm 212121 # cursor text
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
