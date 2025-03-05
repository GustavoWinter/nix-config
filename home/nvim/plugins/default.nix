{
  nixpkgs.config.allowUnfree = true;

  imports = [
    #   ./barbar.nix
    #   ./catppuccin.nix
    ./colorscheme.nix
    ./cmp.nix
    ./comment.nix
    #   ./efmls.nix
    #   ./floaterm.nix
    ./harpoon.nix
    ./lsp.nix
    #   ./lualine.nix
    #   ./markdown-preview.nix
    #   ./neorg.nix
    #   ./neo-tree.nix
    ./none-ls.nix
    #   ./startify.nix
    #   ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    #   ./vimtex.nix
  ];

  programs.nixvim = {
    editorconfig = {
      enable = true;
    };

    plugins = {
      web-devicons.enable = true; 

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };
      nvim-autopairs.enable = true;
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      nvim-tree.enable = true;

      copilot-vim.enable = true;
      luasnip.enable = true;
    };
  };
}
