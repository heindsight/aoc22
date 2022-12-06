-- Find the position of markers (sequences of unique characters) in a datastream

-- Count the unique characters in a sub-sequence of a stream
--
-- Params:
--  stream: The datastream to examine
--  pos:    Consider sequences ending in this position
--  n:      The maximum subsequence length we're interested in
local function count_unique(stream, pos, n)
    local seen = {}

    for lookbehind = 0, n do
        local character = stream:byte(pos - lookbehind)
        if vim.tbl_contains(seen, character) then
            return lookbehind
        else
            table.insert(seen, character)
        end
    end
    return n
end

local P = {}

-- Find a marker in a datastream
--
-- Returns the position of the last character in the marker, or -1 if no marker is found.
--
-- Params:
--  stream: A string representing the datastream
function P.find_marker(stream, marker_length)
    local pos = marker_length

    while pos <= #stream do
        local unique = count_unique(stream, pos, marker_length)
        if  unique == marker_length then
            return pos
        else
            pos = pos + marker_length - unique
        end
    end
    return -1
end

return P
