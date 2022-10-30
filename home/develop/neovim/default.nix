{ config
, pkgs
, lib
, ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  home.packages = with pkgs; [
    neovim-nightly
    lua51Packages.mpack

    nil
    rust-analyzer-nightly
    terraform-lsp
    taplo-cli
    shellcheck
    terraform

    statix
    nixpkgs-fmt
    gitlint
    hadolint

    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.prettier

    nodePackages.pyright
    black
    python3Packages.isort
    python3Packages.flake8
    python3Packages.pylama
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile =
    {
      "nvim" = {
        recursive = true;
        source = ./nvim;
      };
      "nvim/parser/" = {
        recursive = true;
        source = pkgs.nvim-ts-grammars;
      };
    };

  xdg.dataFile."nvim/site/pack/nix/start" = {
    recursive = true;
    source = pkgs.linkFarmFromDrvs "neovim-plugins" (with pkgs.vimPlugins; [
      impatient-nvim

      # LSP
      nvim-lspconfig
      null-ls-nvim
      lsp_extensions-nvim
      nvim-lsputils
      nvim-lightbulb
      FixCursorHold-nvim
      trouble-nvim
      nvim-code-action-menu
      lspkind-nvim
      lsp_signature-nvim
      lsp-status-nvim
      fidget-nvim

      ## rust 
      rust-tools-nvim
      crates-nvim

      # DAP
      nvim-dap
      nvim-dap-ui

      # Treesitter
      nvim-treesitter
      nvim-navic
      spellsitter-nvim
      comment-nvim

      # Autocompletion
      luasnip
      cmp_luasnip

      cmp-nvim-lua
      cmp-nvim-lsp
      cmp-vsnip
      cmp-path
      cmp-emoji
      cmp-calc
      cmp-buffer
      cmp-nvim-lsp-signature-help
      nvim-cmp

      # Utils
      hydra-nvim
      indent-blankline-nvim
      nvim-notify
      telescope-nvim
      lualine-nvim
      gitsigns-nvim
      editorconfig-nvim
      dracula-nvim
      neogit

      vim-easy-align
      vim-surround
      vim-repeat
      vim-floaterm
      vim-fish

      # Dependencies
      popfix # nvim-lsputils, telescope-nvim
      plenary-nvim # crates-nvim, telescope-nvim, gitsigns-nvim, neogit
      nvim-web-devicons
    ]);
  };
}
