-- https://neovim.io/doc/user/options.html
vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamed"
vim.opt.copyindent = true
vim.opt.cursorline = true
vim.opt.directory = vim.opt.directory - { "." }
--vim.opt.encoding = 'utf-8'
vim.opt.expandtab = true
vim.opt.foldenable = false
vim.opt.foldlevel = 1
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 2
--vim.opt.formatoptions = 1
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { nbsp = "␣", tab = "⇥ ", trail = "·" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.preserveindent = true
vim.opt.shadafile = "NONE"
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.title = true
vim.opt.wrap = false

-- Mappings

local noremap = { noremap = true }
local silent_noremap = { silent = true, noremap = true }

-- <Space> to turn off highlighting and clear any message already displayed
vim.keymap.set("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", silent_noremap)

-- Ctrl-t to open a new tab
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", silent_noremap)

-- Ctrl-w f to open file in a new buffer vertically
vim.keymap.set("n", "<C-w>f", ":vertical belowright wincmd f<CR>", noremap)

-- Alt-j/k to move lines up/down
if vim.fn.has("mac") == 1 then
  vim.keymap.set("n", "∆", ":m .+1<CR>==", noremap)
  vim.keymap.set("n", "˚", ":m .-2<CR>==", noremap)
  vim.keymap.set("i", "∆", "<Esc>:m .+1<CR>==gi", noremap)
  vim.keymap.set("i", "˚", "<Esc>:m .-2<CR>==gi", noremap)
  vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", noremap)
  vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", noremap)
else
  vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", noremap)
  vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", noremap)
  vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", noremap)
  vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", noremap)
  vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", noremap)
  vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", noremap)
end

-- Mouse wheel
--vim.keymap.set('n', '<ScrollWheelDown>', '<C-E>', noremap)
--vim.keymap.set('n', '<ScrollWheelUp>', '<C-Y>', noremap)
