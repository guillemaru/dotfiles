-- Collection of various small independent plugins/modules
return {
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        --  The rules are:
        --  v|y|c a|i [n] <symbol> (select/yanq/change around/inner [next] symbol)
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        -- The rules are:
        -- s a [i w|p] <symbol> (surround add [inner word/paragraph] symbol)
        -- s d <symbol> (surround delete symbol)
        -- s r <symbol><symbol> (surround replace symbol with symbol)
        require("mini.surround").setup()
    end,
}
