{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hitmonlee";
  home.homeDirectory = "/home/hitmonlee";

  # find alternative for it
  # home.backupFileExtension = "backup";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    bat
    zoxide
    starship
    fzf
    alacritty
    zathura
    vivaldi
    fish
    kitty
    sioyek
    xremap # Have to set it up, first learn more about home-manager
    git
    lazygit
    openssh
    gh
    eza
    kdePackages.kdenlive
    pandoc
    qutebrowser
    libreoffice-qt
    vesktop
    fastfetch
    neofetch
    neovim
    pokemon-colorscripts-mac
    nodejs_24
    unzip
    zip
    python314
    alejandra
    nixd
		cargo
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hitmonlee/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    # MANPAGER = "nvim +Man!";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nix btw";
      ls = "eza -lah --icons";
    };
    shellAbbrs = {
      nrs = "sudo nixos-rebuild switch";
      n = "nvim";
      gs = "git status";
      ga = "git add -A";
      gc = "git commit";
      gp = "git push";
      gco = "git checkout";
      lg = "lazygit";
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "pure";
        src = pure.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
    ];
    shellInit = ''
      function fish_default_key_bindings
      	fish_vi_key_bindings
      end
      function ls
      	eza -lah --icons $argv
      end
    '';
  };
  programs.kitty = {
    enable = true;
    settings = {
      scrollback_lines = 10000;
      background_opacity = 0.7;
      font_size = 16;
      disable_ligatures = "never";
      cursor_shape = "beam";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      background_blur = 10;
      font_family = "Fira Code";
      cursor_trail = 1;
    };
    shellIntegration.enableFishIntegration = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.8;
      font.size = 16;
    };
  };

  programs.vivaldi.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;

  programs.zoxide.enableFishIntegration = true;
  programs.fzf.enableFishIntegration = true;

  programs.sioyek = {
    enable = true;
    config = {
      "should_launch_new_window" = "1";
      "default_dark_mode" = "1";
      "show_doc_path" = "1";
    };
  };

  programs.git = {
    enable = true;
    userName = "Kartikey Shahi";
    userEmail = "kartikeyshahi@hotmail.com";
    extraConfig = {
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };

  programs.lazygit.enable = true;
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 30;
    addKeysToAgent = "confirm";

    matchBlocks = {
      "*" = {
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  programs.gh.enable = true;
  programs.qutebrowser.enable = true;
  programs.vesktop.enable = true;
  programs.fastfetch.enable = true;

  # configure services here
  services = {
    ssh-agent.enable = true;
  };
}
