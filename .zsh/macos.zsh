export PATH="/opt/homebrew/bin:$PATH" # Apple Silicon
export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
export MANPATH=/opt/local/man:$MANPATH

export PATH=/usr/local/bin/git:$PATH # Homebrew の Git

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# === PostgresQL ===
export PGDATA='/opt/homebrew/bin/postgres'

# === MySQL ===
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# === anyenv ===
# eval "$(anyenv init -)"

# === online-judge-tools ===
export PATH="$HOME/Library/Python/3.13/bin:$PATH"

# === zsh-abbr ===
source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh

# === asdf installed by brew ===
# . /opt/homebrew/opt/asdf/libexec/asdf.sh # v0.15
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH" # v0.16

# === Go packages ===
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
