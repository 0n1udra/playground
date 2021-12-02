#                   ========== Terminal UI ==========
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color'; fi;

# ========== Color
if tput setaf 1 &> /dev/null; then 
    tput sgr0; bold=$(tput bold); reset=$(tput sgr0); blue=$(tput setaf 33); orange=$(tput setaf 166); red=$(tput setaf 124); white=$(tput setaf 15); yellow=$(tput setaf 136);
else bold=''; reset="\e[0m"; orange="\e[1;33m"; red="\e[1;31m"; white="\e[1;37m"; yellow="\e[1;33m"; fi;
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
else hostStyle="${yellow}"; fi;

# Set the terminal title and prompt.
PS1="\[${orange}\]\H"; # Host Computer name
PS1+="\[${white}\]>";
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\]>";
PS1+="\[${COLOR_GREEN}\]\w"; # working directory full path
PS1+="\[${white}\]\n> \[${reset}\]"; # `$/#` (and reset color)
export PS1;

# Vi mode with ctrl-[
set -o vi

# ========== Shortcuts
# Enable aliases to be sudo’ed
alias sudo='sudo '
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Always enable colored `grep` output
alias grep='grep --color=auto'
alias ngrep='grep -rnwiI ./ -e'
alias python='python3'
alias vi='vim'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias usync='rsync -rvuP'
alias btop='python -m bpytop'
alias jar='java -Xmx2G -Xms1G -jar'

alias srcslime='source /home/0n1udra/pyenvs/slime_server/bin/activate'

# === Config Files
alias srcprofile="source ~/.profile"
alias viprofile='vim ~/.profile'
alias virc='vim ~/.vimrc'
alias vitmux='vim ~/.tmux.conf'
alias vissh='vim /etc/ssh/sshd_config'

# === Scripts
alias tsetup='gogit && python playground/utils/tmux_setup.py'
alias tsetupapp='gogit && python playground/utils/tmux_setup.py starttmux startapp'
alias tsetupall='gogit && python playground/utils/tmux_setup.py starttmux startapp startbots attachtmux'
alias startbots='gogit && python playground/utils/tmux_setup.py startbots'
alias slimebot='srcslime && goslime && python run_bot.py startbot'
alias sandownbot="gogit && python sandown_channel17/source/channel17_bot.py"

# === ls
alias ls='ls -Fh'
alias lsr='ls -FRh'
alias la='ls -Fha'
alias ll='ls -Fhal'
alias lc='ls -Fha --color'
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# === tmux
alias tmuxa='tmux a -t'
alias tmuxl='tmux ls'
alias tmuxs='tmux new -s'
alias tmuxk='tmux kill-session -t'
alias tmuxks='tmux kill-session '
alias sess='tmuxa sess'

# === git
alias gogit='cd ~/git'
alias goconfig='cd ~/git/Personal/Config_Files'
alias goslime='cd ~/git/slime_server/source'
alias gotensei='cd ~/git/TenseiPy/source'
alias gojux='cd ~/git/jux.photos/jux_photos'
alias gomc='cd ~/Games/Minecraft'


# === Django
alias migrate='python manage.py makemigrations && python manage.py migrate'
alias run='python manage.py runserver'
alias mrun='migrate && run'
alias csuper='python manage.py createsuperuser'
alias srcdjango='source ~/pyenv/django_env/bin/activate'


alias shortcuts='echo "
:Aliases:
goslime  - MC server bot  |  gojux - jux_photos
gogit    - git            | goconfig - config files
gomc     - MC Game folder |
usync    - rsync -rvuP    |  ip    - get public ip
jar      - jar 1-2G

:Scripts:
tsetup/tsetupapp/tsetupall - tmux_setup.py (startapp/startall attachtmux)
slimebot   - srcslime && gogit && python slime_server.py
sandownbot - Sandown Channel17 bot

:System:
viprofile   - vi .profile   | virc      - vi .vimrc
vitmux      - vi .tmux.conf | vissh     - /etc/ssh/sshd_config
srcprofile  - src .profile  | srcdjango - src django_env

:Tmux:
tmuxa - attach | tmuxk  - kill
tmuxl - list   | tmuxks - Kill current session
tmuxs - new

:Django:
run    - runserver     | mrun    -  migrate && run  
csuper - new superuser | migrate -  makemigrations && migrate

:Extra:
ctrl-[      --  VI Mode         |   alt-a-[     --  VI Copy Mode
hold shift  --  System Copy     |   shift-RC    --  System Paste
LC - Left Click, Right Click
"'
alias a='shortcuts'

clear

