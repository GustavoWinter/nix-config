{ lib,config,...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting = {
      enable = true;
    };

    oh-my-zsh = {
      enable = true;

      custom = "$HOME/zsh-custom";
      theme = "dracula-pro";

      plugins =
        [ "git"
          "golang"
          "kubectl"
          "helm"
          "gcloud"
          "docker"
          "kubectl"
          "direnv"
        ];
    };
  };

  home.sessionVariables = {
    USE_GKE_GCLOUD_AUTH_PLUGIN="True";
    ANDROID_HOME="${config.home.homeDirectory}/Library/Android/sdk";
  };

  home.sessionPath = [
    "/Users/87labs/.gem/ruby/3.3.0/bin"
    "/opt/homebrew/bin"
  ];

  home.shellAliases = {
    k = "kubectl";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };

}
