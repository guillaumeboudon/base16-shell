#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# dirtysea scheme by Kahlil (Kal) Hodgson

export BASE16_COLOR_00="e0e0e0"
export BASE16_COLOR_01="d0d0d0"
export BASE16_COLOR_02="c0c0c0"
export BASE16_COLOR_03="707070"
export BASE16_COLOR_04="202020"
export BASE16_COLOR_05="000000"
export BASE16_COLOR_06="f8f8f8"
export BASE16_COLOR_07="c4d9c4"
export BASE16_COLOR_08="000090"
export BASE16_COLOR_09="006565"
export BASE16_COLOR_0A="006565"
export BASE16_COLOR_0B="730073"
export BASE16_COLOR_0C="755B00"
export BASE16_COLOR_0D="007300"
export BASE16_COLOR_0E="840000"
export BASE16_COLOR_0F="755B00"

color00="e0/e0/e0" # Base 00 - Black
color01="00/00/90" # Base 08 - Red
color02="73/00/73" # Base 0B - Green
color03="00/65/65" # Base 0A - Yellow
color04="00/73/00" # Base 0D - Blue
color05="84/00/00" # Base 0E - Magenta
color06="75/5B/00" # Base 0C - Cyan
color07="00/00/00" # Base 05 - White
if [ -n "$BASE16_SHELL_DEFAULT_VARIANT" ]; then
  color08="70/70/70" # Base 03 - Bright Black
  color09="00/65/65" # Base 09
  color10="d0/d0/d0" # Base 01
  color11="c0/c0/c0" # Base 02
  color12="20/20/20" # Base 04
  color13="f8/f8/f8" # Base 06
  color14="75/5B/00" # Base 0F
  color15="c4/d9/c4" # Base 07 - Bright White
else
  color08="70/70/70" # Base 03 - Bright Black
  color09=$color01 # Base 08 - Bright Red
  color10=$color02 # Base 0B - Bright Green
  color11=$color03 # Base 0A - Bright Yellow
  color12=$color04 # Base 0D - Bright Blue
  color13=$color05 # Base 0E - Bright Magenta
  color14=$color06 # Base 0C - Bright Cyan
  color15="c4/d9/c4" # Base 07 - Bright White
  color16="00/65/65" # Base 09
  color17="75/5B/00" # Base 0F
  color18="d0/d0/d0" # Base 01
  color19="c0/c0/c0" # Base 02
  color20="20/20/20" # Base 04
  color21="f8/f8/f8" # Base 06
fi;
color_foreground="00/00/00" # Base 05
color_background="e0/e0/e0" # Base 00

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
  put_template_custom Pg 000000 # foreground
  put_template_custom Ph e0e0e0 # background
  put_template_custom Pi 000000 # bold color
  put_template_custom Pj c0c0c0 # selection color
  put_template_custom Pk 000000 # selected text color
  put_template_custom Pl 000000 # cursor
  put_template_custom Pm e0e0e0 # cursor text
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
