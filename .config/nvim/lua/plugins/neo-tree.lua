vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
  sources = { "filesystem" },
  hide_root_node = true,
  source_selector = {
    winbar = true,
    sources = {
      {
        source = "filesystem",
        display_name = " " .. vim.fs.basename(vim.fn.getcwd()),
      },
    },
  },
  default_component_configs = {
    indent = {
      with_expanders = false,
    },
    icon = {
      folder_closed = "▶",
      folder_open = "▼",
      folder_empty = "▷",
      folder_empty_open = "▽",
      default = " ",
    },
    modified = {
      symbol = "●",
    },
    git_status = {
      symbols = {
        -- Change type
        added = "A",
        deleted = "D",
        modified = "M",
        renamed = "R",
        -- Status type
        untracked = "U",
        ignored = "",
        unstaged = "?",
        staged = "✓",
        conflict = "C",
      },
    },
  },
  nesting_rules = {
    ["test.js"] = { "test.d.ts" },
    js = { "d.ts", "d.ts.map", "js.map" },
    ts = { "js", "js.map" },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      never_show = {
        ".DS_Store",
        ".git",
        "Thumbs.db",
      },
    },
    follow_current_file = true,
  },
})
