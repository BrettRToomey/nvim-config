require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', builtin.grep_string, {})
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>pp', function() 
    builtin.find_files(themes.get_dropdown {
        cwd = "~/Documents/projects",
        previewer = false,
        layout_config = { height = 25, },
        winblend = 10,
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()[1]
                local path = "~/Documents/projects/" .. selection
                vim.cmd.cd { args = { path }, }
                print("Changed directory to:", selection)
            end)
            return true
        end,
        find_command = { "fd", "-d", "1", },
    })
end, {})

vim.keymap.set('n', '<leader>/', function() 
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, {})


vim.keymap.set('n', '<leader>pn', function() 
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, {})
