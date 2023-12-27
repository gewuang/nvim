local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {
    formatting.prettier,
    formatting.stylua,
    formatting.shfmt,
    formatting.gofumpt,
    formatting.golines,
    formatting.goimports_reviser,

    -- lint.cfn-lint,
    lint.shellcheck,
}

local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
        })
        -- 自动格式化
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --         vim.lsp.buf.format { bufnr = bufnr }
        --     end,
        -- })
    end
end

null_ls.setup({
    debug = true,
    sources = sources,
    on_attach = on_attach,
})
