local gitsigns = require("gitsigns")
gitsigns.setup({
  on_attach = function()
    vim.keymap.set("n", "<Leader>gb", gitsigns.blame, { noremap = true })
  end
})
