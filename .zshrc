# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/mavix/.zsh/completions:"* ]]; then export FPATH="/home/mavix/.zsh/completions:$FPATH"; fi
# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Set up the prompt
autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# fzf default options
export FZF_DEFAULT_OPTS='--color=16,bg:-1,hl:4,hl+:4,fg:-1,fg+:-1,gutter:-1,pointer:-1,marker:-1,prompt:1 --height 80% --reverse --color border:4 --border=sharp --prompt="➤  " --pointer="➤ " --marker="➤ "'

# bat theme
export BAT_THEME=OneHalfDark

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Manual configuration

PATH=/root/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/mavix/.local/bin

# exports
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:/opt/dart-sass
export SHELL=/usr/bin/zsh

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='exa -la --icons --git --group-directories-first --sort time'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='exa -l --icons --git --group-directories-first --sort time'
alias cat='bat'
alias ..='cd ..'
alias ...='cd ../..'
alias py='python3'
alias grep='grep --color=auto'
alias cp='cp -i'
alias mv='mv -i'
alias dgit='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# alias colors='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-z/zsh-z.plugin.zsh
source /usr/share/zsh-sudo/sudo.plugin.zsh

# Functions
function mkt(){
	mkdir {nmap,content,exploits,scripts}
}

function search_and_open_file_with_nvim {
	fd  --type f --hidden --exclude .git --print0 | fzf --preview \
		'bat --color=always --style=numbers {}' \
		--bind ctrl-p:preview-half-page-up,ctrl-n:preview-half-page-down \
		--reverse --read0 --print0 \
		--exit-0 | xargs -r -0 nvim;
	zle redisplay;
}

zle -N search_and_open_file_with_nvim
bindkey '^[e' search_and_open_file_with_nvim

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf improvement
function fzf-lovely(){

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
			echo {} is a binary file ||
			(bat --style=numbers --color=always {} ||
			highlight -O ansi -l {} ||
			coderay {} ||
			rougify {} ||
			cat {}) 2> /dev/null | head -500'

	else
		fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
			echo {} is a binary file ||
			(bat --style=numbers --color=always {} ||
			highlight -O ansi -l {} ||
			coderay {} ||
			rougify {} ||
			cat {}) 2> /dev/null | head -500'
	fi
}

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

eval "$(starship init zsh)"


# Load Angular CLI autocompletion.
source <(ng completion script)

# pnpm
export PNPM_HOME="/home/mavix/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
# [ -s "/home/mavix/.bun/_bun" ] && source "/home/mavix/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "/home/mavix/.deno/env"

# fnm
FNM_PATH="/home/mavix/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/mavix/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi
