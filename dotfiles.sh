#!/bin/zsh -

# -u: 未知の変数を使うときにエラー
set -u

git submodule init
git submodule update

# .から始まるファイル/ディレクトリにシンボリックリンクを貼る
# 参考: http://vdeep.net/github-dotfiles
echo "start setup..."
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = ".require_oh-my-zsh" ] && continue
    [ "$f" = ".gitmodules" ] && continue
    [ "$f" = ".zshrc.linux" ] && continue
    [ "$f" = ".zshrc.macos" ] && continue

    ln -snfv ~/ghq/github.com/kattsun44/dotfiles/"$f" ~/
done

# home/binディレクトリのシンボリックリンク
ln -snfv ~/ghq/github.com/kattsun44/dotfiles/bin ~/bin

source ~/.zshrc
tmux source ~/.tmux.conf

cat << END

===============
Setup Finished!
===============

END
