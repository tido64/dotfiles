#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
HISTFILE=~/.zsh_history
HISTSIZE=SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# Don't commit commands that failed to history
#zshaddhistory() { whence ${${(z)1}[1]} > /dev/null || return 1 }

# Enable autocompletion
autoload -Uz compinit
compinit

# ..<tab> adds slash
zstyle ':completion:*' special-dirs true

export DOTNET_CLI_TELEMETRY_OPTOUT=1
export GPG_TTY=$(tty)

dotfiles_root="$(cd -P $(dirname $(readlink -f ${(%):-%N})) && pwd)"

case $(uname) in
  'Darwin')
    export LC_NUMERIC=no_NO.UTF-8
    export LC_TIME=no_NO.UTF-8
    export LC_COLLATE=no_NO.UTF-8
    export LC_MONETARY=no_NO.UTF-8
    export LC_MESSAGES=en_US.UTF-8

    export ANDROID_HOME=$HOME/Library/Android/sdk
    export COCOAPODS_DISABLE_STATS=true
    export GEM_HOME=$HOME/.gem
    export HOMEBREW_HOME=/opt/homebrew
    export HOMEBREW_NO_ANALYTICS=1
    export N_PREFIX=$HOME/.local
    export REACT_EDITOR='/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code'

    export PATH=$ANDROID_HOME/platform-tools:$GEM_HOME/bin:$N_PREFIX/bin:$HOMEBREW_HOME/opt/ruby/bin:$HOMEBREW_HOME/bin:$PATH
    export PROMPT='%n@%m %1~ %% '

    alias android-studio='open -a "Android Studio"'
    alias clang-tidy='/usr/local/opt/llvm/bin/clang-tidy'
    alias npi="$dotfiles_root/script/npi"
    alias ls='ls -Gl'
    alias vim='nvim'

    #pgrep -x ssh-agent 1> /dev/null || eval $(ssh-agent) 1> /dev/null
    ;;
  'Linux')
    if [ -x /usr/bin/tput ] && tput setaf 1 >& /dev/null; then
      PROMPT=$'\e[01;32m%n@%m\e[0m:\e[01;34m%0~\e[0m$ '
    else
      PROMPT='%n@%m:%0~$ '
    fi
    alias ls='ls --color=auto -Gl'
    alias vim='nvim'
    ;;
esac

# https://iterm2.com/documentation-shell-integration.html
if [[ $LC_TERMINAL == iTerm2 ]]; then
  source $dotfiles_root/script/iterm2_shell_integration.zsh
fi

# https://www.rust-lang.org/
if [[ -f ~/.cargo/env ]]; then
  source ~/.cargo/env
fi

# https://github.com/nvbn/thefuck
if command -v thefuck 1> /dev/null; then
  eval $(thefuck --alias)
fi
