# See: https://discourse.nixos.org/t/nix-env-list-generations-is-empty/33747
alias listgens "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"
alias ys "env BROWSER=none yarn start"
alias ns "env BROWSER=none npm start"
alias nd "npm run dev"
alias mkdir "mkdir -p"

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

# Remove node_modules folder
alias rmnm "find ./ -iname node_modules -type d | xargs rm -r"

# Shutdown / Reboot
alias sn "shutdown now"
alias rb "reboot"

# Nixos Yoga Laptop
alias dp11left10 "xrandr --output DisplayPort-1-1 --primary --auto --left-of eDP-1-0 --output eDP-1-0 --mode 1680x1050"
alias offdp11left10 "xrandr --output DisplayPort-1-1 --off --output eDP-1-0 --primary"
alias dp11left11 "xrandr --output DisplayPort-1-1 --primary --auto --left-of eDP-1-1 --output eDP-1-1 --mode 1680x1050"
alias offdp11left11 "xrandr --output DisplayPort-1-1 --off --output eDP-1-1 --primary"
alias dp2left1 "xrandr --output DP-2 --primary --auto --left-of eDP-1 --output eDP-1 --mode 1680x1050"
alias offdp2left1 "xrandr --output DP-2 --off --output eDP-1 --primary"
alias dp16left10 "xrandr --output DisplayPort-1-6 --primary --auto --left-of eDP-1-0 --output eDP-1-0 --mode 1680x1050"
alias offdp16left10 "xrandr --output DisplayPort-1-6 --off --output eDP-1-0 --primary"
alias dp16left11 "xrandr --output DisplayPort-1-6 --primary --auto --left-of eDP-1-1 --output eDP-1-1 --mode 1680x1050"
alias offdp16left11 "xrandr --output DisplayPort-1-6 --off --output eDP-1-1 --primary"

# dir navigation
alias ".." "cd .."
alias "..." "cd ../.."
alias "...." "cd ../../.."
alias dev "cd ~/development"
alias ip "dev && cd interactive-pioneers"
alias compr "dev && cd compr"
