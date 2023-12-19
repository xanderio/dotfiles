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
    elixir_ls
    deno

    statix
    nixpkgs-fmt
    gitlint
    #hadolint
    emmet-ls

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
      none-ls-nvim
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

      # neorg
      (pkgs.vimUtils.buildVimPlugin {
        pname = "neorg";
        version = inputs.neorg.rev;
        src = inputs.neorg;
      })
      (pkgs.vimUtils.buildVimPlugin {
        pname = "neorg-telescope";
        version = inputs.neorg-telescope.rev;
        src = inputs.neorg-telescope;
      })
      headlines-nvim
      vim-table-mode

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
      neogit
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
    ]
    ++ (builtins.attrValues (nvim-treesitter.grammarPlugins // lib.mapAttrs (_: pkgs.neovimUtils.grammarToPlugin) {
      norg = pkgs.tree-sitter.buildGrammar { 
        language = "norg";
        version = inputs.norg.rev;
        src = inputs.norg;
      };
      norg-meta = pkgs.tree-sitter.buildGrammar { 
        language = "norg-meta";
        version = inputs.norg-meta.rev;
        src = inputs.norg-meta;
      };
    })));
  };
}
