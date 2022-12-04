-- Find for how many pairs of elves the assigned ranges of sections overlap

local buffer_utils = require("aoc22.lib.buffer_utils")

local day04 = require("aoc22.lib.day04")

local P = {}

function P.solve(in_buffer)
    local num_overlaps = 0

    for _, line in buffer_utils.iter_lines(in_buffer, { skip_blank = true }) do
        local elf1, elf2 = day04.get_assignments(line)
        if elf1:intersects(elf2) then
            num_overlaps = num_overlaps + 1
        end
    end
    return buffer_utils.write_new_buffer({ num_overlaps })
end

return P

