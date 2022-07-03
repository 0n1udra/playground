# Set user. Needed because this is missing when go into tmux session.
USER=$(whoami)
#                   ========== Terminal UI ==========
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color'; fi;

# ========== Color
if tput setaf 1 &> /dev/null; then
tput sgr0; bold=$(tput bold); reset=$(tput sgr0); blue=$(tput setaf 33); orange=$(tput setaf 166); red=$(tput setaf 160); white=$(tput setaf 15); yellow=$(tput setaf 11); green=$(tput setaf 40);blue=$(tput setaf 21);
else bold=''; reset="\e[0m"; orange="\e[1;33m"; red="\e[1;31m"; white="\e[1;37m"; yellow="\e[1;33m"; blue="\e[0;34m"; green="\e[1;32m"; fi;
export COLOR_NC='\e[0m' # No Color
export COLOR_BLACK='\e[0;30m'
export COLOR_GRAY='\e[1;30m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_WHITE='\e[1;37m'


# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then userStyle="${white}"; fi;
if [[ "${USER}" == "arcpy" ]]; then userStyle="${blue}"; fi;
if [[ "${USER}" == "pop_mbp" ]]; then userStyle="${yellow}"; fi;
if [[ "${USER}" == "0n1udra-MBP" ]]; then userStyle="${red}"; fi;
if [[ "${USER}" == "0n1udra" ]]; then userStyle="${COLOR_CYAN}"; fi;

# Set the terminal title and prompt.
PS1="\[${orange}\]\H"; # Host Computer name
PS1+="\[${white}\]>";
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\]>";
PS1+="\[${green}\]\w"; # working directory full path
PS1+="\[${white}\]\n> \[${reset}\]"; # `$/#` (and reset color)
export PS1;


set -o vi # Vi mode with ctrl-[
alias sudo='sudo ' # Enable aliases to be sudo’ed
alias vi='vim'
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias lsblko='lsblk -o KNAME,TYPE,SIZE,MODEL'

# === bash
alias grep='grep --color'
alias ngrep='grep -rnwiI ./ -e'

# Doesn't show ./ ../
alias ls='ls -AF --group-directories-first --color'
alias lh='ls -hsS'  # Show sizes (not total, use du)
alias lsr='ls -FRh'  # Recursive
alias ll='ls -Fhl'

alias fc='echo File count: $(find . -maxdepth 1 -type f | wc -l)'
alias ic='echo Item count: $(ls | wc -l)'

# === Paths
alias gosteam="cd ~/.steam/steam/steamapps/common/"
alias gomc='cd ~/Games/Minecraft'
alias gogit='cd ~/git'
alias goliquor='cd ~/git/liquor_bot/source'
alias goconfig='cd ~/git/Personal/Config_Files'
alias goslime='cd ~/git/slime_server/source'
alias gotensei='cd ~/git/TenseiPy/source'
alias gosandown='cd ~/git/sandown_channel17/source'
alias goplay='cd ~/git/playground/'
alias goscripts='cd ~/git/playground/scripts'

# === Config Files
alias srcprofile="source ~/.profile"
alias viprofile='vim ~/.profile'
alias virc='vim ~/.vimrc'
alias vitmux='vim ~/.tmux.conf'
alias vissh='vim /etc/ssh/sshd_config'

# === tmux
alias tmuxa='tmux a -t'
alias tmuxl='tmux ls'
alias tmuxs='tmux new -s'
alias tmuxk='tmux kill-session -t'
alias tmuxks='tmux kill-session '
alias sess='tmuxa sess'
alias vhserver='tmuxa vhserver'

# === rsync
alias syncliquor='isync ~/Pictures/liquor_boxes/ arcpy:~/Pictures/liquor_boxes/'
alias async='rsync -Pav'
alias usync='rsync -Pauv'  # Only copies updated files
alias isync='usync --ignore-existing'
alias dsync='usync --ignore-existing --delete'

# === git
alias cpprofile='cp ~/.profile ~/git/playground/confiles/'
alias updateprofile='cp ~/git/playground/confiles/.profile ~/'
alias scpplay='scp -r arcpy:~/git/playground/ ~/git/'
alias scpliquor='scp -r ~/git/liquor_site/ arcpy:~/git/'

# === Django
alias migrate='python3 manage.py makemigrations && python3 manage.py migrate'
alias run='python3 manage.py runserver'
alias mrun='migrate && run'
alias csuper='python3 manage.py createsuperuser'
alias srcdjango='source ~/pyenv/django_env/bin/activate'
alias startliquor='cd ~/git/liquor_site/liquor_project/ && python3 start.py'

# === Python
alias python='python3'
alias srcslime='source ~/pyenvs/slime_server/bin/activate'
alias srcliquor='source ~/pyenvs/liquor_site/bin/activate'

alias powerdown='python3 ~/git/playground/scripts/powerdown.py'
alias tsetup='gogit && python3 playground/scripts/tmux_setup.py starttmux'
alias tsetupapp='python3 ~/git/playground/scripts/tmux_setup.py starttmux startapp startbots'
alias tsetupall='python3 ~/git/playground/scripts/tmux_setup.py starttmux startapp startbots attachtmux'
alias startbots='python3 ~/git/playground/scripts/tmux_setup.py startbots'
alias slimebot='srcslime && goslime && python3 ~/git/slime_server/source/slime_bot.py'
alias sandownbot="srcslime && gosandown && python3 ~/git/sandown_channel17/source/channel17_bot.py"
alias dmsg='python ~/git/playground/scripts/matsumoto.py'
alias killl='python ~/git/playground/scripts/kill_league.py kill'
alias cs='shutdown -c; python3 ~/git/playground/scripts/desktop_powerdown.py stop'

# === Scripts & Commands
function duh { du -shc ${1:-./}* | grep -E "M|G|K|0" | sort -h;}

alias getip="dig +short myip.opendns.com @resolver1.opendns.com"
alias btop='bpytop'
alias wolarc='wakeonlan 00:22:4D:69:AA:CA'

alias jar='java -Xmx2G -Xms1G -jar'
alias mc='java -server -Xmx4G -Xms2G -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:ParallelGCThreads=2 '

# === Logs
alias syslog='cat ~/system.log'
alias pwrlog='cat /var/log/pwrstatd.log'
alias vlog='cd ~/Games/valheim/log/console/vhserver-console.log | grep "/2022"'

#clear
