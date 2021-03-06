WHOAMI=`whoami`
mkdir /tmp/"$WHOAMI" > /dev/null 2>&1
TRASH=~/.trash_bin
mkdir $TRASH > /dev/null 2>&1

complete -F _longopt -- -
complete -F _longopt -- --
complete -F _longopt -- less

alias -- -='less -RCi'
alias -- --='less -RNCi'

alias ls='ls -F --color=auto'
alias lt='ls -Aglt'
alias ll='ls -alF'

alias ff='find . -type f -name '
alias fd='find . -type d -name '

alias cp='cp -r'

alias jobs='jobs -l'
alias bg_jobs='ps aux | grep "$WHOAMI" | -'

alias cgrep='grep -c'
alias egrap='grep -e'
alias vgrep='grep -v'

alias groups='groups "$WHOAMI"'

#If the last character of the alias value is a space or tab character, then the next command word following the alias is also checked for alias expansion.
alias sudo='sudo '
export PYTHONPATH=${PYTHONPATH}:~

kill_name() {
    sudo kill -9 `ps -aux | grep "$1" | cut -c8-14`
}

keep_only() {
    mv $1 /tmp/"$WHOAMI"
    rm -rf * > /dev/null 2>&1
    mv /tmp/"$WHOAMI"/$1 .
}

mm() {
    cp -rl $1 $2
    rm -r $1
}

cdp() {
    pushd . && cd $1
}

mkcd() {
    mkdir $1 && cd $1
}

pb_notify () {
    curl --header 'Access-Token: '"${PushBullet_AUTH}" \
        --header 'Content-Type: application/json' \
        --data-binary '{"type":"note", "title":"Shell - '"$HOSTNAME"'", "body":"'"$1"'"}' \
        --request POST \
        https://api.pushbullet.com/v2/pushes > /dev/null 2>&1
}

calc () {
    awk "BEGIN { print $*}";
}

myscreen() {
    if [[ $1 == *.* ]] ; then
        echo 'myscreen can not process a command with . charecter. Please note it adds . and .. automaticlly to $PATH';
        return;
    fi
    screen_name=${1// /_};
    screen_name=${screen_name//;/+};
    screen -dmS ${screen_name};
    screen -S ${screen_name} -p 0 -X stuff "PATH=$PATH:.:.. $1\n";
}


trash() {
    dst_path=$TRASH/`pwd`/;
    mkdir -p ${dst_path};
    mv $1 ${dst_path}$1.$(date +"%Y-%m-%d_%H:%M:%S");
}
