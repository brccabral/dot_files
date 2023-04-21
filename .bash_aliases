# some more ls aliases
alias ls='ls --hyperlink=auto --color=auto'
alias ll='ls -alF'
alias la='ls -Alh'
alias l='ls -CF'
alias lm='ls -alh |more' # pipe through 'more'
alias lsize='ls -lSrh' # sort by size
alias ltime='ls -lcrh' # sort by change time
alias laccess='ls -lurh' # sort by access time
alias labc='ls -lap' #alphabetical sort

alias dir='dir --hyperlink=auto --color=auto'
alias vdir='vdir --hyperlink=auto --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#alias colorls='colorls --dark --sd'
#alias lc='colorls -lA --sd'

#alias git-cola='QT_QPA_PLATFORM=wayland QT_QPA_PLATFORMTHEME=qt5ct git-cola'
#alias git-cola='QT_QPA_PLATFORMTHEME=qt5ct git-cola'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

alias ips="ip -c -br a"
alias ports="sudo netstat -tulanp"
alias filesize="du -sh * | sort -h"
alias hg="history|grep"
alias mkdir_r="mkdir -pv"
