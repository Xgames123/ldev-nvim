local KEY_ESCAPE="mh"

local map = {
  general={
    {KEY_ESCAPE, "<Esc>", mode={"v", "i", "c"}, desc="Escape"},
    {"p", ":pu<CR>", mode="n", desc="Put on content of [x] below the cursor"},
    {"<M-p>", "p", mode="n", desc="Put on content of [x] below the cursor"},
    {"<C-p>", ":pu +<CR>", mode="n", desc="Put on content of the system clipboard below the cursor"},
    {"<C-M-p>", "\"+p", mode="n", desc="Paste from system clipboard"},
    {"<C-y>", "\"+y", mode={"n", "v"}, desc="Yank to system clipboard"},

    i = {
     -- go to  beginning and end
	    ["<C-a>"] = { "<ESC>^i", "Beginning of line" },
	    ["<C-e>"] = { "<End>", "End of line" },

	    -- navigate within insert mode
	    ["<C-h>"] = { "<Left>", "Move left" },
	    ["<C-l>"] = { "<Right>", "Move right" },
	    ["<C-j>"] = { "<Down>", "Move down" },
	    ["<C-k>"] = { "<Up>", "Move up" },
    },
    n = {
      ["é"] = {
        "^",
        "Go to start of line"
      },
      ["ù"] = {"%", "Go to next matching bracket"},
      ["gm"] = {
        "]m",
        "Go to method start"
      },
      ["gM"] = {
        "]M",
        "Go to method end"
      },
      [KEY_ESCAPE] = { ":noh <CR>", "Clear highlights" },
      -- switch between windows
      ["<C-h>"] = { "<C-w>h", "Window left" },
      ["<C-l>"] = { "<C-w>l", "Window right" },
      ["<C-j>"] = { "<C-w>j", "Window down" },
      ["<C-k>"] = { "<C-w>k", "Window up" },
      -- split
      ["<C-s>"] = { "<cmd> split <CR>", "Split window" },
      ["<C-sv>"] = { "<cmd> vs <CR>", "Split window vertically" },
      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      -- empty mode is same as using <cmd> :map
      -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

      -- new buffer
      ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
      ["<leader>x"] = { "<cmd> :bdelete  <CR>", "Delete buffer" },

    },
    v = {
      ["ù"] = {"%"},
      ["é"] = {
        "^",
        "Go to start of line"
      },

      ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
      ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    },
    t = {
      ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
    },
    x = {
      ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
      ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
      -- Don't copy the replaced text after pasting in visual mode
      -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
      ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
      [KEY_ESCAPE] = { "<Esc>" },
    }
  },
  -- tabbufline={
  --    n = {
  --       -- cycle through buffers
  --       ["<tab>"] = {
  --         function()
  --           require("nvchad.tabufline").tabuflineNext()
  --         end,
  --         "Goto next buffer",
  --       },
  --
  --       ["<S-tab>"] = {
  --         function()
  --           require("nvchad.tabufline").tabuflinePrev()
  --         end,
  --         "Goto prev buffer",
  --       },
  --
  --       -- close buffer + hide terminal buffer
  --       ["<leader>x"] = {
  --         function()
  --           require("nvchad.tabufline").close_buffer()
  --         end,
  --         "Close buffer",
  --       },
  --    }  
  --
  -- },

  spell={
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
    i={
      ["<C-s>"] = {
        function()
          require("telescope.builtin").spell_suggest()
        end,
        "Spelling suggestions for word under cursor"
      }
    }
  },

}



local M = {}
M.map = map
M.load = function ()
  for _, mapping in pairs(M.map) do
    if mapping ~= nil then
        for mode, mode_values in pairs(mapping) do
          if type(mode) == "number" then
            local opts = mode_values.opts or {}
            opts.desc = mode_values.desc
            vim.keymap.set(mode_values.mode or "n", mode_values[1], mode_values[2], opts)
          elseif type(mode_values) ~= "boolean" then
            for keybind, mapping_info in pairs(mode_values) do
              local final_opts = mapping_info.opts or {}

              final_opts.desc = mapping_info[2]
              vim.keymap.set(mode, keybind, mapping_info[1], final_opts)
            end
          end
        end
    end
  end
end
return M
