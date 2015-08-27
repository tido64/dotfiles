local telescope = nil
local function load_telescope()
  if telescope == nil then
    telescope = require("telescope")

    local config = require("telescope.config")
    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

    -- Include hidden files
    table.insert(vimgrep_arguments, "--hidden")
    -- Ignore `.git/`
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!.git/*")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "/Pods/",
          "/lib/.-%.d%.ts",
          "/lib/.-%.js%.map",
          "/lib/.-%.ts%.map",
          "/node_modules/",
        },
        mappings = {
          i = {
            ["<Esc>"] = function(prompt_bufnr)
              require("telescope.actions").close(prompt_bufnr)
            end,
          },
        },
        vimgrep_arguments = vimgrep_arguments,
      },
      extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = false,
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<C-w>"] = function(prompt_bufnr)
                require("telescope.actions").delete_buffer(prompt_bufnr)
              end,
            },
          },
        },
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
      },
      preview = {
        timeout = false,
      },
    })

    if jit.os ~= "Windows" then
      telescope.load_extension("fzf")
    end
  end

  return telescope
end

local noremap = { noremap = true }

function set_keymap_builtin(lhs, rhs)
  vim.keymap.set("n", lhs, function(opts)
    load_telescope()
    rhs(require("telescope.builtin"), opts)
  end, noremap)
end

set_keymap_builtin("<C-p>", function(builtin, opts)
  builtin.find_files(opts)
end)

set_keymap_builtin("<C-f>", function(builtin, opts)
  builtin.live_grep(opts)
end)

set_keymap_builtin("<C-o>", function(builtin, opts)
  builtin.buffers(opts)
end)

set_keymap_builtin("<S-f>", function(builtin, opts)
  builtin.resume(opts)
end)

--[[
vim.keymap.set("n", "<Leader>fb", function()
  local telescope = load_telescope()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = "%:p:h",
    grouped = true,
    select_buffer = true,
    hidden = true,
    respect_gitignore = false,
    dir_icon = "",
  })
end, noremap)
]]
