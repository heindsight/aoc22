-- Load the 'aoc22' package
local aoc22 = require("aoc22")

-- Create command to run AoC solutions
vim.api.nvim_create_user_command(
    "AoC22",
    aoc22.solve_puzzle,
    {
        desc = "Solve an AoC 2022 puzzle using current buffer as input",
        nargs = 1,
        complete = aoc22.complete_solutions,
    }
)

-- Create a command to reload the AoC solutions.
-- Mainly useful for development/debugging purposes.
vim.api.nvim_create_user_command(
    "AoC22Reload",
    function()
        local aoc22_loaded = vim.tbl_filter(
            function(pkg) return pkg.match("^aoc22.*") end,
            vim.tbl_keys(package.loaded)
        )
        for _, pkg in ipairs(aoc22_loaded) do
            package.loaded[pkg] = nil
        end
        aoc22 = require("aoc22")
    end,
    { desc = "Reload the AoC22 lua package" }
)
