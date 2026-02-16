return {
    'mg979/vim-visual-multi',
    branch = 'master',
    lazy = false, -- Disable lazy loading for this plugin
    init = function()
        -- Setting this here often prevents the E715 error
        vim.g.VM_maps = {
            ['Find Under']         = '<C-n>',
            ['Find Subword Under'] = '<C-n>',
        }
    end,
}
