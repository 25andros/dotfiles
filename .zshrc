. /usr/share/autojump/autojump.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# push && pop

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Trash-can
alias rm='trash -v'

# STND

alias ll="ls -l"

# Custom commands

alias change='function _(){/home/andros25/.zsh/scripts/change $1}; _'
alias change2='function _(){ddcutil --display 1 setvcp 10 $1 && ddcutil --display 2 setvcp 10 $1 }; _'

# VI MODE 
bindkey -v
export KEYTIMEOUT=1

# VI binding navigation

# Auto-complete custom keys
## <showkey -a> is function to show/keybindings pairs
## binding commands https://github.com/marlonrichert/zsh-autocomplete/blob/main/.zshrc
## binding reference https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Completion


zstyle ':completion:*' menu select
# bindkey '   ' down-line-or-select
# bindkey '' complete-word
 bindkey '^[x' down-line-or-select

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'q' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'x' vi-forward-char
bindkey -v '^?' backward-delete-char

# Auto-completion (load zsh/complist before compinit)

autoload -U compinit; compinit
compinit -i
_comp_options+=(globdots) # With hidden files

# Cusor block or blank

cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# history in cache
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history


plugins=(
git
gh


  )


# ALIAS

alias zshrc='${=EDITOR} ~/.zshrc' # Quick access to the ~/.zshrc file

gitpush() {
      git add .
      git commit -m "$*"
      git pull
      git push
}

alias gp=gitpush

alias vim="/usr/bin/nvim"

alias nz="vim ~/.zshrc"
alias rz="source ~/.zshrc"

# alias to file

lua="/home/andros25/.config/nvim/init.lua"
rc="/home/andros25/.config/nvim/init.vim"

alias nv="vim $lua"
alias rv="source $lua"

# alias to folder

ang="/home/andros25/code/ang"
rdc="./redditClone/src/app"
app="./src/app"
alias go="cd $app && vim ."

alias rdcroll="cd $ang/$rdc && vim ."

# git Bare repo

# alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# suffix alias

alias -s {md,ts,js,html,css}=vim

# Refresh

      # source ~/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /home/andros25/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
