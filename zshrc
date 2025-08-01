export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
export EDITOR=nvim
export MANPAGER="nvim +Man!"
unset zle_bracketed_paste

alias ls="ls --color"
alias ll="ls -al"
alias llt="ll -tr"
alias lls="ll -Sr"
alias ai="nvim -c 'PrtChat;only'"
alias a="OPENROUTER_API_KEY=$(cat ~/.dotfiles/openrouter_work.key) aider --no-gitignore"
alias c="ccr code"
alias C="ccr code --dangerously-skip-permissions"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n' | tee >(pbcopy)"
function mkcd() { mkdir -p "$@" && cd "$@"; }
function s() {
    kitten ssh \
        --kitten forward_remote_control=yes \
        --kitten login_shell=zsh \
        $@
}
function v() {
    nvim $1
    if [[ -f /tmp/.oil.nvim.cd ]]; then
        cd $(cat /tmp/.oil.nvim.cd)
        rm /tmp/.oil.nvim.cd
    fi
}

# Bootstrap Zinit plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
declare -A ZINIT; ZINIT[NO_ALIASES]=1; source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light sindresorhus/pure
zinit light jeffreytse/zsh-vi-mode
zinit light MichaelAquilina/zsh-autoswitch-virtualenv
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit ice lucid wait
zinit snippet OMZP::fzf
zinit light Aloxaf/fzf-tab

# Plugin config
export FZF_DEFAULT_OPTS="--bind 'tab:accept'"
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
if [[ $(uname) == "Linux" ]]; then
    export AUTOSWITCH_DEFAULT_PYTHON="/usr/bin/python3"
fi


if [[ $(uname) == "Darwin" ]]; then
    if [[ ! -d /opt/homebrew ]]; then
        xcode-select --install
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew bundle --file=~/.dotfiles/Brewfile
        curl -L "https://www.python.org/ftp/python/2.7.18/python-2.7.18-macosx10.9.pkg" \
            --output ~/Downloads/python-2.7.18-macosx10.9.pkg
        open -W ~/Downloads/python-2.7.18-macosx10.9.pkg
        rm /usr/local/bin/python
        rm /usr/local/bin/pip
    fi
    if [[ ! -d ~/.dotfiles ]]; then
        git clone git@github.com:forkd4x/dotfiles.git ~/.dotfiles
        git config --global core.excludesFile ~/.dotfiles/.gitignore
        ln -sf ~/.dotfiles/zshrc ~/.zshrc
        touch ~/.hushlogin
        jq -r '. | to_entries[] | "\(.key)@\(.value)"' ~/.dotfiles/npm.json | xargs -I {} npm install -g {}
        ln -sf ~/.dotfiles/.prettierrc ~/.prettierrc
        ln -sf ~/.dotfiles/aider.conf.yml ~/.aider.conf.yml
        zinit ice from"gh-r" as"program"; zinit light hotovo/aider-desk
        mv ~/.local/share/zinit/plugins/hotovo---aider-desk/aider-desk.app /Applications/aider-desk.app
    fi
    if [[ ! -d ~/.config/hammerspoon ]]; then
        defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
        mkdir -p ~/.config/hammerspoon
        ln -sf ~/.dotfiles/hammerspoon.lua ~/.config/hammerspoon/hammerspoon.lua
    fi
    if [[ ! -d ~/.config/kitty ]]; then
        ln -sf ~/.dotfiles/kitty ~/.config/kitty
        echo "Replacing kitty icon..."
        cp ~/.dotfiles/kitty/kitty-dark.icns /Applications/kitty.app/Contents/Resources/kitty.icns
        sudo rm -rf /Library/Caches/com.apple.iconservices.store
        killall Dock
    fi
    if [[ ! -d ~/.config/nvim ]]; then
        ln -sf ~/.dotfiles/neovim ~/.config/nvim
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"

elif [[ $(uname) == "Linux" ]]; then
    zinit ice from"gh-r" as"program" pick"fd*/fd"; zinit light sharkdp/fd
    zinit ice from"gh-r" as"program"; zinit light junegunn/fzf
    zinit ice from"gh-r" as"program" mv"nvim* -> nvim" pick"nvim"; zinit light neovim/neovim
    zinit ice from"gh-r" as"program" pick"ripgrep*/rg"; zinit light BurntSushi/ripgrep
    zinit ice from"gh-r" as"program"; zinit light ajeetdsouza/zoxide
    if [[ ! -d ~/.dotfiles ]]; then
        git clone https://github.com/forkd4x/dotfiles.git ~/.dotfiles
        ln -sf ~/.dotfiles/zshrc ~/.zshrc
        rm -rf ~/.config/nvim
    fi
    if [[ ! -d ~/.config ]]; then
        mkdir ~/.config
    fi
    if [[ ! -d ~/.config/nvim ]]; then
        ln -sf ~/.dotfiles/neovim ~/.config/nvim
    fi
fi

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # smartcase completion
eval "$(zoxide init zsh)"

# Keep dotfiles updated on remote servers
if [[ $(uname) != "Darwin" ]] && [[ -d ~/.dotfiles/.git ]]; then
    UPDATE_MARKER=~/.dotfiles/.UPDATED
    if [[ ! -f $UPDATE_MARKER ]] || [[ $(find "$UPDATE_MARKER" -mtime +7 -print 2>/dev/null) ]]; then
        echo "Auto-updating dotfiles..."
        (
            cd ~/.dotfiles
            git stash --quiet
            git pull --quiet
            git stash pop --quiet 2>/dev/null || true
        )
        touch $UPDATE_MARKER
        exec zsh
    fi
fi
