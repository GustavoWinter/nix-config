{ pkgs, ...}: {

  ##########################################################################
  # 
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  # 
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    git
    coreutils-full
    findutils
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    taps = [
      "homebrew/services"
      "cfergeau/crc"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      "vfkit"
      "sui"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "ollama"
      "google-chrome"
      "1password"
      "wifiman"

      # IM & audio & remote desktop & meeting
      "telegram"
      "discord"
      "whatsapp"
      "slack"

      "raycast"   # (HotKey: alt/option + space) search, calculate, and run scripts
      "stats"     # Beautiful system monitor

      # Development
      "android-studio"
      "docker"
      "insomnia"
      "obsidian"

      # Other
      # "kindle"
    ];
  };
}
