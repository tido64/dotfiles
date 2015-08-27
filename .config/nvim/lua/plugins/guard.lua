local ft = require("guard.filetype")

-- C-based languages

for _, filetype in ipairs({ "c", "cpp", "cs", "cuda", "java", "objc", "objcpp" }) do
  ft(filetype):fmt("clang-format")
end

-- JavaScript/TypeScript

local eslint = {
  cmd = "npx",
  args = { "eslint", "-f", "json", "--stdin", "--stdin-filename" },
  fname = true,
  stdin = true,
}
local prettier = {
  cmd = "npx",
  args = { "prettier", "--stdin-filepath" },
  fname = true,
  stdin = true,
}
for _, filetype in ipairs({
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
}) do
  ft(filetype):fmt(prettier):lint(eslint)
end

-- Kotlin

ft("kotlin"):fmt({
  cmd = "ktlint",
  args = {
    "--code-style=android_studio",
    "--format",
    "--stdin",
    "**/*.kt",
    "**/*.kts",
  },
  stdin = true,
}):lint({
  cmd = "ktlint",
  args = {
    "--relative",
    "--reporter=json",
    "**/*.kt",
    "**/*.kts",
  },
  stdin = true,
})

-- Lua

ft("lua"):fmt({
  cmd = "stylua",
  args = {
    "--column-width",
    "80",
    "--indent-type",
    "spaces",
    "--indent-width",
    "2",
    "-",
  },
  stdin = true,
})

-- Markdown

ft("markdown"):fmt(prettier)

-- Python

ft("python"):fmt("black"):lint("pylint")

-- Ruby

ft("ruby"):fmt("rubocop"):lint("rubocop")

-- Swift

ft("swift"):fmt({
  cmd = "swiftformat",
  args = {
    "--swiftversion",
    "5.7",
    "--ifdef",
    "no-indent",
    "--stripunusedargs",
    "closure-only",
    "stdin",
  },
  stdin = true,
})

--

require("guard").setup({
  fmt_on_save = false,
})

vim.api.nvim_create_user_command("Format", "GuardFmt", { range = true })
