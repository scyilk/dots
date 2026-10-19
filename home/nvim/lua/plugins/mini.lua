require("mini.icons").setup()
require("mini.tabline").setup()
require("mini.statusline").setup()
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
