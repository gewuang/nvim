-- Setup language servers.
local lspconfig = require('lspconfig')
-- local win = require('lspconfig.ui.windows')
-- local _default_opts = win.default_opts
--
-- win.default_opts = function(options)
--   local opts = _default_opts(options)
--   opts.border = 'single'
--   return opts
-- end
require('lspconfig.ui.windows').default_options.border = 'single'

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.pyright.setup {
    capabilities = capabilities,
}
lspconfig.tsserver.setup {
    capabilities = capabilities,
}
lspconfig.rust_analyzer.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {},
    },
}

lspconfig.lua_ls.setup {
    -- mason = false, -- set to false if you don't want this server to be installed with mason
    -- Use this to add any additional keymaps
    -- for specific lsp servers
    ---@type LazyKeysSpec[]
    -- keys = {},
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim", "hs" },
            },
            workspace = {
                -- checkThirdParty = false,
                library = {
                    [vim.fn.expand("$PLUGINS/neodev.nvim/types/nightly")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
}

lspconfig.jsonls.setup {
    -- lazy-load schemastore when needed
    capabilities = capabilities,
    on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,
    settings = {
        json = {
            format = {
                enable = true,
            },
            validate = { enable = true },
        },
    },
}
lspconfig.yamlls.setup {
    capabilities = capabilities,
    yamlls = {
        settings = {
            yaml = {
                schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    ["../path/relative/to/file.yml"] = "/.github/workflows/*",
                    ["/path/from/root/of/project"] = "/.github/workflows/*",
                },
            },
        },
    },
}

lspconfig.bashls.setup {
    capabilities = capabilities,
    filetypes = { "sh" },
    -- on_attach = on_attach,
    cmd = { "bash-language-server", "start" },
    -- root_dir = util.find_git_ancestor,
    settings = {
        bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command)",
        },
    },
    single_file_support = true,
}


lspconfig.clangd.setup {
    cmd = {
        "clangd", -- NOTE: 只支持clangd 13.0.0 及其以下版本，新版本会有问题
        -- // 让 Clangd 生成更详细的日志
        "--log=verbose",
        -- // 输出的 JSON 文件更美观
        "--pretty",
        -- // 全局补全(输入时弹出的建议将会提供 CMakeLists.txt 里配置的所有文件中可能的符号，会自动补充头文件)
        "--all-scopes-completion",
        -- // 建议风格：打包(重载函数只会给出一个建议）
        -- // 相反可以设置为detailed
        "--completion-style=bundled",
        -- // 跨文件重命名变量
        "--cross-file-rename",
        -- // 允许补充头文件
        "--header-insertion=iwyu",
        -- // 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
        "--header-insertion-decorators",
        -- // 在后台自动分析文件(基于 complie_commands，我们用CMake生成)
        "--background-index", -- 后台建立索引，并持久化到disk
        "--clang-tidy",       -- 开启clang-tidy
        -- 指定clang-tidy的检查参数， 摘抄自cmu15445. 全部参数可参考 https://clang.llvm.org/extra/clang-tidy/checks
        "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,",
        "--completion-style=detailed",
        "--cross-file-rename=true",
        "--header-insertion=iwyu",
        "--pch-storage=memory",
        -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
        "--function-arg-placeholders=false",
        "--log=verbose",
        "--ranking-model=decision_forest",
        -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
        "--header-insertion-decorators",
        "-j=12",
        "--pretty",
    },
    capabilities = capabilities,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            fname
        ) or require("lspconfig.util").find_git_ancestor(fname)
    end,
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },

}

lspconfig.gopls.setup {
    -- on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
                unreachable = true,
            },
        },
        hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
        },
    },
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<CR>", opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<leader>cd', function()
        --     vim.diagnostic.open_float { border = "rounded" }
        -- end, opts)
        -- vim.keymap.set('n', '[d', function()
        --     vim.diagnostic.goto_prev { float = { border = "rounded" } }
        -- end, opts)
        -- vim.keymap.set('n', ']d', function()
        --     vim.diagnostic.goto_next { float = { border = "rounded" } }
        -- end, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
