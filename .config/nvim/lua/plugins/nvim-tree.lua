require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
})

local function is_empty_buffer(data)
  return data.file == "" and vim.bo[data.buf].buftype == ""
end

local function is_real_file(data)
  if vim.fn.filereadable(data.file) == 0 then
    return false
  end

  local filename = vim.fs.basename(data.file)

  -- Ignore Git commit message
  if filename == "COMMIT_EDITMSG" then
    local parent = vim.fs.dirname(data.file)
    return vim.fs.basename(parent) ~= ".git"
  end

  -- Ignore Git rebase
  if filename == "git-rebase-todo" then
    local operation = vim.fs.dirname(data.file)
    local parent = vim.fs.dirname(operation)
    return vim.fs.basename(parent) ~= ".git"
  end

  return true
end

local function toggle_nvim_tree()
  require("nvim-tree.api").tree.toggle({ find_file = true, focus = false })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(data)
    vim.keymap.set("n", "<Leader>fb", toggle_nvim_tree, { noremap = true })

    if not is_real_file(data) and not is_empty_buffer(data) then
      return
    end

    -- open the tree, find the file but don't focus it
    toggle_nvim_tree()
  end
})
