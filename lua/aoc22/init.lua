-- Get path to the script where the calling function is defined
local function script_path()
    -- The first argument '2' to `debug.getinfo` specifies
    -- that we're interested in information about the 2nd function in the call stack.
    -- That is the caller of this function.
    local debuginfo = debug.getinfo(2, "S")
    return debuginfo.source:match("@(.*)")
end

local P = {}

-- Argument completion for puzzle solutions
function P.complete_solutions(arg)
    local soln_dir = vim.fs.dirname(script_path()) .. "/solutions/"
    local available_solutions = vim.fn.glob(soln_dir .. arg .. "*.lua", true, true)
    return vim.tbl_map(
        function(name) return vim.fs.basename(name):match("(.*).lua") end,
        available_solutions
    )
end

-- Load a solution and run it on the current buffer. Open the output buffer in a new window.
function P.solve_puzzle(opts)
    local solution = require("aoc22.solutions." .. opts.args)
    local in_buffer = vim.api.nvim_get_current_buf()
    local out_buffer = solution.solve(in_buffer)
    vim.cmd.sbuffer(out_buffer)
end

return P
