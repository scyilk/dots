require("mini.icons").setup()
require("mini.tabline").setup()
require("mini.notify").setup()

require("mini.diff").setup({
  view = {
    style = 'sign',
    signs = {
      add = '▎',
      change = '▎',
      delete = '➤',
    },
  },
})

local mini_clue = require('mini.clue')

mini_clue.setup({
  triggers = {
    {mode = 'n', keys = 'g'},
    {mode = 'n', keys = '<leader>'},
  },
  clues = {
    mini_clue.gen_clues.g(),
  },
})

local p = require('everblush.palette')

local highlights = {
    MiniStatuslineModeNormal  = { bg = p.color2,  fg = p.background },
    MiniStatuslineModeInsert  = { bg = p.color10, fg = p.background },
    MiniStatuslineModeCommand = { bg = p.color1,  fg = p.background },
    MiniStatuslineModeVisual  = { bg = p.color6,  fg = p.background },
    MiniStatuslineModeReplace = { bg = p.color1,  fg = p.background },

    -- mini.statusline has one inactive highlight group, rather than lualine's
    -- separate inactive a/b/c sections.
    MiniStatuslineInactive    = { bg = p.background, fg = p.foreground },
}

for group, spec in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, spec)
end

require("mini.statusline").setup()
