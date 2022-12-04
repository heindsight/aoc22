-- Find for how many pairs of elves the assigned range of sections of one contains that of the other

local buffer_utils = require("aoc22.lib.buffer_utils")

local day04 = require("aoc22.lib.day04")

local P = {}

function P.solve(in_buffer)
    local num_contains = 0

    for _, line in buffer_utils.iter_lines(in_buffer, { skip_blank = true }) do
        local elf1, elf2 = day04.get_assignments(line)
        if elf1:contains(elf2) or elf2:contains(elf1) then
            num_contains = num_contains + 1
        end
    end
    return buffer_utils.write_new_buffer({ num_contains })
end

return P
