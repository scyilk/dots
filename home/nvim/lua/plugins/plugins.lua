vim.pack.add({
  { src = "https://github.com/Everblush/nvim", name = "everblush" },
  "https://github.com/NMAC427/guess-indent.nvim",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/folke/snacks.nvim",
})

require("everblush").setup()
vim.cmd[[colorscheme everblush]]

require("guess-indent").setup()

require("plugins.mini")
require("plugins.snacks")
