HISTFILE=~/.zsh_history
SAVEHIST=100

eval "$(~/.anyenv/bin/anyenv init -)"
export PATH="$HOME/.anyenv/bin:$PATH"

#ojのパス
export PATH="/home/kattsun/.local/bin:$PATH"

export PS1='%F{green}%~ %n %f'

#直前のコマンドと同じなら、履歴に残さない
setopt HIST_IGNORE_DUPS

alias ..='cd ..'
alias a='./a.out'
alias ca='conda activate'
alias cda='conda deactivate'
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gco='git checkout'
alias gcm='git commit -m'
alias gpl='git pull origin'
alias gps='git push origin'
alias gs='git status'
alias gst='git stash'
alias md='mkdir'
alias py='python3'
alias src='source'
alias v='vim'
alias ojtp='oj t -c "python3 main.py"'
alias ojsp='oj s main.py'
alias ojspp='oj s --guess-python-interpreter pypy main.py'
