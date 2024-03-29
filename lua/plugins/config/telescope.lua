local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            n = { s = flash },
            i = {
                ["<c-s>"] = flash,
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-c>"] = actions.close,
                ["<esc>"] = actions.close,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8
            },
            vertical = {
                mirror = false
            },
            width = 0.85,
            height = 0.80,
            preview_cutoff = 120
        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {
            "node_modules",
            ".git",
            "target",
            "vendor"
        },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
        end,
        winblend = 0,
        border = {},
        borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
        color_devicons = true,
        set_env = {["COLORTERM"] = "truecolor"},
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
    },
    pickers = {
        file_browser = {
            hidden = true
        },
        find_files = {
            hidden = true
        },
        live_grep = {
            hidden = true,
            only_sort_text = true
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = "smart_case"
        },
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg"
        },
        file_browser = {
            theme = "ivy"
        },
        bookmarks = {
            selected_browser = "brave",
            url_open_plugin = "open_browser"
        }
    }
}

require('telescope').load_extension "ui-select"
require('telescope').load_extension "file_browser"
-- require('telescope').load_extension "notify"
require('telescope').load_extension "project"
require('telescope').load_extension('fzf')
