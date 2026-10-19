local Snacks = require("snacks")

Snacks.setup({
  input = {
    enabled = true,
    icon = '❯',
  },
  indent = {
    enabled = true,
    char = '▏',
  },
  explorer = {
    enabled = true,
    replace_netrw = true,
  },
})

vim.g.snacks_animate = false

-- docs: https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md
vim.keymap.set({'n', 't'}, '<C-g>', function()
  Snacks.terminal.toggle()
end, {desc = 'Toggle terminal window'})

vim.keymap.set('n', '<leader>e', function()
  Snacks.explorer()
end, {desc = 'Toggle file explorer'})
