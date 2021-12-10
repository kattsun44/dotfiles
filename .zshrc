# 見た目
export PS1="%F{green}%~ %n %f"

# 履歴
HISTFILE=~/.zsh_history
SAVEHIST=100
setopt HIST_IGNORE_DUPS # 直前のコマンドと同じなら、履歴に残さない
setopt share_history # 他のzshで履歴を共有する
setopt inc_append_history # 即座に履歴を保存する

# sshホスト名を補完
autoload -U compinit && compinit

function print_known_hosts (){
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
    fi
}
_cache_hosts=($( print_known_hosts ))

##### alias #####
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias a="./a.out"
alias md="mkdir"
alias cl="clear"

# anaconda
alias ca="conda activate"
alias cda="conda deactivate"

# git
alias aliasgit="alias | grep git"
alias gitalias="alias | grep git"
alias g="git"
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gco="git checkout"
alias gcm="git commit -m"
alias glog="git log"
alias gm="git merge"
alias gpl="git pull origin"
alias gps="git push origin"
alias gpfs="git push -f origin"
alias gst="git status"
alias gdf="git diff"

alias py="python3"
alias src="source"

alias vi="nvim"
alias vim="nvim"
alias nv="nvim"
alias view="nvim -R"

# online-judge-tools
alias ojtp="oj t -c "python3 main.py""
alias ojsp="oj s main.py"
alias ojspp="oj s --guess-python-interpreter pypy main.py"

case ${OSTYPE} in
    darwin*)
        echo "Running on macOS"
        source ~/dotfiles/.zshrc.macos
        ;;
    linux*)
        echo "Running on Linux"
        source ~/dotfiles/.zshrc.linux
esac

if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
