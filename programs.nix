{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    difftastic
    mergiraf
    jj-vine
  ];

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Filipe Silva";
        email = "fil.lourenco.silva@gmail.com";
      };
      ui = {
        default-command = "log";
        log-synthetic-elided-nodes = true;
        graph.style = "square";
      };
      git.colocate = true;

      merge-tools = {
        difft = {
          program = "difft";
          diff-args = [ "--color=always" "$left" "$right" ];
        };
        mergiraf = {
          program = "mergiraf";
          merge-args = [ "merge" "$base" "$left" "$right" "-o" "$output" "--fast" ];
          merge-conflict-exit-codes = [ 1 ];
          conflict-marker-style = "git";
        };
      };

      aliases = {
        d = [ "diff" ];
        s = [ "show" ];
        p = [ "git" "push" ];
        f = [ "git" "fetch" ];
        ll = [ "log" "-T" "builtin_log_detailed" ];
        la = [ "log" "-r" "all()" ];
        rid = [ "log" "-T" "commit_id.short()" "--no-graph" "-r" ];
        pr = [ "util" "exec" "--" "jj-vine" ];
      };

      revset-aliases.current_work = "trunk()..@ | @..trunk() | trunk() | @:: | fork_point(trunk() | @)";
    };
  };

  programs.ghostty = {
    enable = true;
    package = null; # instalado pelo sistema (/usr/bin/ghostty)
    systemd.enable = false;
    settings = {
      # appearance
      config-file = "?auto/theme.ghostty";
      font-family = "Dank Mono";
      font-size = 16;
      background-opacity = 0.80;
      background-blur = true;

      # tmux
      initial-command = "/bin/bash -l -c \"tmux attach -t 'λ' || tmux new -s 'λ'\"";

      # clipboard
      clipboard-read = "allow";
      clipboard-paste-protection = false;

      # window
      window-decoration = false;
      mouse-hide-while-typing = true;
      window-padding-x = 1;
      window-padding-y = 1;
      window-inherit-working-directory = true;
      confirm-close-surface = false;
      unfocused-split-opacity = 1;

      keybind = [
        "shift+enter=text:\\n"
        "performable:ctrl+c=copy_to_clipboard"
      ];
      app-notifications = "no-clipboard-copy";
    };
  };

  # Temas copiados como arquivos (formato nativo do ghostty)
  # recursive = true: links por arquivo, para `themes/` continuar gravável
  # (o matugen/DMS grava themes/dankcolors).
  xdg.configFile."ghostty/themes" = {
    source = ./ghostty-themes;
    recursive = true;
  };

  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    baseIndex = 1;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = gruvbox;
        extraConfig = ''
          set -g @tmux-gruvbox 'dark'
          set -g @tmux-gruvbox-statusbar-alpha 'true'
        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux-extra.conf;
  };

  # Config do nvim versionada aqui, mas linkada fora do store: o lazy.nvim
  # reescreve o lazy-lock.json e as edições valem sem novo switch.
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/nvim";

  # niri: só o config.kdl. A pasta dms/ é gerada pelo DankMaterialShell e
  # continua fora do home-manager (o `include "dms/..."` resolve em ~/.config/niri).
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/niri/config.kdl";

  # Esconde o indicador do modo vi do fish (função vazia, como no config.fish antigo)
  programs.fish.functions.fish_mode_prompt = "";
}
