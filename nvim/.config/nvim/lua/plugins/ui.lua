return {

  -- Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = { "hostname" },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", colored = false },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            colored = false,
            update_in_insert = true,
            always_visible = true,
          },
          "mode",
        },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
    },
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    main = "ibl",
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  -- -- Dashboard
  -- {
  --     "goolord/alpha-nvim",
  --     event = "VimEnter",
  --     opts = function()
  --         local dashboard = require("alpha.themes.dashboard")
  --         local logo = [[
  --     ▄▄▄       ██▓     ██ ▄█▀ ███▄ ▄███▓  ██████ ▄▄▄█████▓
  --    ▒████▄    ▓██▒     ██▄█▒ ▓██▒▀█▀ ██▒▒██    ▒ ▓  ██▒ ▓▒
  --    ▒██  ▀█▄  ▒██░    ▓███▄░ ▓██    ▓██░░ ▓██▄   ▒ ▓██░ ▒░
  --    ░██▄▄▄▄██ ▒██░    ▓██ █▄ ▒██    ▒██   ▒   ██▒░ ▓██▓ ░
  --     ▓█   ▓██▒░██████▒▒██▒ █▄▒██▒   ░██▒▒██████▒▒  ▒██▒ ░
  --     ▒▒   ▓▒█░░ ▒░▓  ░▒ ▒▒ ▓▒░ ▒░   ░  ░▒ ▒▓▒ ▒ ░  ▒ ░░
  --      ▒   ▒▒ ░░ ░ ▒  ░░ ░▒ ▒░░  ░      ░░ ░▒  ░ ░    ░
  --      ░   ▒     ░ ░   ░ ░░ ░ ░      ░   ░  ░  ░    ░
  --          ░  ░    ░  ░░  ░          ░         ░
  --   ]]

  --         dashboard.section.header.val = vim.split(logo, "\n")
  --         dashboard.section.buttons.val = {
  --             dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
  --             dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  --             dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
  --             dashboard.button("g", "  Find text", ":Telescope live_grep <CR>"),
  --             dashboard.button("l", "⏾  Lazy", ":Lazy<CR>"),
  --             dashboard.button("q", "  Quit", ":qa<CR>"),
  --         }
  --         for _, button in ipairs(dashboard.section.buttons.val) do
  --             button.opts.hl = "AlphaButtons"
  --             button.opts.hl_shortcut = "AlphaShortcut"
  --         end
  --         dashboard.section.footer.opts.hl = "Type"
  --         dashboard.section.header.opts.hl = "AlphaHeader"
  --         dashboard.section.buttons.opts.hl = "AlphaButtons"
  --         dashboard.opts.layout[1].val = 8
  --         return dashboard
  --     end,
  --     config = function(_, dashboard)
  --         -- close Lazy and re-open when the dashboard is ready
  --         if vim.o.filetype == "lazy" then
  --             vim.cmd.close()
  --             vim.api.nvim_create_autocmd("User", {
  --                 pattern = "AlphaReady",
  --                 callback = function()
  --                     require("lazy").show()
  --                 end,
  --             })
  --         end

  --         require("alpha").setup(dashboard.opts)
  --     end,
  -- },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
            ▄▄▄       ██▓     ██ ▄█▀ ███▄ ▄███▓  ██████ ▄▄▄█████▓
           ▒████▄    ▓██▒     ██▄█▒ ▓██▒▀█▀ ██▒▒██    ▒ ▓  ██▒ ▓▒
           ▒██  ▀█▄  ▒██░    ▓███▄░ ▓██    ▓██░░ ▓██▄   ▒ ▓██░ ▒░
           ░██▄▄▄▄██ ▒██░    ▓██ █▄ ▒██    ▒██   ▒   ██▒░ ▓██▓ ░
            ▓█   ▓██▒░██████▒▒██▒ █▄▒██▒   ░██▒▒██████▒▒  ▒██▒ ░
            ▒▒   ▓▒█░░ ▒░▓  ░▒ ▒▒ ▓▒░ ▒░   ░  ░▒ ▒▓▒ ▒ ░  ▒ ░░
             ▒   ▒▒ ░░ ░ ▒  ░░ ░▒ ▒░░  ░      ░░ ░▒  ░ ░    ░
             ░   ▒     ░ ░   ░ ░░ ░ ░      ░   ░  ░  ░    ░
                 ░  ░    ░  ░░  ░          ░         ░
        ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = "ene | startinsert", desc = " New File", icon = " ", key = "n" },
            { action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
            { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
            { action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
            { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
            {
              action = function()
                vim.api.nvim_input("<cmd>qa<cr>")
              end,
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 32 - #button.desc)
        button.key_format = "  %s"
      end

      return opts
    end,
    config = function(_, opts)
      require("dashboard").setup(opts)
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
}
