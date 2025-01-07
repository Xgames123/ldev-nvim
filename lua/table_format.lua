local function pad(str, target_len)
  local len = (target_len - #str) / 2
  return (" "):rep(math.floor(len)) .. str .. (" "):rep(math.ceil(len))
end

local function is_header_line(str)
  return string.find(str, "^[-%s|]*$") ~= nil
end


vim.api.nvim_create_user_command("TableFormat", function(opts)
  local lstart = opts.line1
  local lend = opts.line2

  local col_min_widths = {}
  local tab = {}
  local found_table = false

  local tstart = 1
  local tend = lend - lstart + 2
  local twidth = 0
  local header_lines = {}

  local lines = vim.api.nvim_buf_get_lines(0, lstart - 1, lend, false)
  -- find min col lens
  for linei, line in ipairs(lines) do
    if is_header_line(line) then
      header_lines[linei] = {}
      goto continue
    end
    local line = line:match("^%s*|?%s*(.-)%s*|?%s*$")
    local split = vim.split(line, "|")

    if not found_table and (#split > 1 or #split[1] ~= 0) then
      found_table = true
      tstart = linei
    end
    if found_table then
      if #split[1] == 0 then
        tend = linei
        break -- end of table
      end
      tab[linei] = {}
      for celli, cell in ipairs(split) do
        local cell = vim.trim(cell)
        tab[linei][celli] = cell
        local w = string.len(cell)
        if col_min_widths[celli] == nil or col_min_widths[celli] < w then
          if w < 1 then
            w = 1
          end
          col_min_widths[celli] = w
        end
        if celli > twidth then
          twidth = celli
        end
      end
    end
    ::continue::
  end
  -- write new lines
  for linei = tstart, tend - 1, 1 do
    local new_line = "|"
    for celli = 1, twidth, 1 do
      local width = col_min_widths[celli]
      if header_lines[linei] ~= nil then
        new_line = new_line .. " " .. ("-"):rep(width) .. " |"
        goto continue
      end
      local cell = tab[linei][celli]
      if cell == nil then
        cell = ""
      end
      new_line = new_line .. pad(cell, width + 2) .. "|"
      ::continue::
    end
    lines[linei] = new_line
  end
  vim.api.nvim_buf_set_lines(0, lstart - 1, lend, false, lines)
end, { nargs = 0, range = true })
