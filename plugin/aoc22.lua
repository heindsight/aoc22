-- Load the 'aoc22' package
local aoc22 = require("aoc22")

-- Create command to run AOC solutions
vim.api.nvim_create_user_command(
    "AoC22",
    aoc22.solve_puzzle,
    {
        desc = "Solve an AoC 2022 puzzle using current buffer as input",
        nargs = 1,
        complete = aoc22.complete_solutions,
    }
)
