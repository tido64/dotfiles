require("lspsaga").setup({
  code_action = {
    extend_gitsigns = true,
    keys = {
      quit = "<Esc>",
      exec = "<CR>",
    },
  },
  lightbulb = {
    enable = false,
  },
  rename = {
    quit = "<Esc>",
  },
  symbol_in_winbar = {
    enable = false,
  },
  ui = {
    border = "rounded",
  },
})

local normal_keymap = {
  --["gh"] = "finder",
  ["gd"] = "goto_definition",
  ["<space>rn"] = "rename",
  ["K"] = "hover_doc",
  ["cd"] = "show_line_diagnostics",
  ["cj"] = "diagnostic_jump_next",
  ["ck"] = "diagnostic_jump_prev",
  ["ca"] = "code_action",
}

local keymap = vim.keymap.set
local silent_noremap = { silent = true, noremap = true }

for lhs, command in pairs(normal_keymap) do
  keymap("n", lhs, function(arg)
    require("lspsaga.command").load_command(command, arg)
  end, silent_noremap)
end
