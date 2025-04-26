return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.opt.timeoutlen
    delay = 0,
    preset = 'helix',
    colors = true,

    icons = {
      rules = false,
      breadcrumb = ' ', -- symbol used in the command line area that shows your active key combo
      separator = '󱦰  ', -- symbol used between a key and it's label
      group = '󰹍 ', -- symbol prepended to a group
    },

    plugins = {
      spelling = {
        enabled = false,
      },
    },

    win = {
      height = {
        max = math.huge,
      },
    },

    -- Document existing key chains
    spec = {
      { '<leader>e', group = 'Explorer' },
      { '<leader>w', group = 'Save File' },
      { '<leader>q', group = 'Quit / Exit' },
      { '<leader>t', group = 'Neo Tree' },
      { '<Tab>', group = 'Next Tab' },
      { '<S-Tab>', group = 'Previous Tab' },
      { '<leader>x', group = 'Close Tab' },
      { '<leader>n', group = 'New Tab' },
      { '<leader>f', group = 'Format Code' },
      { '<leader>rl', group = 'Run Lua Code' },
      { '<leader>rp', group = 'Run Python Code' },
    },
  },

  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show { global = false }
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
