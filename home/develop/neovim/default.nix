{ pkgs, lib, ... }:
{
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
    neovim.unwrapped.lua.pkgs.mpack

    nixd
    rust-analyzer
    terraform-lsp
    taplo-cli
    shellcheck
    elixir_ls

    statix
    nixfmt-rfc-style
    gitlint
    #hadolint
    emmet-ls

    pyright
    ruff

    bash-language-server
    svelte-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    # nodePackages.vue-language-server
    nodePackages.yaml-language-server
    nodePackages.prettier
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  xdg.configFile = {
    "nvim" = {
      recursive = true;
      source = ./nvim;
    };
  };

  xdg.dataFile."nvim/site/pack/nix/start" = {
    recursive = true;
    source = pkgs.linkFarmFromDrvs "neovim-plugins" (
      (with pkgs.vimPlugins; [
        impatient-nvim

        # LSP
        nvim-lspconfig
        none-ls-nvim
        lsp_extensions-nvim
        nvim-lsputils
        nvim-lightbulb
        FixCursorHold-nvim
        trouble-nvim
        actions-preview-nvim
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

        vim-table-mode

        # neotest
        nvim-nio
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
      ])
      ++ (builtins.attrValues (
        pkgs.vimPlugins.nvim-treesitter.grammarPlugins
        // lib.mapAttrs (_: pkgs.neovimUtils.grammarToPlugin) {
          tree-sitter-nu = pkgs.tree-sitter.builtGrammars.tree-sitter-nu.overrideAttrs {
            src = pkgs.fetchFromGitHub {
              owner = "nushell";
              repo = "tree-sitter-nu";
              rev = "ac878320cd624b3402a50fa875ad5f90bf6dd6d7";
              hash = "sha256-KKX1eoRCGFzp9mt7ugzK1M/CAy6jGS8jcLU/HpEQXWc=";
            };
            postInstall = ''
              mv -v $out/queries/nu/* $out/queries/
              rm -rf $out/queries/nu
            '';
          };
        }
      ))
    );
  };
}
