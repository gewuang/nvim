return {
    -- icon
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
    },

    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        config = function()
            require("plugins.config.lualine")
        end,
    },

    { "EdenEast/nightfox.nvim" },
    {
        "karb94/neoscroll.nvim",
        lazy = false,
        opt = true,
        config = function()
            require("plugins.config.neoscroll")
        end,
    },

    -- 快速选择
    -- {
    --     "gcmt/wildfire.vim",
    --     keys = "<CR>",
    -- },
    {
        "sustech-data/wildfire.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("wildfire").setup()
        end,

    },
    -- 更好看的提示框?
    {
        "stevearc/dressing.nvim",
        opts = {},
        config = function()
            require("plugins.config.dressing")
        end,
    },

    -- ?
    -- { "folke/neoconf.nvim",    cmd = "Neoconf" },
    -- "folke/neodev.nvim",

    -- 目录树(需要配置
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v3.x",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --         -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    --     }
    -- },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        config = function()
            require("plugins.config.nvim-tree")
        end,
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        version = "*",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    -- {
    --     "echasnovski/mini.animate",
    --     event = "VeryLazy",
    --     version = '*',
    --     config = function()
    --         require('mini.animate').setup()
    --     end,
    -- },

    -- 启动时间
    {
        "dstein64/vim-startuptime",
        -- lazy-load on a command
        cmd = "StartupTime",
        -- init is called during startup. Configuration for vim plugins typically should be set in an init function
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },

    -- 自动补全
    -- auto completion
    {
        "hrsh7th/nvim-cmp",
        -- version = false, -- last release is way too old
        -- lazy = false,
        event = "VeryLazy",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-vsnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "lukas-reineke/cmp-under-comparator",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require("plugins.config.cmp")
        end,
    },

    -- 注释
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        lazy = true,
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
    },

    -- 搜索
    { "Numkil/ag.nvim",        lazy = false },

    -- 跳转
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        vscode = true,
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
        config = function()
            require("plugins.config.flash")
        end,
    },

    -- TODO: list
    -- Finds and lists all of the TODO, HACK, BUG, etc comment
    -- in your project and loads them into a browsable list.
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "VeryLazy",
        config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            -- { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
            { "<leader>tt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            -- { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
            { "<leader>tl", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
    },
    -- better diagnostics list and others
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
            {
                "[q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").previous({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Previous trouble/quickfix item",
            },
            {
                "]q",
                function()
                    if require("trouble").is_open() then
                        require("trouble").next({ skip_groups = true, jump = true })
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = "Next trouble/quickfix item",
            },
        },
    },

    -- Automatically highlights other instances of the word under your cursor.
    -- This works with LSP, Treesitter, and regexp matching to find the other
    -- instances.
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set("n", key, function()
                    require("illuminate")["goto_" .. dir .. "_reference"](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
            end

            map("]]", "next")
            map("[[", "prev")

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map("]]", "next", buffer)
                    map("[[", "prev", buffer)
                end,
            })
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },

    -- 按键提醒
    -- I have a separate config.mappings file where I require which-key.
    -- With lazy the plugin will be automatically loaded when it is required somewhere
    -- { "folke/which-key.nvim", lazy = true },

    -- which-key helps you remember key bindings by showing a popup
    -- with the active keybindings of the command you started typing.
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = { spelling = true },
            defaults = {
                mode = { "n", "v" },
                ["g"] = { name = "+goto" },
                ["gs"] = { name = "+surround" },
                ["]"] = { name = "+next" },
                ["["] = { name = "+prev" },
                ["<leader><tab>"] = { name = "+tabs" },
                ["<leader>b"] = { name = "+buffer" },
                ["<leader>c"] = { name = "+code" },
                ["<leader>f"] = { name = "+file/find" },
                ["<leader>g"] = { name = "+git" },
                ["<leader>gh"] = { name = "+hunks" },
                ["<leader>q"] = { name = "+quit/session" },
                ["<leader>s"] = { name = "+search" },
                ["<leader>u"] = { name = "+ui" },
                ["<leader>w"] = { name = "+windows" },
                ["<leader>x"] = { name = "+diagnostics/quickfix" },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.register(opts.defaults)
        end,
    },

    -- git signs highlights text that has changed since the list
    -- git commit, and also lets you interactively stage & unstage
    -- hunks in a commit.
    -- git stuff
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                        vim.schedule(function()
                            require("lazy").load({ plugins = { "gitsigns.nvim" } })
                        end)
                    end
                end,
            })
        end,
        -- opts = function()
        --   return require("plugins.configs.others").gitsigns
        -- end,
        -- config = function(_, opts)
        --   dofile(vim.g.base46_cache .. "git")
        --   require("gitsigns").setup(opts)
        -- end,
        config = function()
            -- dofile(vim.g.base46_cache .. "git")
            require("plugins/config.gitsign")
        end,
    },

    -- Flash Telescope config
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        cmd = "Telescope",
        -- event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "tom-anders/telescope-vim-bookmarks.nvim",
            "nvim-telescope/telescope-media-files.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-project.nvim",
        },
        config = function()
            require("plugins/config/telescope")
        end,
    },

    -- bufferline
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        version = "*",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function(_, opts)
            require("bufferline").setup(opts)
        end,
    },

    -- Treesitter is a new parser generator tool that we can
    -- use in Neovim to power faster and more accurate
    -- syntax highlighting.
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        build = ":TSUpdate",
        -- event = { "LazyFile", "VeryLazy" },
        event = { "VeryLazy" },
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            -- require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                config = function()
                    -- When in diff mode, we want to use the default
                    -- vim text objects c & C instead of the treesitter ones.
                    local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
                    local configs = require("nvim-treesitter.configs")
                    for name, fn in pairs(move) do
                        if name:find("goto") == 1 then
                            move[name] = function(q, ...)
                                if vim.wo.diff then
                                    local config = configs.get_module("textobjects.move")
                                    [name] ---@type table<string,string>
                                    for key, query in pairs(config or {}) do
                                        if q == query and key:find("[%]%[][cC]") then
                                            vim.cmd("normal! " .. key)
                                            return
                                        end
                                    end
                                end
                                return fn(q, ...)
                            end
                        end
                    end
                end,
            },
        },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Decrement selection", mode = "x" },
        },
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash",
                "go",
                "c",
                "diff",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "toml",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- Show context of the current function
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        enabled = true,
        opts = { mode = "cursor", max_lines = 3 },
        -- keys = {
        --     {
        --         "<leader>ut",
        --         function()
        --             local Util = require("lazyvim.util")
        --             local tsc = require("treesitter-context")
        --             tsc.toggle()
        --             if Util.inject.get_upvalue(tsc.toggle, "enabled") then
        --                 Util.info("Enabled Treesitter Context", { title = "Option" })
        --             else
        --                 Util.warn("Disabled Treesitter Context", { title = "Option" })
        --             end
        --         end,
        --         desc = "Toggle Treesitter Context",
        --     },
        -- },
    },

    -- Automatically add closing tags for HTML and JSX
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        opts = {},
    },

    -- cmdline tools and lsp servers
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
                -- "flake8",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    -- {
    --     "folke/neodev.nvim",
    --     lazy = false,
    --     event = "VeryLazy",
    --     config = function()
    --         require("neodev").setup({
    --             -- add any options here, or leave empty to use the default settings
    --             --     require("neodev").setup {
    --             -- Always add neovim plugins into lua_ls library, even if not neovim config
    --             override = function(root_dir, library)
    --                 library.enabled = true
    --                 library.plugins = true
    --             end,
    --             -- }
    --         })
    --     end,
    -- },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
            { "folke/neodev.nvim",  opts = {} },
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "nvimtools/none-ls.nvim",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
        config = function()
            require("plugins.config.lspconfig")
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        lazy = false,
        config = function()
            require("plugins.config.lsp_signature")
        end,
    },
    -- TODO: go的工具集,需要探索
    {
        "ray-x/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    -- 函数列表
    {
        "simrat39/symbols-outline.nvim",
        keys = { { "<leader>l", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
        cmd = "SymbolsOutline",
        config = function()
            require("plugins/config/symbols-outline")
        end,
    },

    -- indent guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
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
        main = "ibl",
    },

    -- Active indent guide and indent text objects. When you're browsing
    -- code, this highlights the current level of indentation, and animates
    -- the highlighting.
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "VeryLazy",
        opts = {
            -- symbol = "▏",
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
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
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        enabled = true,
        init = false,
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local logo = [[
                         trt
                          tiit
                            cst             ttrrrt
                   t        iactttttttrricsaaaasciirt  tt
                 tt      triaacrricsaaaaaaaaaaasscciiiri  rtr
             ttttitttttriicaaaaaaaaaaaaaaaaaaait    trr  rssc
         ttrrrrriscsaaaaaaaaaaaaaaaaaaaaaaaaaaascccscrrisaaai
                rssaaaaaaaaaaaasaaaaassaaaaaaaaaaaaaaaaaaaast
    t         trcaaaaaaaaaaaaaaaasaaaassaaaaaaaaaaaaaaaaaast
    rciiiiiicsaaaaaaaasaaaaaaaaaaassaaasaaaaaaaaaaaaaaaaaacccciit
    rsaaaaaassssssssssaaaaaaaassaaaassasaaaaaaaaaaaaaaaaaaaaaaasit
     tisaaaaaaaaaaaaaaaaaaaaaarrsaaaaaacssaaaaaaaaaaaaaaaaaaaaaaasi
       rcaaaaaaaaaaaaaaaaaaaasttcaaaaasaaasssaaaaaaaaaaaaaascirrt
     rsaaaaaaaaaaaaaaaasaaaaai  rcaaasaaaaaaaaacaaaaaaaaacrrrrt
   tcciriaaaaaaaaaaaaasaaassc   rraaaaaaaaaaaastcaaaaaaaactttt
   t    iaaaaaaaaaaaaasaasti     icaaaaaaaaaaar tsaaaaaaasr  tt
        iaaaaaaaaaaaaassi tttt   tcaaaaaaaaaastt tcaaaaaaait
        rsaaaaaaaaaaaast  ttrrrrrrtcaacsaaaaasrttttaaaaaaaascit
         iiaaaaaaaaaaaattriirrrrtt  cacsirccsascciisaaassirt
           tisaaaaaaassc        tt triit     ttt ttcsacrt
             rcirttisc tt          t                cir
             itttrir r  ttt                      tttir
             trt ttttt tt              tt          rit
               trrrtt  ttt                      trrt
                   ttttttrrrrrt          tttrrrrt
                             rct    trrrrrt
         ]]

            dashboard.section.header.val = vim.split(logo, "\n")
            -- stylua: ignore
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
                dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
                dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
                dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
                dashboard.button("c", " " .. " Config",
                    "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
                dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
                dashboard.button("x", " " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
                dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
                dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 1
            return dashboard
        end,
        config = function(_, dashboard)
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    once = true,
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded "
                        .. stats.loaded
                        .. "/"
                        .. stats.count
                        .. " plugins in "
                        .. ms
                        .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            require("plugins.config.todocomments")
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        lazy = false,
        version = "*",
        config = function()
            require("plugins.config.toggleterm")
        end,
    },
    -- code-action
    {
        "kosayoda/nvim-lightbulb",
        lazy = false,
        config = function()
            require("plugins.config.lightbulb")
        end,
    },
    -- 查看函数调用链
    {
        "ldelossa/litee.nvim",
        lazy = false,
        config = function()
            require("litee.lib").setup({
                tree = {
                    icon_set = "codicons",
                },
                panel = {
                    orientation = "right",
                    panel_size = 30,
                },
            })
        end,
    },
    {
        "ldelossa/litee-calltree.nvim",
        lazy = false,
        config = function()
            require("plugins.config.litee")
        end,
    },
    -- 搜索替换插件
    {
        "nvim-pack/nvim-spectre",
        lazy = false,
        config = function()
            require("plugins.config.spectre")
        end,
    },

    {
        "chentoast/marks.nvim",
        lazy = false,
        config = function()
            require("marks").setup({
                default_mappings = true,
                -- which builtin marks to show. default {}
                -- builtin_marks = { ".", "<", ">", "^" },
                -- whether movements cycle back to the beginning/end of buffer. default true
                cyclic = true,
                -- whether the shada file is updated after modifying uppercase marks. default false
                force_write_shada = false,
                -- how often (in ms) to redraw signs/recompute mark positions.
                -- higher values will have better performance but may cause visual lag,
                -- while lower values may cause performance penalties. default 150.
                refresh_interval = 250,
                -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
                -- marks, and bookmarks.
                -- can be either a table with all/none of the keys, or a single number, in which case
                -- the priority applies to all marks.
                -- default 10.
                sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
                -- disables mark tracking for specific filetypes. default {}
                excluded_filetypes = {},
                -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
                -- sign/virttext. Bookmarks can be used to group together positions and quickly move
                -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
                -- default virt_text is "".
                bookmark_0 = {
                    sign = "⚑",
                    virt_text = "hello world",
                    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
                    -- defaults to false.
                    annotate = false,
                },
                mappings = {},
            })
        end,
    },
    {
        "folke/trouble.nvim",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "ahmedkhalf/project.nvim",
        lazy = false,
        config = function()
            require("plugins.config.project")
        end,
    },

    {
        -- "jose-elias-alvarez/null-ls.nvim",
        "nvimtools/none-ls.nvim",
        lazy = false,
        config = function()
            require("plugins.config.null-ls")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        optional = true,
        lazy = false,
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    vim.list_extend(opts.ensure_installed, { "gomodifytags", "impl" })
                end,
            },
        },
        opts = function(_, opts)
            local nls = require("null-ls")
            opts.sources = vim.list_extend(opts.sources or {}, {
                nls.builtins.code_actions.gomodifytags,
                nls.builtins.code_actions.impl,
                nls.builtins.formatting.goimports,
                nls.builtins.formatting.gofumpt,
            })
        end,
    },

    -- 翻译软件
    {
        "JuanZoran/Trans.nvim",
        build = function()
            require("Trans").install()
        end,
        keys = {
            -- 可以换成其他你想映射的键
            { "<leader>tp", mode = { "n", "x" }, "<Cmd>Translate<CR>", desc = "󰏘 Translate" },
            -- { "<leader>tp", mode = { "n", "x" }, "<Cmd>TransPlay<CR>", desc = " Auto Play" },
            -- 目前这个功能的视窗还没有做好，可以在配置里将view.i改成hover
            { "<leader>ti", "<Cmd>TranslateInput<CR>", desc = " Translate From Input" },
        },
        dependencies = { "kkharji/sqlite.lua" },
        opts = {
            -- your configuration there
            --     frontend = {
            ---@type table frontend options
            frontend = {
                ---@class TransFrontendOpts
                ---@field keymaps table<string, string>
                default = {
                    query = "fallback",
                    border = "rounded",
                    title = vim.fn.has("nvim-0.9") == 1 and {
                        { "", "TransTitleRound" },
                        { " Trans", "TransTitle" },
                        { "", "TransTitleRound" },
                    } or nil, -- need nvim-0.9+
                    auto_play = true,
                    ---@type {open: string | boolean, close: string | boolean, interval: integer} Hover Window Animation
                    animation = {
                        open = "slid", -- 'fold', 'slid'
                        close = "slid",
                        interval = 12,
                    },
                    timeout = 2000,
                },
                ---@class TransHoverOpts : TransFrontendOpts
                hover = {
                    ---@type integer Max Width of Hover Window
                    width = 40,
                    ---@type integer Max Height of Hover Window
                    height = 27,
                    ---@type string -- see: /lua/Trans/style/spinner
                    spinner = "dots",
                    ---@type string
                    fallback_message = "{{notfound}} 翻译超时或没有找到相关的翻译",
                    auto_resize = true,
                    split_width = 60,
                    padding = 10, -- padding for hover window width
                    keymaps = {
                        pageup = "[[",
                        pagedown = "]]",
                        pin = "<leader>[",
                        close = "<leader>]",
                        toggle_entry = "<leader>;",
                        -- play         = '_', -- Deprecated
                    },
                    ---@type string[] auto close events
                    auto_close_events = {
                        "InsertEnter",
                        "CursorMoved",
                        "BufLeave",
                    },
                    ---@type table<string, string[]> order to display translate result
                    order = {
                        default = {
                            "str",
                            "translation",
                            "definition",
                        },
                        offline = {
                            "title",
                            -- "tag",
                            -- "pos",
                            -- "exchange",
                            "translation",
                            "definition",
                        },
                        youdao = {
                            "title",
                            "translation",
                            "definition",
                            "web",
                        },
                    },
                    icon = {
                        -- or use emoji
                        list = "●", -- ● | ○ | ◉ | ◯ | ◇ | ◆ | ▪ | ▫ | ⬤ | 🟢 | 🟡 | 🟣 | 🟤 | 🟠| 🟦 | 🟨 | 🟧 | 🟥 | 🟪 | 🟫 | 🟩 | 🟦
                        star = "", -- ⭐ | ✴ | ✳ | ✲ | ✱ | ✰ | ★ | ☆ | 🌟 | 🌠 | 🌙 | 🌛 | 🌜 | 🌟 | 🌠 | 🌌 | 🌙 |
                        notfound = " ", --❔ | ❓ | ❗ | ❕|
                        yes = "✔", -- ✅ | ✔️ | ☑
                        no = "", -- ❌ | ❎ | ✖ | ✘ | ✗ |
                        cell = "■", -- ■  | □ | ▇ | ▏ ▎ ▍ ▌ ▋ ▊ ▉
                        web = "󰖟", --🌍 | 🌎 | 🌏 | 🌐 |
                        tag = "",
                        pos = "",
                        exchange = "",
                        definition = "󰗊",
                        translation = "󰊿",
                    },
                },
            },
        },
    },
    {
        "Exafunction/codeium.vim",
        event = "BufEnter",
    },
}
