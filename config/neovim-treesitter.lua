-- Neovim Treesitter Configuration
-- Enables AST-based syntax highlighting, incremental selection, and indentation.

local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then return end

treesitter.setup({
    ensure_installed = {
        'c', 'cpp', 'rust', 'lua', 'bash', 'python',
        'typescript', 'javascript', 'html', 'css', 'json', 'markdown'
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            scope_incremental = '<TAB>',
            node_decremental = '<BS>',
        },
    },
})
