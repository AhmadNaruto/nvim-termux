return {
  'numToStr/FTerm.nvim',
  config = function()
    local fterm = require 'FTerm'
    fterm.setup {
      cmd = os.getenv 'SHELL',
      ft = 'FTerm',
      hl = 'Normal',
      border = 'rounded',
      dimensions = {
        height = 0.98,
        width = 0.98,
        x = 0.5,
        y = 0.5,
      },
      blend = 0,
      clear_env = false,
      auto_close = true,
      on_exit = nil,
      on_stdout = nil,
      on_stderr = nil,
    }

    local lazygit = fterm:new {
      ft = 'ftlgit',
      cmd = 'lazygit',
    }
    -- vim.api.nvim_create_user_command("FTermOpen", fterm.open, { bang = true })
    vim.keymap.set('n', '<leader>ot', function()
      fterm.open()
    end, { desc = '0pen terminal' })

    vim.keymap.set('n', '<leader>ol', function()
      lazygit:toggle()
    end, { desc = 'Open Lazygit' })
  end,
}
