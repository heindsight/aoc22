-- Find the position of the first start-of-message marker (sequence of 14 unique characters) in a datastream

local buffer_utils = require("aoc22.lib.buffer_utils")
local day06 = require("aoc22.lib.day06")

local P = {}


function P.solve(in_buffer)
    local datastream = buffer_utils.get_first_line(in_buffer)
    local packet_start = day06.find_marker(datastream, 14)
    return buffer_utils.write_new_buffer({ packet_start })
end

return P
