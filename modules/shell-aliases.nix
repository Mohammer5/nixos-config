{
  ##
  #
  # Utilities & command improvement
  #
  ##

  # nixos config related
  c = "cd /nixos-config";
  nrsy = "sudo nixos-rebuild switch --flake /nixos-config#$hostname --show-trace";

  # See: https://discourse.nixos.org/t/nix-env-list-generations-is-empty/33747
  listgens = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

  ys = "env BROWSER=none yarn start";
  ns = "env BROWSER=none npm start";

  mkdir = "mkdir -p";
  ssh = "kitty +kitten ssh";

  # Dir info
  ll = "ls -Flh --group-directories-first";

  # System Info
  df = "df -h";                             # human-readable sizes;
  freem = "free -m";                        # show sizes in MB;

  # Applications
  torrent = "transmission-cli -w ~/Downloads -u 0";
  g = "git";
  master = "g co master";
  chromium = "chromium --disable-features=SameSiteByDefaultCookies,CookiesWithoutSameSiteMustBeSecure,SameSiteDefaultChecksMethodRigorously";
  k = "kak";
  kitty = "kitty -o allow_remote_control=yes";
  nvim = "echo \"Did you mean 'kak'?\"";

  # Remove node_modules folder
  rmnm = "find ./ -iname node_modules -type d | xargs rm -r";

  # Shutdown / Reboot
  sn = "shutdown now";
  rb = "reboot";

  # dev shells
  js = "nix develop /nixos-config#js -c $SHELL";
  jsn16 = "nix develop /nixos-config#jsn16 -c $SHELL";
  jsn14 = "nix develop /nixos-config#jsn14 -c $SHELL";
  cyp = "nix develop /nixos-config#cypress -c $SHELL";
  clj = "nix develop /nixos-config#clojure -c $SHELL";
  ocaml = "nix develop /nixos-config#ocaml -c $SHELL";
  rn = "nix develop /nixos-config#reactNative -c $SHELL";

  ##
  #
  # Dir navigation
  # ==============
  # ==============
  # ==============
  #
  ##

  # dir navigation
  ".." = "cd ..";
  "..." = "cd ../..";
  "...." = "cd ../../..";
  dev = "cd ~/development";
  dhis2 = "dev && cd dhis2";
  compr = "dev && cd compr";

  #
  # DHIS 2
  # ------
  #
  d2docker = "sudo ln -s /run/current-system/sw/bin/bash /bin/bash; npx --package @dhis2/cli d2 cluster up master --channel dev --db-version dev --seed --update";
}
