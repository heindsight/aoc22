-- Find the common item in each group of 3 elves' backpacks

local buffer_utils = require("aoc22.lib.buffer_utils")
local day03 = require("aoc22.lib.day03")

local P = {}


function P.solve(in_buffer)
    local priority = 0
    local common
    local group_size = 3

    for elf_num, rucksack in buffer_utils.iter_lines(in_buffer, { skip_blank = true }) do
        if elf_num % group_size == 0 then
            common = rucksack
        else
            -- Get common characters by removing (substituting with "") all
            -- characters that do not match a character in `common`
            common = rucksack:gsub(string.format("[^%s]", common), "")
        end

        if (elf_num % group_size) == (-1 % group_size) then
            priority = priority + day03.get_priority(common)
        end
    end

    return buffer_utils.write_new_buffer({ priority })
end

return P
