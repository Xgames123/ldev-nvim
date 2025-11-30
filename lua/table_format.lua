local function pad(str, target_len, align)
  local len = (target_len - #str)
  if align == 1 then
    return str .. (" "):rep(len)
  elseif align == 2 then
    return (" "):rep(len) .. str
  elseif align == 3 then
    return (" "):rep(math.floor(len / 2)) .. str .. (" "):rep(math.ceil(len / 2))
  end
end

local function is_header_line(str)
  return string.find(str, "^[-%s|]*$") ~= nil
end

function setup()
  vim.api.nvim_create_user_command("TableFormat", function(opts)
    local lstart = opts.line1
    local lend = opts.line2

    local col_min_widths = {}
    local col_align = {}
    local tab = {}
    local found_table = false

    local tstart = 1
    local tend = lend - lstart + 2
    local twidth = 0
    local header_lines = {}

    local lines = vim.api.nvim_buf_get_lines(0, lstart - 1, lend, false)
    -- find min col lens
    for linei, line in ipairs(lines) do
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
        local not_header = false
        for celli, cell in ipairs(split) do
          local cell = vim.trim(cell)

          if cell:find("^[:-]*$") == nil then
            not_header = true
          end
          if not not_header then
            header_lines[linei] = true
            col_align[celli] = { left = cell:sub(1, 1) == ":", right = cell:sub(-1, -1) == ":" }
          else
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
      end
    end
    -- write new lines
    for linei = tstart, tend - 1, 1 do
      local new_line = "|"
      for celli = 1, twidth, 1 do
        local width = col_min_widths[celli]
        if header_lines[linei] == true then
          local lalign_char = ""
          local ralign_char = ""
          width = width + 2
          if col_align[celli].left then
            lalign_char = ":"
            width = width - 1
          end
          if col_align[celli].right then
            ralign_char = ":"
            width = width - 1
          end

          new_line = new_line .. lalign_char .. ("-"):rep(width) .. ralign_char .. "|"
          goto continue
        end
        local cell = tab[linei][celli]
        if cell == nil then
          cell = ""
        end
        local align = 1
        if col_align[celli].left and col_align[celli].right then
          align = 3
        elseif col_align[celli].left then
          align = 1
        elseif col_align[celli].right then
          align = 2
        end
        new_line = new_line .. " " .. pad(cell, width, align) .. " |"
        ::continue::
      end
      lines[linei] = new_line
    end
    vim.api.nvim_buf_set_lines(0, lstart - 1, lend, false, lines)
  end, { nargs = 0, range = true })
end

return {
  setup = setup
}
