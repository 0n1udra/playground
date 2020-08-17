#                   ========== Terminal UI ==========
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

# ========== Color
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	blue=$(tput setaf 33);
	orange=$(tput setaf 166);
	red=$(tput setaf 124);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	orange="\e[1;33m";
	red="\e[1;31m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_YELLOW='\e[1;33m'

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
    #This only works if you use sudo -i not su. git prompt will break
	userStyle="${COLOR_YELLOW}";
	symbol="#"; else userStyle="${COLOR_LIGHT_RED}"; symbol="$"
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
        hostStyle="${bold}${red}";
else
        hostStyle="${yellow}";
fi;

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"; # working directory base name
PS1+="\[${bold}\]\n"; # newline
PS1+="\[${orange}\]\H"; # Host Computer name
PS1+="\[${white}\]:";
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\] > ";
PS1+="\[${COLOR_GREEN}\]\w"; # working directory full path
PS1+="\n";
PS1+="\[${white}\]${symbol}> \[${reset}\]"; # `$/#` (and reset color)
export PS1;

# Vi mode with ctrl-[
set -o vi

# Enable aliases to be sudo’ed
alias sudo='sudo '

# ==== tmux
alias tmuxa='tmux a -t'
alias tmuxl='tmux ls'
alias tmuxs='tmux new -s'
alias tmuxkill='tmux kill-server'


# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias ngrep='grep -rnwiI ./ -e'

# ==========  File System 

# ==== ls
alias ls='ls -Fh'
alias lsr='ls -FRh'
alias la='ls -Fha'
alias ll='ls -Fhal'
alias lc='ls -Fha --color'
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"


# === Config Files
alias sourcebf="source ~/.profile"
alias viprofile='vim ~/.profile'
alias virc='vim ~/.vimrc'
alias vitmux='vim ~/.tmux.conf'
alias vissh='vim /etc/ssh/sshd_config'


# ========== Coding
alias python='python3'
alias vi='vim'

# ===== git
alias gogit='cd ~/git'
alias goconfig='cd ~/git/Personal/Config_Files'
alias goslime='cd ~/git/TenseiPy/source'

alias slime='goslime && tmuxs slime'


alias shortcuts='echo "
ctrl-[      --  VI Mode         |   alt-a-[     --  VI Copy Mode
hold shift  --  System Copy     |   shift-RC    --  System Paste

LC - Left Click, Right Click
"'

# Trash
alias rm='trash'


clear

