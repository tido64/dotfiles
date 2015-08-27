if vim.g.did_load_filetypes then
  return
end

local filetypes = {
  javascript = { "*.jsbundle" },
  json = { "*.bundle.map", "*.js.map", "*.jsbundle.map" },
  objc = { "*.m" },
  objcpp = { "*.mm" },
  ruby = { "Podfile", "*.podspec" },
}

local events = { "BufNewFile", "BufRead" }
local ftdetect = vim.api.nvim_create_augroup("filetypedetect", { clear = true })

for filetype, pattern in pairs(filetypes) do
  vim.api.nvim_create_autocmd(events, {
    group = ftdetect,
    pattern = pattern,
    callback = function()
      vim.cmd.setfiletype(filetype)
    end,
  })
end
