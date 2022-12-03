-- Common helpers for day3

local P = {}

-- Get the priority of an item
--
-- Each item is described by a single letter identifying its type.
-- Types a..z have priorities 1..26, types A..Z have priorities 27..52
--
-- Params:
--  item: A (one-character) string identifying the item type.
function P.get_priority(item)
    local lower_offset = string.byte("a") - 1
    local upper_offset = string.byte("A") - 27

    if item:match("%l") then
        return item:byte() - lower_offset
    elseif item:match("%u") then
        return item:byte() - upper_offset
    end
    error(string.format("Expected a letter, got %s", item))
end

return P
