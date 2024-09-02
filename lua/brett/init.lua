require("brett.set")
require("brett.remap")
require("brett.packer")

P = function(t)
    print(vim.inspect(t))
    return t
end

local ns = "brett:build"

vim.api.nvim_create_user_command("Build", function(params)
    --vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local make_entry = require "telescope.make_entry"
    local conf = require("telescope.config").values

    local lines = {}

    -- TODO: params to build
    vim.fn.jobstart("./build.sh wispy asan", {
        stderr_buffered = true,

        on_stderr = function(_, data)
            for _, v in pairs(data) do
                table.insert(lines, v)
            end
        end,

        on_exit = function()
            -- TODO: set cwd so that the file paths are correct
            local items = vim.fn.getqflist({ lines = lines }).items

            --[[
            local errors = {}
            for _, v in ipairs(items) do
                if v.valid == 1 then table.insert(errors, v) end
            end
            ]]--

            -- ~brt: TODO: set diagnostics
            vim.fn.setqflist({}, " ", { title = "Build", items = items, })
            vim.cmd("cw")
            print("Done.")
                --[[
            if #errors > 0 then

                pickers.new({}, {
                    prompt_title = "Build Errors",
                    finder = finders.new_table {
                        results = errors,
                        entry_maker = make_entry.gen_from_quickfix({}),
                    },
                    previewer = conf.qflist_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()


            else
                print("hehehe")
            end
                ]]--

        end
    })
end, {
    desc = "Build using project's ./bash.sh",
    nargs = "*",
    bang = true,
})
