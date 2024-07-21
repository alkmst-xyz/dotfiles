return {
    -- File Explorer
    {
        'nvim-neo-tree/neo-tree.nvim',
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("neo-tree.command").execute({ toggle = true })
                end,
                desc = "Explorer NeoTree (Root Dir)",
            },
            {
                "<leader>E",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
            {
                "<leader>ge",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git Explorer",
            },
            {
                "<leader>be",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer Explorer",
            },
            -- TODO: <leader>s is already used for search, find another key
            -- {
            --     "<leader>se",
            --     function()
            --         require("neo-tree.command").execute({ source = "document_symbols", toggle = true })
            --     end,
            --     desc = "Symbols Explorer",
            -- },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
            -- because `cwd` is not set up properly.
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
                desc = "Start Neo-tree with directory",
                once = true,
                callback = function()
                    if package.loaded["neo-tree"] then
                        return
                    else
                        local stats = vim.uv.fs_stat(vim.fn.argv(0))
                        if stats and stats.type == "directory" then
                            require("neo-tree")
                        end
                    end
                end,
            })
        end,
        opts = {
            source_selector                 = {
                winbar = true,
            },
            sources                         = { "filesystem", "buffers", "git_status", "document_symbols" },
            close_if_last_window            = true,
            open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
            default_component_configs       = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                git_status = {
                    symbols = {
                        unstaged = "󰄱",
                        staged = "󰱒",
                    },
                },
            },
            window                          = {
                width = 36,
                mappings = {
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["<space>"] = "none",
                    ["Y"] = {
                        function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.fn.setreg("+", path, "c")
                        end,
                        desc = "Copy Path to Clipboard",
                    },
                    -- ["O"] = {
                    --     function(state)
                    --         require("lazy.util").open(state.tree:get_node().path, { system = true })
                    --     end,
                    --     desc = "Open with System Application",
                    -- },
                    ["P"] = { "toggle_preview", config = { use_float = false } },
                },
            },
            filesystem                      = {
                bind_to_cwd = false,
                follow_current_file = { enabled = true },
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
            },
        },
        config = function(_, opts)
            -- local function on_move(data)
            --     LazyVim.lsp.on_rename(data.source, data.destination)
            -- end

            -- local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            -- vim.list_extend(opts.event_handlers, {
            --     { event = events.FILE_MOVED,   handler = on_move },
            --     { event = events.FILE_RENAMED, handler = on_move },
            -- })
            require("neo-tree").setup(opts)
            -- vim.api.nvim_create_autocmd("TermClose", {
            --     pattern = "*lazygit",
            --     callback = function()
            --         if package.loaded["neo-tree.sources.git_status"] then
            --             require("neo-tree.sources.git_status").refresh()
            --         end
            --     end,
            -- })
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts_extend = { "spec" },
        opts = {
            spec = {
                {
                    mode = { "n", "v" },
                    { "<leader>c", group = "[C]ode" },
                    { "<leader>d", group = "[D]ocument" },
                    { "<leader>r", group = "[R]ename" },
                    { "<leader>s", group = "[S]earch" },
                    { "<leader>w", group = "[W]orkspace" },
                    { "<leader>t", group = "[T]oggle" },
                    { "<leader>h", group = "Git [H]unk", mode = { 'n', 'v' } },

                    -- TODO: broken
                    -- { "<leader><tab>", group = "[T]abs" },
                    -- { "<leader>f", group = "file/find" },
                    -- { "<leader>g", group = "git" },
                    -- { "<leader>gh", group = "hunks" },
                    -- { "<leader>q", group = "quit/session" },
                    -- { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
                    -- { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
                    -- { "[", group = "prev" },
                    -- { "]", group = "next" },
                    -- { "g", group = "goto" },
                    -- { "gs", group = "surround" },
                    -- { "z", group = "fold" },
                    {
                        "<leader>b",
                        group = "buffer",
                        expand = function()
                            return require("which-key.extras").expand.buf()
                        end,
                    },
                    {
                        "<leader>w",
                        group = "windows",
                        proxy = "<c-w>",
                        expand = function()
                            return require("which-key.extras").expand.win()
                        end,
                    },
                    -- TODO: broken
                    -- better descriptions
                    -- { "gx", desc = "Open with system app" },
                },
            },
        },
        keys = {
--            {
--                "<leader>?",
--                function()
--                    require("which-key").show({ global = false })
--                end,
--                desc = "Buffer Keymaps (which-key)",
--            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        },
        config = function(_, opts)
            require("which-key").setup(opts)
        end,
    }
}
