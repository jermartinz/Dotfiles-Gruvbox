set -U fish_greeting
set fish_greeting
if status is-interactive
    # Commands to run in interactive sessions can go here

    # Starship
    starship init fish | source

    if command -v tmux >/dev/null; and test -z $TMUX
        tmux attach; or tmux new-session
    end

    alias ls='ls --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -lha --color=auto'
    alias gs='git status'
    alias update='sudo pacman -Syu'

    set -x LUA_DIR /usr/lib/lua/5.1
    set -x LUA_BINDIR /usr/bin
    set -Ux PATH /usr/lib/tree-sitter/bin $PATH

    # Activate pytyon virtual environment for nvim
    function start_nvim
        if test -f ~/.venvs/nvim/bin/activate.fish
            source ~/.venvs/nvim/bin/activate.fish
        end
        command nvim $argv
    end
    # Zoxide
    zoxide init fish | source

    alias cd='z'
    alias nvim=start_nvim
    alias restartwaybar="killall waybar; nohup waybar >/dev/null 2>&1 &"
    alias paru-secure='paru --review --editmenu --pgpfetch'
    alias sendphone='scp -P 8022 "$1" u0_a512@192.168.1.2:~/storage/downloads/'
    alias getphone='scp -i ~/.ssh/id_ed25519_android -P 8022 u0_a512@192.168.1.2:"$1" ./'
    atuin init fish | source

end

fish_add_path /home/jeremy/.spicetify

# Created by `pipx` on 2025-07-31 04:30:41
set PATH $PATH /home/jeremy/.local/bin

# pnpm
set -gx PNPM_HOME "/home/jeremy/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Golang
set -x PATH $PATH /usr/local/go/bin

# thefuck
thefuck --alias | source
