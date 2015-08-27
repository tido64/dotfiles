local status, cmp = pcall(require, "cmp")
if not status then
  -- `cmp` seems to be unavailable when launched by Git
  return
end

cmp.setup({
  sources = {
    { name = "nvim_lsp" }
  }
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

local lsp_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return lsp_util_open_floating_preview(contents, syntax, opts, ...)
end

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
})

-- Swift and C-based languages
lspconfig.sourcekit.setup({
  capabilities = capabilities,
})

-- TypeScript
lspconfig.tsserver.setup({
  cmd = { "npx", "typescript-language-server", "--stdio" },
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      function()
        local bufnr = 0
        vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(bufnr) },
        })
        vim.lsp.buf.format({ async = true })
      end,
      description = "Organize Imports",
    },
  },
})

--[[ Use lspsaga instead

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "cd", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "ck", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "cj", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "cD", vim.diagnostic.setloclist, opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Use nvim-cmp instead
    -- Enable completion triggered by <c-x><c-o>
    --vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true, buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wl', function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)
    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "ca", vim.lsp.buf.code_action, opts)
    --vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --vim.keymap.set("n", "<space>f", function()
    --  vim.lsp.buf.format({ async = true })
    --end, opts)
  end,
})

]] -- Use lspsaga instead
