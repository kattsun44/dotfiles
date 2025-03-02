source ./.zsh/history.zsh
source ./.zsh/prompt.zsh
source ./.zsh/tmux.zsh

# sshホスト名を補完
# ref: https://masudak.hatenablog.jp/entry/20121208/1354977070
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
test -e $HOME/.iterm2_shell_integration.zsh && source $HOME/.iterm2_shell_integration.zsh || true

# Ruby3.0インストール用
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# 重複パス削除 https://orebibou.com/ja/home/202101/20210104_001/
export PATH=$(printf %s "$PATH" | awk -v RS=: -v ORS=: '!arr[$0]++')

eval TWILIO_AC_ZSH_SETUP_PATH=$HOME/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH; # twilio autocomplete setup

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
