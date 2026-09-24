-- Neovim LSP Diagnostic UI Configuration
-- Configures virtual text, float window borders, and diagnostic severity icons.

vim.diagnostic.config({
    virtual_text = {
        prefix = '■',
        spacing = 4,
        severity = { min = vim.diagnostic.severity.WARN },
    },
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
