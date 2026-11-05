{
  description = "Home-manager pessoal com o módulo finix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    finix.url = "github:filipesilva-l/finix";
  };

  # Usuário, HOME e arquitetura vêm do ambiente, por isso o comando de
  # aplicação usa --impure (veja o README do finix).
  outputs = { nixpkgs, home-manager, finix, ... }:
    let
      user = builtins.getEnv "USER";
      home = builtins.getEnv "HOME";
    in {
    homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = builtins.currentSystem;
        config.allowUnfree = true;
      };
      modules = [
        finix.homeManagerModules.default
        ./programs.nix
        ({ pkgs, ... }: {
          home.username = user;
          home.homeDirectory = home;
          home.stateVersion = "25.05";

          targets.genericLinux.enable = true;
          programs.home-manager.enable = true;

          finix.editor = "nvim";
          finix.fish.viKeyBindings = true;

          home.packages = with pkgs; [
            blanket
            fastfetch
            go_1_27
            gopls
            scc
          ];
        })
      ];
    };
  };
}
