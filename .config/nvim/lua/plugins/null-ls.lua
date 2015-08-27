local null_ls = require("null-ls")
local h = require("null-ls.helpers")
local u = require("null-ls.utils")

local prefer_virtual_env = {
  prefer_local = ".venv/bin",
}

local node_modules_resolver = {
  dynamic_command = function(params)
    local spec = params.command
    for dir in vim.fs.parents(params.bufname) do
      local pkg = u.path.join(dir, "node_modules", spec, "package.json")
      if u.path.exists(pkg) then
        local json = table.concat(vim.fn.readfile(pkg), "\n")
        local manifest = vim.json.decode(json)
        local bin = type(manifest.bin) == "string" and manifest.bin
          or manifest.bin[spec]
        return u.path.join(dir, "node_modules", spec, bin)
      end
    end

    return spec
  end,
}

null_ls.setup({
  sources = {
    require("none-ls.code_actions.eslint").with(node_modules_resolver),
    null_ls.builtins.code_actions.gitsigns,
    require("none-ls.diagnostics.eslint").with(node_modules_resolver),
    null_ls.builtins.diagnostics.ktlint,
    null_ls.builtins.diagnostics.mypy.with(prefer_virtual_env),
    null_ls.builtins.diagnostics.pylint.with(prefer_virtual_env),
    null_ls.builtins.diagnostics.rubocop.with({
      command = "bundle",
      args = vim.list_extend(
        { "exec", "rubocop" },
        null_ls.builtins.diagnostics.rubocop._opts.args
      ),
      dynamic_command = detect_package_manager,
    }),
    null_ls.builtins.formatting.black.with(prefer_virtual_env),
    null_ls.builtins.formatting.clang_format.with({
      filetypes = { "c", "cpp", "cs", "cuda", "java", "objc", "objcpp" },
    }),
    null_ls.builtins.formatting.ktlint,
    null_ls.builtins.formatting.prettier.with(node_modules_resolver),
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.stylua.with({
      extra_args = {
        "--column-width",
        "80",
        "--indent-type",
        "spaces",
        "--indent-width",
        "2",
      },
    }),
    null_ls.builtins.formatting.swiftformat.with({
      extra_args = {
        "--swiftversion",
        "5.8",
        "--ifdef",
        "no-indent",
        "--stripunusedargs",
        "closure-only",
      },
    }),
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  vim.lsp.buf.format({
    bufnr = args.bufnr,
    name = "null-ls",
    range = args.range > 0 and {
      ["start"] = { args.line1, 0 },
      ["end"] = { args.line2, 0 },
    } or nil,
  })
end, { range = true })
