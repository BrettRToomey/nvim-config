vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<noop>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>r", function()
    -- TODO: just call our function not a command
    vim.cmd("wa")
    vim.cmd("Build")
end)

vim.keymap.set("n", "<C-j>", ":cnext<CR>")
vim.keymap.set("n", "<C-k>", ":cprev<CR>")

vim.keymap.set("n", "<leader>cs", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = row - 1
    vim.api.nvim_buf_set_lines(0, line, line, false,
    {
        "///////////////////////////////////////////////////////////////////////////////",
        "//~ brt: ",
        "",
    })

    local keys = vim.api.nvim_replace_termcodes("<Up><Up>A", true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
end)

vim.keymap.set("n", "<leader>cn", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = row - 1
    vim.api.nvim_buf_set_lines(0, line, line, false,
    {
        "//- brt: ",
        "",
    })

    local keys = vim.api.nvim_replace_termcodes("<Up><Up>A", true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
end)
