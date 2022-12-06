-- Find the position of markers (sequences of unique characters) in a datastream

-- Count the unique characters in a sub-sequence of a stream
--
-- Params:
--  stream: The datastream to examine
--  pos:    Consider sequences ending in this position
--  n:      The maximum subsequence length we're interested in
local function count_unique(stream, pos, n)
    local seen = { [stream:byte(pos)] = true }

    for lookbehind = 1, n - 1 do
        local character = stream:byte(pos - lookbehind)
        if seen[character] then
            return lookbehind
        else
            seen[character] = true
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
        if unique == marker_length then
            return pos
        else
            pos = pos + marker_length - unique
        end
    end
    return -1
end

return P
