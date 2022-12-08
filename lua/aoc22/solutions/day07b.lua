-- Find a directory to delete to free up enough space to update

local buffer_utils = require("aoc22.lib.buffer_utils")
local list_utils = require("aoc22.lib.list_utils")

local day07 = require("aoc22.lib.day07")

local P = {}

local TOTAL_SPACE = 70000000
local REQUIRED_FREE = 30000000

function P.solve(in_buffer)
    local machine = day07.Machine()
    machine:interpret_commands(in_buffer)
    local root = machine:get_root_dir()
    local sizes = root:get_sizes()

    local remaining_free = TOTAL_SPACE - sizes[#sizes]
    local need_to_free = REQUIRED_FREE - remaining_free

    local big_enough = vim.tbl_filter(function(size) return size >= need_to_free end, sizes)
    local can_free = math.min(unpack(big_enough))

    return buffer_utils.write_new_buffer({ can_free })
end

return P

