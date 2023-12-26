local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- local builtin = require('telescope.builtin')

-- Shorten function name
local map = vim.api.nvim_set_keymap


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
map("n", "<leader>a", ":NvimTreeToggle<CR>", opts)

-- noh
-- map("i", "<esc>", "<cmd>noh<cr>", { desc = "Escape and clear hlsearch" })
map("n", "<esc>", "<cmd>noh<cr>", { desc = "Escape and clear hlsearch" })

-- telescope
-- map('n', '<leader>ff', builtin.find_files, opt) 
-- map('n', '<leader>fg', builtin.live_grep, opt) 
-- map('n', '<leader>fb', builtin.buffers, opt)
-- map('n', '<leader>fh', builtin.help_tags, opt)
map( "n", "<leader>F", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", { desc = "Find Document Symbols" })
map( "n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Find file" })
map( "n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map( "n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Project grep" })
map( "n", "<leader>fb", "<cmd>Telescope file_browser<CR>", { desc = "File browser" })
map( "n", "bu", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })

map( "n", "<leader>ff", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format" })

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
