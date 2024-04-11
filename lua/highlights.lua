local highlights = {
  SpellBad={bg="#300000"},
  SpellLocal={bg="#300000"},
  SpellCap = {bg="#302000"},
  SpellRare = {bg="#003000"},

}

for name, hi in pairs(highlights) do
  vim.api.nvim_set_hl(0, name, hi)
end
