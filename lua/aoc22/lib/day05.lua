-- Common helpers for day 5

local buffer_utils = require("aoc22.lib.buffer_utils")

local P = {}

-- Pattern to match crates in the stack diagram.
local CRATE_PATTERN = "%[(%a)%]()"

-- Parse the crates from a line of the stack diagram.
--
-- Params:
--  line: A line from the stack diagram
local function get_crates(line)
    local crates = {}
    -- We iterate over the matches of `CRATE_PATTERN` in the line
    -- capturing the crate identifier and the position of the character
    -- after the ']' (i.e. the space sparating one stack form the next.
    -- A crate takes up 3 characers, so the separating space lands on the
    -- 4th character. Thus dividing the captured position by 4 gives the
    -- (1 based) index of the stack.
    for crate, pos in line:gmatch(CRATE_PATTERN) do
        crates[pos / 4] = crate
    end

    return crates
end

-- Parse the instruction from the crate description
--
-- Return the amount of crates to move and the stack indexes to move from and to
--
-- Params:
--  instruction: The instruction to parse
local function parse_instruction(instruction)
    return unpack(
        vim.tbl_map(
            tonumber,
            { instruction:match("move (%d+) from (%d+) to (%d+)") }
        )
    )
end

-- Read the stack diagram from the input buffer
--
-- Returns a list of the stacks and the line number in the buffer where
-- the crate moving instructions start.
--
-- Params:
--  in_buffer: Handle of the input buffer
function P.read_stacks(in_buffer)
    local crates = {}
    local stacks = vim.defaulttable(function() return {} end)
    local stack_nums = {}
    local last_diagram_lineno = 0

    -- Iterate until we reach a line that doesn't contain crates.
    for lineno, line in buffer_utils.iter_lines(in_buffer, {skip_blank = true}) do
        if line:match(CRATE_PATTERN) then
            -- Parse the crates from each line.
            table.insert(crates, get_crates(line))
        else
            -- The last line of the diagram contains the stack numbers.
            -- Record their positions (in case the stacks are not actually
            -- guaranteed to be in ascending numeric order).
            stack_nums = vim.split(line, " +", { trimempty = true })
            last_diagram_lineno = lineno
            break
        end
    end

    -- After reading the lines from the buffer, `crates` will contain a sequence
    -- of the rows in the stacks, with the bottom row last. Iterating over these
    -- from last to first and pushing onto the stacks, will reconstruct the stacks.
    while #crates > 0 do
        local row = table.remove(crates)
        for i, stack in ipairs(stack_nums) do
            table.insert(stacks[tonumber(stack)], row[i])
        end
    end

    -- Remove the metatable from `stacks` (turning the 'defaulttable' into  a regular table)
    setmetatable(stacks, nil)

    return stacks, last_diagram_lineno + 1
end

-- Carry out instructions to move crates.
--
-- Returns a string naming the crates at the tops of the stacks after
-- carrying out al the instructions.
--
-- Params:
--  in_buffer:          Handle of the input buffer to read instructions from.
--  stacks:             The  stacks of crates to operate on.
--  instructions_start: Start reading instructions from this line in the buffer.
--  do_instruction:     The function to call to carry out an individual instruction.
function P.move_crates(in_buffer, stacks, instructions_start, do_instruction)
    for _, instruction in buffer_utils.iter_lines(in_buffer, { skip_blank = true, start_from = instructions_start }) do
        local amount, from, to = parse_instruction(instruction)
        do_instruction(stacks, amount, from, to)
    end

    local top_crates = vim.tbl_map(function(stack) return stack[#stack] end, stacks)
    return table.concat(top_crates)
end

return P
