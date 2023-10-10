{ inputs, pkgs, lib, ... }: {
  home.activation.nvimCacheClear = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # remove impatient.nvim cache
    rm -rf $HOME/.cache/nvim/luacache_*
  '';

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  home.packages = with pkgs; [
    neovim
    lua51Packages.mpack

    nil
    rust-analyzer
    terraform-lsp
    taplo-cli
    shellcheck
    terraform
    elixir_ls
    deno

    statix
    nixpkgs-fmt
    gitlint
    #hadolint

    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.prettier
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
      (fidget-nvim.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "j-hui";
          repo = "fidget.nvim";
          rev = "90c22e47be057562ee9566bad313ad42d622c1d3";
          hash = "sha256-N3O/AvsD6Ckd62kDEN4z/K5A3SZNR15DnQeZhH6/Rr0=";
        };
      }))

      elixir-tools-nvim
  
      ## rust 
      rust-tools-nvim
      crates-nvim

      # DAP
      nvim-dap
      nvim-dap-ui

      # Treesitter
      nvim-treesitter
      nvim-navic
      comment-nvim

      # neotest
      neotest
      neotest-rust
      neotest-elixir

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
      dracula-nvim
      (neogit.overrideAttrs (oldAttrs: {
        src = pkgs.fetchFromGitHub {
          owner = "NeogitOrg";
          repo = "neogit";
          rev = "72824006f2dcf775cc498cc4a046ddd2c99d20a3";
          hash = "sha256-1DEzVPHL+l8y2PHWcAg/bPBA+E/5riMa6pon3vvyQag=";
        };
      }))
      nvim-tree-lua
      diffview-nvim

      vim-easy-align
      vim-surround
      vim-repeat
      vim-floaterm
      vim-fish

      # Dependencies
      popfix # nvim-lsputils, telescope-nvim
      plenary-nvim # crates-nvim, telescope-nvim, gitsigns-nvim, neogit
      nvim-web-devicons
    ] ++ (builtins.attrValues nvim-treesitter.grammarPlugins));
  };
}
