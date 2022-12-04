-- Common helpers for day4

local interval = require("aoc22.lib.interval")

local P = {}

-- Construct an interval from a string of two endpoints separated by a dash
--
-- Params:
--  ival_str: The string representing the interval
local function interval_from_string(ival_str)
    return interval.Interval:new(
        unpack(vim.tbl_map(tonumber, vim.split(ival_str, "-")))
    )
end

-- Get the sections assigned to a pair of elves from an input line.
--
-- The elves' assignments are separated by a comma. Each elf's assignment
-- consists of a range with start and end section numbers separated by a dash.
--
-- Params:
--  line: A string describing the assignments
function P.get_assignments(line)
    local elves = vim.split(line, ",")
    return unpack(vim.tbl_map(interval_from_string, elves))
end

return P
