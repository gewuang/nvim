local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- local builtin = require('telescope.builtin')
local pickers = require("plugins.user.telescopePickers")

-- Shorten function name
local map = vim.api.nvim_set_keymap
local keymap = vim.keymap.set

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

----------------------------------------
-- Normal --
----------------------------------------
-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("n", "<leader>e", ":Lex 30<cr>", opts)
-- map("n", "<C-q>", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<C-q>", "<C-W>c", opts)

-- Resize with arrows
map("n", "+", ":resize +2<CR>", opts)
map("n", "_", ":resize -2<CR>", opts)
map("n", "-", ":vertical resize -2<CR>", opts)
map("n", "=", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", ">", ":bnext<CR>", opts)
map("n", "<", ":bprevious<CR>", opts)
-- map("n", "<S-l>", ":bnext<CR>", opts)
-- map("n", "<S-h>", ":bprevious<CR>", opts)

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", opts)
map("n", "<A-k>", "<cmd>m .-2<cr>==", opts)

-- neo-tree
-- { "<leader>a", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
-- map("n", "<leader>a", function()
--     require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
-- end, opts)
-- 打开文件浏览
map("n", "<leader>a", ":NvimTreeToggle<CR>", opts)
-- 定位到当前文件: NvimTreeFindFile

-- vim.api.nvim_set_keymap('n', '<C-[>', '<C-t>', { noremap = true, silent = true })

-- noh
-- map("i", "<esc>", "<cmd>noh<cr>", { desc = "Escape and clear hlsearch" })
map("n", "<esc>", "<cmd>noh<cr>", { desc = "Escape and clear hlsearch" })

-- telescope
-- 打开函数列表
keymap("n", "<leader>F", function()
    pickers.prettyDocumentSymbols()
end, opts)
-- map(
--     "n",
--     "<leader>F",
--     "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
--     { desc = "Find Document Symbols" }
-- )

-- 打开缓冲区
keymap("n", "<leader>fb", function()
    pickers.prettyBuffersPicker()
end, opts)
-- keymap("n", "<leader>fb", require("telescope.builtin").buffers, opts)

-- 打开project
map("n", "<leader>fp", "<cmd> Telescope projects <CR>", opts)

-- 打开help
keymap("n", "<leader>fh", require("telescope.builtin").help_tags, opts)

-- 打开workspace?
keymap("n", "<leader>fs", function()
    pickers.prettyWorkspaceSymbols()
end, opts)

-- 打开文件
-- map("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find file" })
keymap("n", "<C-p>", function()
    pickers.prettyFilesPicker({ picker = "find_files" })
end, opts)

-- 打开最近打开的文件
-- map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
keymap("n", "<leader>fr", function()
    pickers.prettyFilesPicker({ picker = "oldfiles" })
end, opts)

keymap("n", "<leader>fg", function()
    pickers.prettyFilesPicker({ picker = "git_files" })
end, opts)

-- 搜索
-- map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Project grep" })
keymap("n", "<leader>fw", function()
    pickers.prettyGrepPicker({ picker = "live_grep" })
end, opts)

keymap("n", "<leader>fq", function()
    pickers.prettyGrepPicker({ picker = "grep_string" })
end, opts)

-- 文件
map("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", { desc = "File browser" })

-- 缓冲区
-- map("n", "bu", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
keymap("n", "bu", function()
    pickers.prettyBuffersPicker()
end, opts)

keymap("n", "ag", function()
    require("telescope.builtin").grep_string({ word_match = "-w" })
end, opts)
keymap("v", "ag", function()
    vim.cmd.normal('"fy')
    require("telescope.builtin").grep_string({ search = vim.fn.getreg('"f') })
end, opts)

map("n", "cc", "<cmd>botright copen<cr>", { desc = "Quickfix List" })
map("n", "cl", "<cmd>cclose<cr>", { desc = "Quickfix List" })

-- 格式化
map("n", "<leader>ff", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format" })

map("n", "<leader>in", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", { desc = "list calls" })

-- go.nvim
map("n", "<leader>gm", "<cmd>GoCmt<cr>", { desc = "comment" })
map("n", "<leader>gfs", "<cmd>GoFillStruct<cr>", { desc = "go fill struct" })
map("n", "<leader>ge", "<cmd>GoIfErr<cr>", { desc = "if err" })
map("n", "<leader>gr", "<cmd>GoRename<cr>", { desc = "rename" })

keymap("n", "<leader>L", function()
    require("spectre").open()
end, { desc = "Open Spectre" })

keymap("n", "<leader>w", function()
    require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })

keymap("n", "<leader>lp", function()
    require("spectre").open_file_search({ select_word = true })
end, { desc = "Search on current file" })

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
keymap("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
keymap("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
keymap("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
keymap("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
keymap("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- 关闭语法检查
local enable = false
keymap("n", "<leader>ud", function()
    enable = not enable
    if enable then
        vim.diagnostic.disable()
        print("Disabled code diagnostics")
    else
        vim.diagnostic.enable()
        print("Enabled code diagnostics")
    end
end, { desc = "Hidden diagnostic" })

------ mark
-- mx              Set mark x
-- m,              Set the next available alphabetical (lowercase) mark
-- m;              Toggle the next available mark at the current line
-- dmx             Delete mark x
-- dm-             Delete all marks on the current line
-- dm<space>       Delete all marks in the current buffer
-- m]              Move to next mark
-- m[              Move to previous mark
-- m:              Preview mark. This will prompt you for a specific mark to
--                 preview; press <cr> to preview the next mark.
--
-- m[0-9]          Add a bookmark from bookmark group[0-9].
-- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
-- m}              Move to the next bookmark having the same type as the bookmark under
--                 the cursor. Works across buffers.
-- m{              Move to the previous bookmark having the same type as the bookmark under
--                 the cursor. Works across buffers.
-- dm=             Delete the bookmark under the cursor.
----------------------------------------
-- Insert --
----------------------------------------
-- Press jk fast to enter
-- map("i", "jk", "<ESC>", opts)
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-l>", "<Right>", opts)

-- Move Lines
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", opts)
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", opts)

----------------------------------------
-- Visual --
----------------------------------------
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- 设置p重复粘贴不被替换
map("v", "p", '"_dP', opts)

-- 设置Y复制到粘贴板
map("v", "Y", '"+y', { desc = "Copy to clipboard" })

-- Move Lines
-- map("v", "<A-j>", ":m .+1<CR>==", opts)
-- map("v", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<cr>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<cr>gv=gv", opts)

----------------------------------------
-- Visual Block --
----------------------------------------
-- Move text up and down
-- map("x", "J", ":move '>+1<CR>gv-gv", opts)
-- map("x", "K", ":move '<-2<CR>gv-gv", opts)
-- map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

----------------------------------------
-- Terminal --
----------------------------------------
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
