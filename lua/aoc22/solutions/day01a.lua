-- Find how many calories the elf with the most calories has

local buffer_utils = require("aoc22.lib.buffer_utils")
local day01 = require("aoc22.lib.day01")


local P = {}

function P.solve(in_buffer)
    local max_calories = day01.get_max_elves_calories(in_buffer, 1)
    return buffer_utils.write_new_buffer({ max_calories })
end

return P
