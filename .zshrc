##### 見た目 #####

# git ブランチ名を色付きで表示させるメソッド
function git_current_branch {
  local branch_name st branch_status
 
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    branch_name=""
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}
 
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
 
PROMPT=$'%F{green}[%D{%Y/%m/%d} %*] %U%~%u%f `git_current_branch` %F{green}%f \n%n %# '

# tmuxのペイン背景色変更
function ssh() {
  # tmux起動時
  if [[ -n $(printenv TMUX) ]] ; then
      # 現在のペインIDを記録
      local pane_id=$(tmux display -p '#{pane_id}')
      # 接続先ホスト名に応じて背景色を切り替え
      if [[ `echo $1 | grep 'prod'` ]] ; then
          tmux select-pane -P 'bg=colour52,fg=white'
      elif [[ `echo $1 | grep 'stg'` ]] ; then
          tmux select-pane -P 'bg=colour25,fg=white'
      fi

      # 通常通りssh続行
      command ssh $@

      # デフォルトの背景色に戻す
      tmux select-pane -t $pane_id -P 'default'
  else
      command ssh $@
  fi
}

##### 履歴 #####
HISTFILE=~/.zsh_history
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS # 重複したコマンドは履歴に残さない
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

# fzf で絞り込んで選択した過去コマンドを (改行を削除して) コマンドラインに展開する関数
function fzf-select-history (){
  BUFFER=$(history -n -r 1 | fzf | tr -d '\n')
  CURSOR=$#BUFFER
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

##### alias #####
alias -- -="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -g C="| pbcopy"
alias a="./a.out"
alias cp="cp -v"
alias his="history | grep"
alias md="mkdir"
alias cl="clear"
alias path="echo $PATH | tr ':' '\n'"
alias ls="ls -A"
alias ll="ls -lA"
alias sl="ls"
alias esit="exit"
alias xit="exit"
alias mux="tmuxinator"
alias sed="gsed"

# docker
alias dc="docker compose"
alias dce="docker compose exec"

# anaconda
alias ca="conda activate"
alias cda="conda deactivate"

# git
function g () {
    [[ $# -eq 0 ]] && git status || git "$@"
}
alias aliasgit="alias | grep 'git '"
alias gitalias="aliasgit"

alias ga="git add"
alias gaa="git add -A"

alias gb="git branch"

alias gc="git commit -v"
alias gca="git commit -v --amend"

alias gf="git fetch"
alias gl="git log --stat"
alias glo="git log --oneline"
alias gm="git merge"

alias gpl="git pull"
alias gplo="git pull origin"
alias gps="git push"
alias gpso="git push origin"

alias gd="git diff"
alias gds="git diff --staged"

alias gr="git rebase"
alias gri="git rebase -i"
alias gs="git switch"
alias gsc="git switch -c"

alias py="python3"
alias src="source"

alias vi="nvim"
alias nv="nvim"
alias view="nvim -R"

# online-judge-tools
alias ojtp="oj t -c "python3 main.py""
alias ojsp="oj s main.py"
alias ojspp="oj s --guess-python-interpreter pypy main.py"

# OSがLinuxかMacOSかで読み込むファイルを変更
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
test -e /Users/kattsun/.iterm2_shell_integration.zsh && source /Users/kattsun/.iterm2_shell_integration.zsh || true

# Ruby3.0インストール用
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# 重複パス削除 https://orebibou.com/ja/home/202101/20210104_001/
export PATH=$(printf %s "$PATH" | awk -v RS=: -v ORS=: '!arr[$0]++')

eval TWILIO_AC_ZSH_SETUP_PATH=/Users/yoshihiro.katsuhara/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH; # twilio autocomplete setup

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kattsun/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kattsun/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kattsun/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kattsun/google-cloud-sdk/completion.zsh.inc'; fi
