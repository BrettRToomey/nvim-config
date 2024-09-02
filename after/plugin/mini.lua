-- Better (and further looking) around/inside text objects
--
--  vin' - [V]isual select [I]nner [N]ext [']Quote
require('mini.ai').setup {
    n_lines = 500
}

-- Add/delete/replace surround (bracket, brace, paren)
--
--  saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--  sd'   - [S]urround [D]elete [']Quote
--  sr)'  - [S]urround [R]eplace [)]Paren [']Quote
require('mini.surround').setup()
