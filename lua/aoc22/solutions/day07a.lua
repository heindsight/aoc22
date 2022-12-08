-- Find directories with total size at most 100000

local buffer_utils = require("aoc22.lib.buffer_utils")
local list_utils = require("aoc22.lib.list_utils")

local day07 = require("aoc22.lib.day07")

local P = {}

local SIZE_LIMIT = 100000

function P.solve(in_buffer)

    local machine = day07.Machine()
    machine:interpret_commands(in_buffer)
    local root = machine:get_root_dir()
    local sizes = root:get_sizes()

    local small_sizes = list_utils.sum_if(sizes, function(size) return size <= SIZE_LIMIT end)

    return buffer_utils.write_new_buffer({ small_sizes })
end

return P
