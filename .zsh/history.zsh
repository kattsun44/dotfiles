##### 履歴 #####
HISTFILE=~/.zsh_history
SAVEHIST=50000

setopt HIST_IGNORE_ALL_DUPS # 重複したコマンドは履歴に残さない
setopt share_history # 他のzshで履歴を共有する
setopt inc_append_history # 即座に履歴を保存する
