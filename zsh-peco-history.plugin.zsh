# zsh-peco-history
# Search shell history with peco when pressing ctrl+r.
# https://github.com/jimeh/zsh-peco-history
#
# Based on: https://github.com/mooz/percol#zsh-history-search
# Get peco from: https://github.com/peco/peco
#
if which peco &> /dev/null; then
  function peco_select_history() {
    local tac
    ((($+commands[gtac])) && tac="gtac") || \
      (($+commands[tac])) && tac="tac" || \
      tac="tail -r"
    BUFFER=$(fc -l -n 1 | eval $tac | \
               peco --layout=bottom-up --query "$LBUFFER")
    CURSOR=$#BUFFER # move cursor
    zle -R -c       # refresh
  }

  zle -N peco_select_history
  bindkey '^R' peco_select_history
fi

function peco-ghq-cd () {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        selected_dir="`ghq root`/$selected_dir"
        BUFFER="cd ${selected_dir}"
    fi
    zle clear-screen
}
zle -N peco-ghq-cd
bindkey '^w' peco-ghq-cd

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ### search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^Z' peco-cdr
