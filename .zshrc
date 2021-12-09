# 見た目
export PS1='%F{green}%~ %n %f'

# 履歴
HISTFILE=~/.zsh_history
SAVEHIST=100
setopt HIST_IGNORE_DUPS # 直前のコマンドと同じなら、履歴に残さない

##### alias #####
alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias a='./a.out'
alias md='mkdir'

# anaconda
alias ca='conda activate'
alias cda='conda deactivate'

# git
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gb='git branch'
alias gco='git checkout'
alias gcm='git commit -m'
alias gm='git merge'
alias gpl='git pull origin'
alias gps='git push origin'
alias gs='git status'
alias gst='git stash'
alias md='mkdir'

alias py='python3.8'
alias src='source'
alias v='vim'
alias nv='nvim'

# online-judge-tools
alias ojtp='oj t -c "python3.8 main.py"'
alias ojsp='oj s main.py'
alias ojspp='oj s --guess-python-interpreter pypy main.py'

case ${OSTYPE} in
    darwin*)
        echo "Running on OSX"
        source ~/dotfiles/.zshrc.osx
        ;;
    linux*)
        echo "Running on Linux"
        source ~/dotfiles/.zshrc.linux
esac

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
