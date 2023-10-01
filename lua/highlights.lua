print("hi")
local highlights = {
  SpellBad={bg="#522222"},
  SpellLocal={bg="#522222"},
  SpellCap = {bg="#524222"},
  SpellRare = {bg="#224222"},

}



for name, hi in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, hi)
end
