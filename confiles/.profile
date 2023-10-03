# Set user. Needed because this is missing when go into tmux session.
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ];
then
    HOM="/mnt/c/Users/0n1udra"
    GIT="/mnt/c/Users/0n1udra/git"
else
    HOM=~/
    GIT=~/git
fi
USER=$(whoami)
#                   ========== Terminal UI ==========
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color'; fi;

# ========== Color
eval "$(dircolors ~/.dircolors)"; # Loads custom colors for ls

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


# Highlight the user name when logged in as root, everyone else not set gets blue.
if [[ "${USER}" == "root" ]]; then userStyle="${white}"; else userStyle="${blue}"; fi;
if [[ "${USER}" == "arcpy" ]]; then userStyle="${COLOR_PURPLE}"; fi;
if [[ "${USER}" == "pop_mbp" ]]; then userStyle="${yellow}"; fi;
if [[ "${USER}" == "dt" ]]; then userStyle="${red}"; fi;
if [[ "${USER}" == "0n1udra" ]]; then userStyle="${COLOR_CYAN}"; fi;

# Set the terminal title and prompt.
PS1="\[${orange}\]\H"; # Host Computer name
PS1+="\[${white}\]>";
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${white}\]>";
PS1+="\[${green}\]\w"; # working directory full path
PS1+="\[${white}\]\n> \[${reset}\]"; # `$/#` (and reset color)
export PS1;

export EDITOR='vim'

# ========== Common Commands
set -o vi # Vi mode with ctrl-[
alias sudo='sudo ' # Enable aliases to be sudo’ed
alias vi='vim'
alias suvi='sudo vim'
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias lsblko='lsblk -o KNAME,TYPE,SIZE,MODEL'
alias diff='diff --color'
alias df='df -Th --total'
alias dfa='df -Tha --total'
alias fless='less +F'
alias watch1='watch -c -n 1'
alias grep='grep --color'
alias ngrep='grep -rnwiI ./ -e'

# Doesn't show ./ ../

alias ls='ls -AF --group-directories-first --color'
alias lnc='ls -AF --group-directories-first --color=no'
# Mac can't take args with --
if [[ "${USER}" == "0n1udra-MBP" ]]; then alias ls='ls -AF'; fi;
alias lh='ls -hsS'  # Show sizes (not total, use du)
alias lsr='ls -FRh'  # Recursive
alias ll='ls -Fhl'

alias fc='echo File count: $(find . -maxdepth 1 -type f | wc -l)'
alias ic='echo Item count: $(ls | wc -l)'


# === Paths
alias godt="cd /mnt/c/Users/0n1udra"
alias gosteam="cd ~/.steam/steam/steamapps/common/"
alias gomc='cd $HOM/Games/Minecraft'
alias gogit='cd $GIT'
alias goliquorbot='cd $HOM/git/liquor_bot/source'
alias goliquorsite='cd $GIT/liquor_site/'
alias goconfig='cd $HOM/git/Personal/Config_Files'
alias goslime='cd $HOM/git/slime_server/source'
alias gotensei='cd $HOM/git/TenseiPy/source'
alias gosandown='cd $HOM/git/sandown_channel17/source'
alias goplay='cd $HOM/git/playground/'
alias goscripts='cd $HOM/git/playground/scripts'
alias goraid1='cd /mnt/raid1/'

# === Config Files
alias srcprofile="source ~/.profile"
alias viprofile='vim ~/.profile'
alias virc='vim ~/.vimrc'
alias vitmux='vim ~/.tmux.conf'

# === SSH
alias marcpy="mosh --ssh='ssh -p 3405' parcpy"
alias lssh='ss | grep -i ssh'
alias visshd='sudoedit /etc/ssh/sshd_config'
alias vissh='vim ~/.ssh/config'

# === tmux
alias tmuxa='tmux a -t'
alias tmuxl='tmux ls'
alias tmuxs='tmux new -s'
alias tmuxk='tmux kill-session -t'
alias tmuxks='tmux kill-session '
alias sess='tmuxa sess'
alias vhserver='tmuxa vhserver'

# === rsync
alias rsync='rsync -hvPr --stats'
alias async='rsync -a --delete'
alias usync='rsync -u'
alias isync='async --ignore-existing'
alias dsync='usync --ignore-existing --delete'
alias dasyncliquorphotos='dsync $HOM/Pictures/liquor_boxes/ arcpy:~/Pictures/liquor_boxes/'

# === git
alias upprofile='cp ~/.profile $HOM/git/playground/confiles/'
alias downprofile='cp $HOM/git/playground/confiles/.profile ~/'
alias adplay='scp -r arcpy:~/git/playground/ $HOM/git/'
alias adprofile='scp arcpy:~/.profile $HOM/git/playground/confiles/'
alias dnliquor='sudo scp -r dekstop:$HOM/git/liquor_site/ ~/'
alias daliquor='sudo scp -r desktop:$HOM/git/liquor_site /mnt/raid1/projects/'
alias daplay='scp -r $HOM/git/playground/ arcpy:~/git/'

# === Django
alias migrate='python3 manage.py makemigrations && python3 manage.py migrate'
alias srcdjango='source ~/pyenvs/liquor_site/bin/activate'
alias run='srcdjango && python3 manage.py runserver'
alias runl='srcdjango && cd $GIT/liquor_site/liquor_project && python3 manage.py makemigrations liquor_app && python3 manage.py migrate && python3 manage.py runsslserver 192.168.1.114:8000 --certificate liquor_files/cert.pem --key liquor_files/key.pem '
alias mrun='migrate && run'
alias csuper='python3 manage.py createsuperuser'
alias liquorsite='cd /srv/liquor_site/ && ./bin/gunicorn_start'

