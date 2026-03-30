{ config, pkgs, lib, ... }: let
  # baseDir = toString ../../.; # cwd = "/home/gerkules/nixos-configuration";
  baseDir = "/home/gerkules/nixos-configuration";
in {
  home = {
    username = "gerkules";
    homeDirectory = "/home/gerkules";
    stateVersion = "23.11";
  };

	home.file = with config.lib.file; {
    # files
    ".config/fish/config.fish".source = mkOutOfStoreSymlink "${baseDir}/config/fish/config.fish";
    ".config/i3/config".source = mkOutOfStoreSymlink "${baseDir}/config/i3/config";
    ".config/kak-lsp/kak-lsp.toml".source = mkOutOfStoreSymlink "${baseDir}/config/kakoune/lsp/kak-lsp.toml";
    ".profile".source = mkOutOfStoreSymlink "${baseDir}/config/.profile";
    ".editorconfig".source = mkOutOfStoreSymlink "${baseDir}/config/.editorconfig";
    ".npmrc".source = mkOutOfStoreSymlink "${baseDir}/config/npm/.npmrc";
    ".mrconfig".source = mkOutOfStoreSymlink "${baseDir}/config/myrepos/.mrconfig";

    # claude
    ".claude/CLAUDE.md".source = mkOutOfStoreSymlink "${baseDir}/config/ai-agents/AGENTS.md"; # Don't use workflows here, too expensive
    ".claude.json".source = mkOutOfStoreSymlink "${baseDir}/config/codex/servers.json";

    # gemini
    ".gemini/GEMINI.md".source = mkOutOfStoreSymlink "${baseDir}/config/ai-agents/AGENTS.md";
    ".gemini/settings.json".source = mkOutOfStoreSymlink "${baseDir}/config/gemini/settings.json";

    # codex, private account
    ".codex/AGENTS.md".source = mkOutOfStoreSymlink "${baseDir}/config/ai-agents/AGENTS.md";
    ".codex/config.toml".source = mkOutOfStoreSymlink "${baseDir}/config/codex/config.toml";
    ".codex/mcp/servers.json".source = mkOutOfStoreSymlink "${baseDir}/config/codex/servers.json";

    # codex, work-client account
    ".codex-work/AGENTS.md".source = mkOutOfStoreSymlink "${baseDir}/config/ai-agents/AGENTS.md"; # Don't use workflows here, too expensive
    ".codex-work/config.toml".source = mkOutOfStoreSymlink "${baseDir}/config/codex/config-work.toml";
    ".codex-work/mcp/servers.json".source = mkOutOfStoreSymlink "${baseDir}/config/codex/servers.json";

    # codex hooks
    ".local/bin/codex-post-turn-hook".source = mkOutOfStoreSymlink "${baseDir}/config/ai-agents/codex-post-turn-hook.js";

    # directories
    ".config/kitty".source = mkOutOfStoreSymlink "${baseDir}/config/kitty";
    ".config/kak".source = mkOutOfStoreSymlink "${baseDir}/config/kakoune";
    ".config/lf".source = mkOutOfStoreSymlink "${baseDir}/config/lf";
  };

  imports = [
    # ./home-gerkules/symlinks.nix
    ./home-gerkules/brave.nix
    ./home-gerkules/packages.nix
    ./home-gerkules/git.nix
    ./home-gerkules/myrepos.nix
    ./home-gerkules/mouse.nix
    ./home-gerkules/shell.nix
    ./home-gerkules/test-service.nix
    ./home-gerkules/dunst.nix
    ./home-gerkules/polybar.nix
  ];
}
