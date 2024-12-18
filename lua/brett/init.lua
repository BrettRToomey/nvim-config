require("brett.set")
require("brett.remap")
require("brett.packer")

P = function(t)
    print(vim.inspect(t))
    return t
end

local brett_namespace = vim.api.nvim_create_namespace("brett.build")
local last_build_params = {}
local last_debug_params = "xcdebug"

vim.api.nvim_create_user_command("Style", function(params)
    local size = tonumber(params.fargs[1]) or 2
    vim.cmd("set tabstop=" .. size .. " softtabstop=" .. size .. " shiftwidth=" .. size)
    print("Set indent size to " .. size)
end, {
    desc = "Set size of tabs",
    nargs = 1,
})

vim.api.nvim_create_user_command("Debug", function(params)
    local args = last_debug_params
    if #params.args > 0 then
        args = params.args
    end

    last_debug_params = args

    vim.cmd("!" .. args)
end, {
    desc = "Start debug session",
    nargs = "*",
    bang = true,
})

vim.api.nvim_create_user_command("Build", function(params)
    vim.api.nvim_buf_clear_namespace(0, brett_namespace, 0, -1)
    local args = last_build_params
    if #params.fargs > 0 then
        args = params.fargs
    end

    local cmd = { "./build.sh", unpack(args) }
    last_build_params = args

    local targets_string = "default"
    if #last_build_params > 0 then
      targets_string = table.concat(last_build_params, ", ")
    end

    print("Building " .. targets_string)
    local lines = {}

    vim.fn.jobstart(cmd, {
        stderr_buffered = true,

        on_stderr = function(_, data)
            for _, v in pairs(data) do
                table.insert(lines, v)
            end
        end,

        on_exit = function()
            local qf = vim.fn.getqflist({ lines = lines })
            local items = qf.items

            vim.fn.setqflist({}, " ", { title = "Build", items = items, })
            vim.cmd("cw 25")

            print("Done. (" .. targets_string .. ")")
        end
    })
end, {
    desc = "Build using project's ./bash.sh",
    nargs = "*",
    bang = true,
})
