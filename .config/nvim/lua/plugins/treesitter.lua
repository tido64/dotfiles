local function parsers_for(os)
  if os == "Windows" then
    return {}
  else
    return {
      "bash",
      "c",
      "cpp",
      "html",
      "java",
      "json",
      "kotlin",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "rust",
      "swift",
      "tsx",
      "typescript",
      "yaml",
    }
  end
end

require("nvim-treesitter.configs").setup({
  ensure_installed = parsers_for(jit.os),
  highlight = {
    enable = true,
  },
})
