fish_vi_key_bindings

# set -g theme_color_scheme zenburn
set -g theme_color_scheme "Solarized light"
set -gx EDITOR kak

if test -d "$HOME/.local/bin"
    fish_add_path "$HOME/.local/bin"
end

function reverse_history_search
  history | fzf --no-sort --height 30 | read -l command
  test $command && commandline -rb $command
end

function fish_user_key_bindings
  bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
  bind -M default / reverse_history_search
  bind -M insert \cr reverse_history_search
  bind -M insert \cp history-search-backward
  bind -M insert \cn history-search-forward
  bind -M insert \cl accept-autosuggestion execute
end

# See: https://discourse.nixos.org/t/nix-env-list-generations-is-empty/33747
alias listgens "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"
alias ys "env BROWSER=none yarn start"
alias ns "env BROWSER=none npm start"
alias nd "npm run dev"
alias mkdir "mkdir -p"
alias config "cd ~/nixos-configuration"

function nrsy
    echo "Building system: $NIXOS_CONFIG_PATH#$hostname"
    sudo nixos-rebuild switch --flake "$NIXOS_CONFIG_PATH#$HOSTNAME" --show-trace
end

# Dir info
alias ll "ls -Flh --group-directories-first"

# System Info
alias df "df -h";                             # human-readable sizes
alias freem "free -m";                        # show sizes in MB

# Applications
alias torrent "transmission-cli -w ~/Downloads -u 0"
alias g "git"
alias master "g co master"
alias k "kak"
alias kitty "kitty -o allow_remote_control=yes"
alias nvim "echo \"Did you mean 'kak'?\""
alias k "gkak"

# Remove node_modules folder
alias rmnm "find ./ -iname node_modules -type d | xargs rm -r"

# Shutdown / Reboot
alias sn "shutdown now"
alias rb "reboot"

# Nixos Yoga Laptop
alias dp11left10 "xrandr --output DisplayPort-1-1 --primary --auto --left-of eDP-1-0 --output eDP-1-0 --brightness 1.0 --mode 1680x1050"
alias offdp11left10 "xrandr --output DisplayPort-1-1 --off --output eDP-1-0 --brightness 1.0 --primary"
alias dp11left11 "xrandr --output DisplayPort-1-1 --primary --auto --left-of eDP-1-1 --output eDP-1-1 --brightness 1.0 --mode 1680x1050"
alias offdp11left11 "xrandr --output DisplayPort-1-1 --off --output eDP-1-1 --brightness 1.0 --primary"
alias dp2left1 "xrandr --output DP-2 --primary --auto --left-of eDP-1 --output eDP-1 --brightness 1.0 --mode 1680x1050"
alias offdp2left1 "xrandr --output DP-2 --off --output eDP-1 --brightness 1.0 --primary"
alias dp16left10 "xrandr --output DisplayPort-1-6 --primary --auto --left-of eDP-1-0 --output eDP-1-0 --brightness 1.0 --mode 1680x1050"
alias offdp16left10 "xrandr --output DisplayPort-1-6 --off --output eDP-1-0 --brightness 1.0 --primary"
alias dp16left11 "xrandr --output DisplayPort-1-6 --primary --auto --left-of eDP-1-1 --output eDP-1-1 --brightness 1.0 --mode 1680x1050"
alias offdp16left11 "xrandr --output DisplayPort-1-6 --off --output eDP-1-1 --brightness 1.0 --primary"
alias offdp16left11 "xrandr --output DisplayPort-1-6 --off --output eDP-1-1 --brightness 1.0 --primary"

function left1920
    set right_monitor (xrandr --current | awk '/eDP-1* connected/ {print $1}')
    set left_monitor (xrandr --current | awk '/^(DP|DisplayPort)-[0-9-]+ connected/ {print $1}')

    # If no left monitor was found
    if test -z "$left_monitor"
        echo "No left monitor found" >&2
        return 1
    end

    # If no right monitor was found
    if test -z "$right_monitor"
        echo "No right monitor found" >&2
        return 1
    end

    echo "making $left_monitor the primary monitor on the left"
    xrandr --output $left_monitor --primary --auto --left-of $right_monitor
    echo "making $right_monitor the secondary monitor on the right"
    xrandr --output $right_monitor --brightness 1.0 --mode 1680x1050

    set monitors (xrandr --current | awk '/\sconnected\s/ {print $1}')

    for monitor in $monitors
        if test "$monitor" != "$left_monitor"; and test "$monitor" != "$right_monitor"
            xrandr --output $monitor --off
        end
    end
end

function eDP
    set eDP (xrandr --current | awk '/eDP-1* connected/ {print $1}')
    set monitors (xrandr --current | awk '/\sconnected\s/ {print $1}')

    # If no eDP monitor was found
    if test -z "$eDP"
        echo "No eDP monitor found" >&2
        return 1
    end

    echo "making $eDP the only & primary monitor"
    xrandr --output $eDP --brightness 1.0 --mode 1680x1050 --primary

    for monitor in $monitors
        if test "$monitor" != "$eDP"
            xrandr --output $monitor --off
        end
    end
end

# dir navigation
alias ".." "cd .."
alias "..." "cd ../.."
alias "...." "cd ../../.."
alias dev "cd /mnt/ssd/development"
alias ip "dev && cd interactive-pioneers"
alias compr "dev && cd compr"

function kill9 --wraps kill --description ''
  kill -9  $argv[2..(count $argv)] (ps aux | grep $argv[1] | awk '{print $2}')
end

function gkak
    set -l session_name (git remote get-url origin 2> /dev/null | cut -d ":" -f2 | sed "s/\(.*\)[.]git\$/\1/" | sed "s/\//-/g")

    if test -n "$session_name"
        kak -c "$session_name" $argv || kak -s "$session_name" $argv
    else
        kak $argv
    end
end

export PATH="/home/gerkules/.lando/bin:$PATH"; #landopath
