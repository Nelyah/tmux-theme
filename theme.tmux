#!/bin/bash

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

set_env() {
   local option=$1
   local value=$2
   tmux set-environment -g "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

add_module () {
    local module_name="$1"
    local bg_left="$2"
    local bg_right="$3"
    local fg_left="$4"
    local fg_right="$5"
    local text_left="$6"
    local text_right="$7"
    local bold="$8"

    if [ -n "$bold" ]; then
        bold=",bold"
    fi

    local left_side="#[fg=#{T:${bg_left}},bg=#{T:colour_bg},bold]#[fg=#{T:${fg_left}},bg=#{T:${bg_left}}]${text_left}"
    local right_side="#[default]#[fg=#{T:${fg_right}},bg=#{T:${bg_right}}${bold}] ${text_right}#[fg=#{T:${bg_right}},bg=#{T:colour_bg},bold]#[default]"
    set_env "${module_name}" "${left_side}${right_side}"
}

setw mode-style bold
setw mode-style fg=colour75
set status-position bottom
set status-left ''
setw window-status-current-style bold

setw window-status-style fg=colour9
setw window-status-style none
setw window-status-bell-style bold
setw window-status-bell-style fg=colour255
setw window-status-bell-style bg=colour75


set_env colour_bg "#282c34"
set_env colour_grey_dark "#383d47"
set_env colour_grey_medium "#4d4d4d"
set_env colour_grey_light "#888c94"
set_env colour_blue_ish "#80aaff"
set_env colour_pink_ish "#ffb3ff"
set_env colour_gold_ish "#e5c07b"
set_env colour_white "#c5cad3"


set status-style bg='#{T:colour_bg}'

set message-style bold
set message-style fg="#99ccff"
set message-style bg="#{T:colour_bg}"

set_env window_sep_left "#[fg=#{T:colour_grey_medium},bg=#{T:colour_bg}]#[fg=#{T:colour_white},bg=#{T:colour_grey_medium}]#I #[fg=#{T:colour_white},bg=#{T:colour_grey_medium}]"
set_env window_sep_right "#[fg=#{T:colour_grey_medium},bg=#{T:colour_bg},bold]#[default]"
set_env active_window_sep_left "#[fg=#{T:colour_blue_ish},bg=#{T:colour_bg}]#[fg=#{T:colour_bg},bg=#{T:colour_blue_ish}]#I #[fg=#{T:colour_white},bg=#{T:colour_grey_medium}]"
set window-status-format '#{T:window_sep_left} #W#{T:window_sep_right} '
set window-status-current-format '#{T:active_window_sep_left} #W#{T:window_sep_right} '

# module_name bg_left bg_right fg_left fg_right text_left text_right bold?
add_module status_time colour_grey_light colour_grey_light colour_bg colour_bg "" "%H:%M:%S " bold
add_module status_date colour_pink_ish colour_grey_medium colour_bg colour_white "󰃰 " "%d/%m" ""
add_module status_network colour_blue_ish colour_grey_medium colour_bg colour_white "󰛵 " "#h" ""
add_module status_cpu colour_gold_ish colour_grey_dark colour_bg colour_bg "CPU " \
    "#(#{T:TMUX_PLUGIN_MANAGER_PATH}/tmux-cpu/scripts/cpu_fg_color.sh)#(#{T:TMUX_PLUGIN_MANAGER_PATH}/tmux-cpu/scripts/cpu_percentage.sh)" ""
add_module status_ram colour_gold_ish colour_grey_dark colour_bg colour_bg "RAM " \
    "#(#{T:TMUX_PLUGIN_MANAGER_PATH}/tmux-cpu/scripts/ram_fg_color.sh)#(#{T:TMUX_PLUGIN_MANAGER_PATH}/tmux-cpu/scripts/ram_percentage.sh)" ""

# set inactive/active window styles
set window-style 'fg=#8b95a7,bg=#282c34'
set window-active-style 'fg=#abb2bf,bg=#282c34'

set pane-border-style bg='#{T:colour_bg}'
set pane-border-style fg='#484c54'
set pane-active-border-style bg='#{T:colour_bg}'
set pane-active-border-style fg='#484c54'
