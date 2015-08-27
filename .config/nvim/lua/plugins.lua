local function load_packer()
  local status, packer = pcall(require, "packer")
  if not status then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/wbthomason/packer.nvim",
      vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim",
    })
    vim.cmd.packadd("packer.nvim")
    return require("packer"), true
  end

  return packer, false
end

local packer, should_bootstrap = load_packer()
packer.startup(function(use)
  use("wbthomason/packer.nvim")

  -- color scheme
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("plugins/tokyonight")
    end,
  })
  --use("tomasr/molokai")

  -- Nvim statusline
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins/lualine")
    end,
  })

  -- fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("plugins/telescope")
    end,
  })
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    run = "CFLAGS=-march=native make",
  })

  -- Nvim Treesitter configurations and abstraction layer
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("plugins/treesitter")
    end,
  })

  -- File/buffer explorer
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins/neo-tree")
    end,
  })

  -- Nvim Language Server Protocol
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins/lspconfig")
    end,
    event = "BufReadPre",
  })

  use ({
    "nvimdev/lspsaga.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("plugins/lspsaga")
    end,
  })

  -- git decorations in the sign column
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
    event = "BufRead",
  })

  -- completion engine
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "L3MON4D3/LuaSnip", event = "InsertEnter" },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins/completion")
    end,
    event = "BufReadPost",
  })

  -- formatting, linters, etc.
  use({
    "nvimtools/none-ls.nvim",
    requires = {
      "hrsh7th/nvim-cmp",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require("plugins/null-ls")
    end,
    event = "BufReadPost",
  })

  if should_bootstrap then
    packer.sync()
  end
end)

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("packer_user_config", { clear = true }),
  pattern = "*/nvim/lua/plugins.lua",
  callback = function(ctx)
    vim.cmd.source(ctx.file)
    vim.cmd.PackerCompile()
  end,
})
