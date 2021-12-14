##### 見た目 #####
export PS1="%F{green}[%D{%Y/%m/%d} %*]%. %n %f"

# git ブランチ名を色付きで表示させるメソッド
function rprompt_git_current_branch {
  local branch_name st branch_status
 
  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
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
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt_git_current_branch`'

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
SAVEHIST=10000
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
alias ,="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias a="./a.out"
alias his="history | grep"
alias md="mkdir"
alias cl="clear"

# anaconda
alias ca="conda activate"
alias cda="conda deactivate"

# git
alias aliasgit="alias | grep git"
alias gitalias="aliasgit"
alias g="git"
alias ga="git add"
alias gaa="git add -A"
alias gb="git branch"
alias gco="git checkout"
alias gcm="git commit -m"
alias glog="git log"
alias glogf="git log --follow"
alias gm="git merge"
alias gpl="git pull origin"
alias gps="git push origin"
alias gpfs="git push -f origin"
alias gst="git status"
alias gdf="git diff"

alias py="python3"
alias src="source"
#alias ssh="~/bin/ssh-with-change-bgc.sh"

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
test -e /Users/kattsun/.iterm2_shell_integration.zsh && source /Users/kattsun/.iterm2_shell_integration.zsh || true
