local KEY_ESCAPE = "mh"

local M = { }

M.global_map = {
  general ={
    { KEY_ESCAPE, "<Esc>", mode = { "v", "i", "c" } },

    { "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>", desc = "replace highlighted word" },
    -- copy paste
    { "<leader>p", "\"_dP",   desc = "Replace selected",                          mode  = "v"           },
    { "<M-p>",     ":pu<CR>", desc = "Paste below cursor",                        mode  = "n"           },
    -- sys clipboard
    { "<leader>y", "\"+",     desc = "System clipboard",                          mode  = { "n", "v" }  },
    { "<C-p>",     "\"+p",    desc = "Paste the content of the system clipboard", mode  = { "n", "v" }  },
    { "<C-y>",     "\"+y",    desc = "Yank to system clipboard",                  mode  = { "n", "v" }  },
    { "<C-p>",     "<C-r>+",  desc = "Paste the content of the system clipboard", mode  = "c"           },

    -- move block
    { "J",     ":m '>+1<CR>gv=gv", mode= "v" },
    { "K",     ":m '<-2<CR>gv=gv", mode= "v" },

    { "<C-d>", "<C-d>zz" },
    { "<C-u>", "<C-u>zz" },
    { "n",     "nzzzv"   },
    { "N",     "Nzzzv"   },

    -- go to beginning and end
    { "<C-a>", "<ESC>^i", desc = "Beginning of line", mode = "i" },
    { "<C-e>", "<End>", desc = "End of line", mode = { "n", "i" } },

    -- navigate within insert mode
    { "<C-h>", "<Left>", desc = "Move left", mode = "i" },
    { "<C-l>", "<Right>", desc = "Move right", mode = "i" },
    { "<C-j>", "<Down>", desc = "Move down", mode = "i" },
    { "<C-k>", "<Up>", desc = "Move up", mode = "i" },

    -- azerty remaps
    { "é", "^", desc = "Go to start of line", mode = { "v", "n" } },
    { "ù", "%", desc = "Go to matching brace", mode = { "n", "v" } },

    { "gm", "]m", desc = "Go to method start", mode = "n" },

    {"gM", "]M", desc = "Go to method end", mode = "n" },
    {"<Esc>", ":noh <CR>", desc = "Clear highlights", mode = "n" },

    -- switch between windows
    {"<C-h>", "<C-w>h", desc = "Window left", mode = "n" },
    {"<C-l>", "<C-w>l", desc = "Window right", mode = "n" },
    {"<C-j>", "<C-w>j", desc = "Window down", mode = "n" },
    {"<C-k>", "<C-w>k", desc = "Window up", mode = "n" },
    -- split
    {"<C-s>", "<cmd> split <CR>", desc = "Split window", mode = "n" },
    {"<C-sv>", "<cmd> vs <CR>", desc = "Split window vertically", mode = "n" },
    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    {"j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', desc = "Move down", opts = { expr = true }, mode = "n" },
    {"k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', desc = "Move up", opts = { expr = true }, mode = "n" },
    {"<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', desc = "Move up", opts = { expr = true }, mode = "n" },
    {"<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', desc = "Move down", opts = { expr = true } , mode = "n" },

    -- new buffer
    {"<leader>b", "<cmd> enew <CR>", desc = "New buffer", mode = "n" },
    {"<leader>x", "<cmd> :bdelete <CR>", desc = "Delete buffer", mode = "n" },

    v = {

      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    },
    t = {
      ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
    },
    x = {
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    }
  },

  spell ={
    n = {
      ["gs"] = {
        "]s",
        "Next misspelled word"
      },
      ["gS"] = {
        "[s",
        "Previous misspelled word"
      },
      ["ss"] = {
        function()
          require("telescope.builtin").spell_suggest()
        end,
        "Spelling suggestions for word under cursor"
      },
      ["sg"] = {
        "zg",
        "Add word to spell list"
      },
      ["sb"] = {
        "zw",
        "Mark work as misspelled"
      }
    },
    i ={
      ["<C-s>"] = {
        function()
          require("telescope.builtin").spell_suggest()
        end,
        "Spelling suggestions for word under cursor"
      }
    }
  },
  lazy_term ={
    {
      "<M-i>",
      function()
        toggle_float_term();
      end,
      mode = { "n", "t" },
      desc = "Toggle a floating terminal",
    }

  }

}


M.load = function (maps)
  for mode, mode_values in pairs(maps) do
    if type(mode) == "number" then
      local opts = mode_values.opts or { }
      opts.desc = mode_values.desc
      vim.keymap.set(mode_values.mode or "n", mode_values[1], mode_values[2], opts)
    elseif type(mode_values) ~= "boolean" then
      for keybind, mapping_info in pairs(mode_values) do
        local final_opts = mapping_info.opts or { }

        final_opts.desc = mapping_info[2]
        vim.keymap.set(mode, keybind, mapping_info[1], final_opts)
      end
    end
  end
end

M.load_global = function ()
  for _, mapping in pairs(M.global_map) do
    if mapping ~= nil then
      M.load(mapping)
    end
  end
end
return M
