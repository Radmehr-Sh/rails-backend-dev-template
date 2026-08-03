# Project Home folder
alias cdapp="cd ${APP_HOME}"

# Rails
alias be='bundle exec'
alias rc='be rails console'
alias rrl='be rails routes > tmp/routes.log; cat tmp/routes.log'
alias rdc='be rails db:create'
alias rdsd='be rails db:schema:dump'
alias rdsl='be rails db:schema:load'
alias rdm='be rails db:migrate'
alias rds='be rails db:migrate:status'
alias rdr='be rails db:rollback'
alias rddrop='be rails db:drop'
alias dbc='be rails dbconsole'
alias rdbc=dbc

# Generic
alias vi='vim'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias ll='ls -l'
alias la='ls -a'
alias lss='ls -ault'
alias sl='ls'
alias l='ls'
alias s='ls'
alias diff='diff -u'

# Set shell prompt
export PS1='\u@\h:[\w]$ '