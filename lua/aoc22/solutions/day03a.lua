-- Find incorrectly packed items in rucksacks.

local buffer_utils = require("aoc22.lib.buffer_utils")
local day03 = require("aoc22.lib.day03")

local P = {}

-- Get the contents of each compartment of the rucksack
--
-- Each compartment is assumed to contain the same number of items
--
-- Params:
--  rucksack: A string encoding the content of the rucksack
local function get_compartment_contents(rucksack)
    return { rucksack:sub(1, #rucksack / 2), rucksack:sub(- #rucksack / 2) }
end

function P.solve(in_buffer)
    local priority = 0
    for _, rucksack in buffer_utils.iter_lines(in_buffer, { skip_blank = true }) do
        local compartments = get_compartment_contents(rucksack)
        local common = compartments[2]:match(string.format("[%s]", compartments[1]))
        priority = priority + day03.get_priority(common)
    end

    return buffer_utils.write_new_buffer({ priority })
end

return P
