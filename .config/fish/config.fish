if not status is-interactive
    return
end

set fish_escape_delay_ms 200
set fish_greeting

set --global --export DISABLE_PII_TELEMETRY 1
set --global --export DOTNET_CLI_TELEMETRY_OPTOUT 1
set --global --export DO_NOT_TRACK 1

set dotfiles_root $HOME/Source/dotfiles

switch (uname)
case Darwin
    set --global --export LC_NUMERIC no_NO.UTF-8
    set --global --export LC_TIME no_NO.UTF-8
    set --global --export LC_COLLATE no_NO.UTF-8
    set --global --export LC_MONETARY no_NO.UTF-8
    set --global --export LC_MESSAGES en_US.UTF-8

    set --global --export COCOAPODS_DISABLE_STATS true
    set --global --export HOMEBREW_NO_ANALYTICS 1

    set --global --export ANDROID_HOME $HOME/Library/Android/sdk
    set --global --export GEM_HOME $HOME/.gem
    set --global --export HOMEBREW_HOME /opt/homebrew
    set --global --export N_PREFIX $HOME/.local

    set --global --export CCACHE_LIBEXEC $HOMEBREW_HOME/opt/ccache/libexec
    set --global --export EDITOR nvim
    set --global --export REACT_EDITOR '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code'

    fish_add_path \
        $ANDROID_HOME/platform-tools \
        $GEM_HOME/bin \
        $N_PREFIX/bin \
        $HOMEBREW_HOME/opt/ruby/bin \
        $HOMEBREW_HOME/bin

    abbr --add android-studio open -a '"Android Studio"'
    abbr --add clang-tidy /usr/local/opt/llvm/bin/clang-tidy
    abbr --add npi $dotfiles_root/script/npi
    abbr --add ls ls -Gl

case Linux
    abbr --add ls ls --color=auto -Gl
end

abbr --add vim nvim
abbr --add ~rnta cd $(dirname $dotfiles_root)/react-native-test-app
abbr --add ~rnx-kit cd $(dirname $dotfiles_root)/rnx-kit

# https://iterm2.com/documentation-shell-integration.html
if test "$LC_TERMINAL" = "iTerm2"
    source $dotfiles_root/script/iterm2_shell_integration.fish
end
