{
  plugins.hydra = {
    enable = true;
    hydras = [
      {
        body = "<leader>g";
        config = {
          color = "pink";
          hint = {
            position = "bottom";
          };
          invoke_on_body = true;
          on_enter = #lua 
            ''
            function()
              vim.bo.modifiable = false
              require("gitsigns").toggle_signs(true)
              require("gitsigns").toggle_linehl(true)
            end
          '';
          on_exit = #lua 
            ''
              function()
            	require("gitsigns").toggle_signs(false)
            	require("gitsigns").toggle_linehl(false)
            	require("gitsigns").toggle_deleted(false)
            	vim.cmd("echo") -- clear the echo area
            end
          '';
        };
        heads = [
          [
            "J"
            {
              __raw = ''
                function()
                  if vim.wo.diff then
                    return "]c"
                  end
                  vim.schedule(function()
                    require("gitsigns").next_hunk()
                  end)
                  return "<Ignore>"
                end
              '';
            }
            {
              expr = true;
            }
          ]
          [
            "K"
            {
              __raw = ''
                function()
                  if vim.wo.diff then
                    return "[c"
                  end
                  vim.schedule(function()
                    require("gitsigns").prev_hunk()
                  end)
                  return "<Ignore>"
                end
              '';
            }
            {
              expr = true;
            }
          ]
          [
            "s"
            ":Gitsigns stage_hunk<CR>"
            {
              silent = true;
            }
          ]
          [
            "u"
            {
              __raw = "require('gitsigns').undo_stage_hunk";
            }
          ]
          [
            "S"
            {
              __raw = "require('gitsigns').stage_buffer";
            }
          ]
          [
            "p"
            {
              __raw = "require('gitsigns').preview_hunk";
            }
          ]
          [
            "d"
            {
              __raw = "require('gitsigns').toggle_deleted";
            }
            {
              nowait = true;
            }
          ]
          [
            "b"
            {
              __raw = "require('gitsigns').blame_line";
            }
          ]
          [
            "B"
            {
              __raw = ''
                function()
                  require("gitsigns").blame_line({ full = true })
                end,
              '';
            }
          ]
          [
            "/"
            {
              __raw = "require('gitsigns').show";
            }
            {
              exit = true;
            }
          ]
          [
            "<Enter>"
            "<cmd>Neogit<CR>"
            {
              exit = true;
            }
          ]
          [
            "q"
            null
            {
              exit = true;
              nowait = true;
            }
          ]
        ];
        hint = {
          __raw = ''
            [[
               _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
               _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full
               ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
               ^
               ^ ^              _<Enter>_: Neogit              _q_: exit
            ]]
          '';
        };
        mode = [
          "n"
          "x"
        ];
        name = "git";
      }
    ];

  };
}
