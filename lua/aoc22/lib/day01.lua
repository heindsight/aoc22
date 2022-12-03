-- Common helpers for Day 1

local buffer_utils = require("aoc22.lib.buffer_utils")
local list_utils = require("aoc22.lib.list_utils")

local P = {}

-- Insert a new value into a sorted list without growing the list beyond
-- `max_length` items.
--
-- Params:
--  list:       The list-like table to insert into.
--  value:      The value to insert.
--  max_length: The maximum length the list is allowed to have.
local function insert_sorted_and_truncate(list, value, max_length)
    list_utils.insert_sorted(list, value)
    while #list > max_length do
        table.remove(list)
    end
end

-- Get the total calories for the elves with the most calories
--
-- Params:
--  buffer:     A buffer handle. The buffer should contain snack calorie counts.
--              One number (representing calories for one snack) per line, with blank
--              lines separating each elf's snacks from the next.
--  num_elves:  Get the calories for this many elves.
function P.get_max_elves_calories(buffer, num_elves)
    local current_elf_calories = 0
    local max_calories = {}

    for _, line in buffer_utils.iter_lines(buffer) do
        local calories = tonumber(line)

        if calories then
            current_elf_calories = current_elf_calories + calories
        else
            insert_sorted_and_truncate(max_calories, current_elf_calories, num_elves)
            current_elf_calories = 0
        end
    end

    -- If the last line was not empty, we need still need to insert the last elf's calories
    if current_elf_calories ~= 0 then
        insert_sorted_and_truncate(max_calories, current_elf_calories, num_elves)
    end

    return list_utils.sum(max_calories)
end

return P