# === Python
alias python='python3'
alias sdwebui='source $HOM/pyenvs/sdiffusion/bin/activate && cd $HOM/git/stable-diffusion-webui && python webui.py --medvram --opt-split-attention --listen'
alias sdwebuilow='source $HOM/pyenvs/sdiffusion/bin/activate && cd $HOM/git/stable-diffusion-webui && python webui.py --lowvram --opt-split-attention --listen'
alias srcslime='source ~/pyenvs/discord2/bin/activate'
alias srcpycord='source ~/pyenvs/pycord/bin/activate'
alias srcliquor='source ~/pyenvs/liquor_site/bin/activate'


# Discord Bots
alias dmsg='python $HOM/git/playground/scripts/matsumoto.py'
alias startbots='python3 $HOM/git/playground/scripts/tmux_setup.py startbots'
alias slimebot='srcslime && goslime && python3 run_bot.py startbot'
alias sandownbot="srcslime && gosandown && python3 channel17_bot.py"
alias liquorbot="deactivate; cd $HOM/git/liquor_bot/source/ && python3 liquor_bot.py"

alias powerdown='python3 $HOM/git/playground/scripts/powerdown.py'
alias tsetup='python3 $HOM/git/playground/scripts/tmux_setup.py starttmux'
alias tsetupb='python3 $HOM/git/playground/scripts/tmux_setup.py basic'
alias tsetupapp='python3 $HOM/git/playground/scripts/tmux_setup.py starttmux startapp startbots'
alias tsetupall='python3 $HOM/git/playground/scripts/tmux_setup.py starttmux startapp startbots attachtmux'

alias pkill='python $HOM/git/playground/scripts/pkill.py'
alias dkill='python $HOM/git/playground/scripts/pkill.py discord'
alias lkill='python $HOM/git/playground/scripts/pkill.py league'
alias cs='shutdown -c; python3 $HOM/git/playground/scripts/desktop_powerdown.py stop'

# === Custom Scripts & Commands/Functions
function duh { du -shc ${1:-./}* | grep -E "M|G|K|0" | sort -h;}

alias getip="dig +short myip.opendns.com @resolver1.opendns.com"
alias btop='bpytop'
alias ntop='watch1 nvidia-smi'
alias wolarc='wakeonlan 00:22:4D:69:AA:CA'
alias liquorstatus='curl -Is arcpy.asuscomm.com'

alias jar='java -Xmx2G -Xms1G -jar'
alias mc='java -server -Xmx4G -Xms2G -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -XX:ParallelGCThreads=2 '

# === Logs
alias logsystem='fless $HOM/system.log'
alias logpwr='fless /var/log/pwrstatd.log'
alias logauth='fless /var/log/auth.log'
alias logfail='fless /var/log/faillog'
alias logboot='fless /var/log/faillog'
alias logliquor='fless $HOM/git/liquor_site/logs/liquor_backend.log'
#alias logval='cd $HOM/Games/valheim/log/console/vhserver-console.log | grep "/2022"'

# ===== ArcPy
alias valheimupdate='steamcmd +login anonymous +app_update 896660 +exit'
alias valheimbackup='cp -r ~/.config/unity3d/IronGate/Valheim/ /mnt/raid1/server_backup/'
alias zomboidupdate='steamcmd +login anonymous +app_update 380870 +exit'

# ===== Nginx
alias rnginx='sudo systemctl restart nginx'
alias snginx='sudo systemctl status nginx'
alias hnginx='sudo systemctl stop nginx'
alias vinginx='sudoedit /etc/nginx/nginx.conf'
alias vinginxliquor='sudoedit /etc/nginx/sites-available/liquor_site.conf'

# ===== systemctl, systemd
alias sysstart='sudo systemctl start'
alias sysrestart='sudo systemctl restart'
alias sysstop='sudo systemctl stop'
alias sysstatus='sudo systemctl status'
alias sysreload='sudo systemctl reload'
alias sysenable='sudo systemctl enable'
alias sysdisable='sudo systemctl disable'



# ===== nhliquors
alias liquorperms='sudo chown -R www-data:www-data /srv && sudo chmod -R g+wr /srv'
alias logliquor='fless /srv/liquor_site/logs/liquor_backend.log'
alias logerrorliquor='fless /srv/liquor_site/logs/nginx-error.log'
alias logaccessliquor='fless /srv/liquor_site/logs/nginx-access.log'
alias liquorstatus='curl -Is https://nhliquors.com'
alias liquorupdate='sudo rm -rf /srv/liq.bak && sudo cp -r /srv/liquor_site /srv/liquor.bak && sudo cp -r ~/liquor_update/* /srv/liquor_site/ && sudo sysrestartliquor'
alias liquorbackup='sudo rm -rf /srv/liq.bak; sudo cp -r /srv/liquor_site /srv/liquor.bak'

alias sysrestartliquor='sudo systemctl restart gunicorn.socket gunicorn.service nginx.service'
alias sysstopliquor='sudo systemctl stop gunicorn.socket gunicorn.service nginx.service'
alias sysstatusliquor='sudo systemctl status gunicorn.socket gunicorn.service nginx.service'

alias viliquorservice='sudoedit /etc/systemd/system/gunicorn.service'

alias fromnhliquors='async nhliquors:/srv/liquor_site/* $GIT/liquor_site/'
#clear

