##### 見た目 #####

source ./.zsh/prompt.zsh

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

# git
function g () {
    [[ $# -eq 0 ]] && git status || git "$@"
}

# 2024/01/30 Homebrew 用のパスを指定
export PATH=/opt/homebrew/bin:$PATH

# OSがLinuxかMacOSかで読み込むファイルを変更
case ${OSTYPE} in
  darwin*)
    echo "Running on macOS"
    source ./.zsh/macos.zsh
    ;;
  linux*)
    echo "Running on Linux"
    source ./.zsh/linux.zsh
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
