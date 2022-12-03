-- Find how many calories the 3 elves with the most calories have

local buffer_utils = require("aoc22.lib.buffer_utils")
local day01 = require("aoc22.lib.day01")


local P = {}

function P.solve(in_buffer)
    local max_calories = day01.get_max_elves_calories(in_buffer, 3)

    local out_buffer = vim.api.nvim_create_buf(true, false)
    buffer_utils.replace_buffer_content(out_buffer, { max_calories })
    return out_buffer
end

return P

