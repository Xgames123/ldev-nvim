local function ls_cmd()
  if vim.fn.executable("ls") then
    return { "ls" }
  end
  return { "dir", "/b" }
end


local function setup(opts)
  vim.api.nvim_create_user_command("Repos", function(_data)
    local pickers      = require("telescope.pickers")
    local conf         = require("telescope.config").values
    local finders      = require("telescope.finders")
    local actions      = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    if not opts then
      opts = {}
    end

    local base_path = vim.env.HOME .. "/source/repos"

    pickers
        .new(opts, {
          prompt_title = "Find Repository",
          finder = finders.new_oneshot_job(ls_cmd(), { cwd = base_path }),
          previewer = conf.grep_previewer(opts),
          sorter = conf.file_sorter(opts),

          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              if not selection then
                return
              end
              actions.close(prompt_bufnr)
              local target_path = base_path .. "/" .. selection.value
              vim.cmd("cd " .. target_path)
            end)
            return true
          end,
        })
        :find()
  end, { nargs = 0 })
end

return {
  setup = setup
}
