-- Which crates will be at the top of the stacks after the given sequence of moves
-- Crates must be moved one at a time.

local buffer_utils = require("aoc22.lib.buffer_utils")
local day05 = require("aoc22.lib.day05")

local P = {}

-- Carry out an instruction, moving the given amount of crates from one stack to another
--
-- Params:
--  stacks: The stacks to operate on.
--  amount: The amount of crates to move.
--  from:   The (1-based) stack index to move crates from.
--  to:     The (1-based) stack index  to move crates to.
local function do_instruction(stacks, amount, from, to)
    -- Move the crates one by one.
    for _ = 1, amount do
        local crate = table.remove(stacks[from])
        table.insert(stacks[to], crate)
    end
end

function P.solve(in_buffer)
    local stacks, instructions_start = day05.read_stacks(in_buffer)
    local tops = day05.move_crates(in_buffer, stacks, instructions_start, do_instruction)
    return buffer_utils.write_new_buffer({ tops })
end

return P
