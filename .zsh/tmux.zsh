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
