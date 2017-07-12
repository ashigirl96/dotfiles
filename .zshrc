# inits
for f in $(ls ${HOME}/.zsh/*.zsh | sort); do
    source $f
done

# theme

if [ -z $THEME_COLOR ]; then
    # default is raspberry
    THEME_COLOR=raspberry
fi

case $THEME_COLOR in
    orange    ) THEME_COLOR=166-172;;
    green     ) THEME_COLOR=28-35;;
    blue      ) THEME_COLOR=25-32;;
    sky       ) THEME_COLOR=32-39;;
    red       ) THEME_COLOR=124-160;;
    raspberry ) THEME_COLOR=125-126;;
    pink      ) THEME_COLOR=198-199;;
    purple    ) THEME_COLOR=90-91;;
    gray      ) THEME_COLOR=240-242;;
esac

export COLOR_DARK=${THEME_COLOR%-*}
export COLOR_LIGHT=${THEME_COLOR#*-}

# profile
PROFILE_DEFAULT_USER=koba789
PROFILE_DEFAULT_HOST=koba789-pro

# color
autoload colors
colors

# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '#%b'
zstyle ':vcs_info:*' actionformats '#%b|%a'
PR_USER="%U%n%u%F{250}@%f"
PR_COLON="%F{250}:%f"
PR_HOST="%m${PR_COLON}"
PR_HOST_H="%B%K{$COLOR_DARK}%m%k%b${PR_COLON}"
precmd() {
    LANG=en_US.UTF-8 vcs_info
    PROMPT="%F{blue}%~%F{green}${vcs_info_msg_0_}%F{250}%(!.#.$)%f "
    if [ $PROFILE_DEFAULT_HOST != $(hostname -s) ]; then
        PROMPT="${PR_HOST_H}${PROMPT}"
        if [ $PROFILE_DEFAULT_USER != $(whoami) ]; then
            PROMPT="${PR_USER}${PROMPT}"
        fi
    elif [ $PROFILE_DEFAULT_USER != $(whoami) ]; then
        PROMPT="${PR_USER}${PR_HOST}${PROMPT}"
    fi
}

# completion
autoload -U compinit
compinit
autoload bashcompinit
bashcompinit
zstyle ":completion:*:commands" rehash 1

# npm completion
if [ -e "${HOME}/.zsh/npm-completion.bash" ]; then
    source "${HOME}/.zsh/npm-completion.bash"
fi

zstyle ':completion:*:default' menu select=1

setopt auto_pushd
setopt auto_cd
setopt nolistbeep
setopt hist_ignore_space

# history
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history

# history search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

# editor
export EDITOR='vim'

# key map
bindkey -e

# PATH
which brew > /dev/null 2>&1 
if [ $? = 0 ]; then
    export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi
# export PATH="${PATH}:/usr/local/bin:/usr/local/sbin"
export PATH="/usr/local/bin:/usr/local/sbin/:${PATH}"
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.rbenv/bin:${PATH}"
export PATH="$PATH:./node_modules/.bin"

# rbenv
which rbenv > /dev/null 2>&1 
if [ $? = 0 ]; then
    eval "$(rbenv init -)"
fi

# ls aliases
alias ls='ls -G'
alias l="ls -G"
alias la="ls"
alias ll="ls -la"
alias sl="ls"

# other aliases
alias fg=" fg"
alias bk=" popd"

# pkgconfig
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig"

# make sandbox
MKSDBX="${HOME}/src/mksdbx/mksdbx"
if [ -f $MKSDBX ]; then
    source $MKSDBX
fi

export TF_DATA="~/datasets"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}
zle -N peco-select-history
bindkey '^R' peco-select-history
export PATH="/usr/local/opt/opencv3/bin:$PATH"
alias pt="ptipython"
export PATH="/usr/local/opt/qt/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ashigirl96/src/web/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ashigirl96/src/web/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ashigirl96/src/web/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ashigirl96/src/web/google-cloud-sdk/completion.zsh.inc'; fi
export GOOGLE_APPLICATION_CREDENTIALS="/Users/ashigirl96/src/web/.Psycho-Dive-82b104834cf6.json"

alias g="g++ -std=c++11"

eval "$(pyenv virtualenv-init -)"
export PATH="/Users/ashigirl96/.anaconda3/bin":$PATH
export PGDATA=/usr/local/var/postgres
