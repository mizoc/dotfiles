#powerline-shell
# function _update_ps1() {
#    PS1=$(powerline-shell $?)
# }
#
# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi
#
if [ $UID -eq 0 ]; then
		PS1="\[\n\e[1;31m\]\u@\h:\[\e[1;37m\] \w \n\[\e[1;31m\][\s]\[\e[1;37m\]\\$"
else
		PS1="\[\n\e[1;32m\]\u@\h:\[\e[1;37m\] \w \n\[\e[1;34m\][\s]\[\e[1;37m\]\\$"
fi
[ -f /home/taichi/src/alacritty/extra/completions/alacritty.bash ] && source /home/taichi/src/alacritty/extra/completions/alacritty.bash
