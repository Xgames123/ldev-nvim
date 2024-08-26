local highlights = {
  SpellBad = { bg = "#300000" },
  SpellLocal = { bg = "#300000" },
  SpellCap = { bg = "#302000" },
  SpellRare = { bg = "#003000" },

  -- background
  Normal = { bg = "none" },
  NormalNC = { bg = "none" },
  LineNr = { bg = "none" },
  LineNrAbove = { bg = "none" },
  LineNrBelow = { bg = "none" },
  FoldColumn = { bg = "none" },
  SignColumn = { bg = "none" },
  GitGutterAdd = {fg="#a9b665", bg="None"},
  GitGutterChange = {fg="#7daea3", bg="None"},
  GitGutterDelete = {fg="#ea6962", bg="None"},

}

for name, hi in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, hi)
end
