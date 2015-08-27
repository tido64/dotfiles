local editor = vim.api.nvim_create_augroup("editor", { clear = true })

-- Highlight max column
vim.api.nvim_create_autocmd("FileType", {
  group = editor,
  pattern = {
    "c",
    "cpp",
    "cs",
    "glsl",
    "java",
    "javascript",
    "javascriptreact",
    "kotlin",
    "lua",
    "markdown",
    "nim",
    "objc",
    "objcpp",
    "python",
    "swift",
    "typescript",
    "typescriptreact",
  },
  callback = function()
    vim.opt_local.colorcolumn = "80"
  end,
})

-- Highlight max column for commit messages
vim.api.nvim_create_autocmd("FileType", {
  group = editor,
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.colorcolumn = "72"
  end,
})

-- Indent with 2 spaces
vim.api.nvim_create_autocmd("FileType", {
  group = editor,
  pattern = {
    "cmake",
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "nim",
    "ruby",
    "sh",
    "typescript",
    "typescriptreact",
    "vim",
    "xml",
    "yaml",
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Trim trailing whitespace on write
vim.api.nvim_create_autocmd("FileType", {
  group = editor,
  pattern = {
    "c",
    "cmake",
    "cpp",
    "cs",
    "css",
    "glsl",
    "html",
    "java",
    "javascript",
    "javascriptreact",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "nim",
    "objc",
    "objcpp",
    "python",
    "ruby",
    "sh",
    "swift",
    "text",
    "typescript",
    "typescriptreact",
    "vim",
    "xml",
    "yaml",
  },
  callback = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      command = [[%s/\s\+$//e]],
    })
  end,
})
