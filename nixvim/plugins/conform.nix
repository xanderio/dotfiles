{ pkgs, ... }:
{
  # Dependencies
  #
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extrapackages
  extraPackages = with pkgs; [
    # Used to format Lua code
    stylua
    nixfmt-rfc-style
  ];

  # Autoformat
  # https://nix-community.github.io/nixvim/plugins/conform-nvim.html
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatter_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        # Conform can also run multiple formatters sequentially
        # python = [ "isort "black" ];
        #
        # You can use a sublist to tell conform to run *until* a formatter
        # is found
        # javascript = [ [ "prettierd" "prettier" ] ];
      };
      notify_on_error = false;
    };
  };

  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    {
      mode = "";
      key = "<leader>f";
      action.__raw = # lua
        ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
      options = {
        desc = "[F]ormat buffer";
      };
    }
  ];
}
