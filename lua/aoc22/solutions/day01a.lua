-- Find how many calories the elf with the most calories has

local util = require("aoc22.util")

local function get_max_elf_calories(buffer)
    local current_elf_calories = 0
    local max_elf_calories = -1

    for _, line in util.iter_lines(buffer) do
        if line ~= "" then
            local calories = tonumber(line)
            current_elf_calories = current_elf_calories + calories

            if current_elf_calories > max_elf_calories then
                max_elf_calories = current_elf_calories
            end
        else
            current_elf_calories = 0
        end
    end
    return max_elf_calories
end

local P = {}

function P.solve(in_buffer)
    local max_calories = get_max_elf_calories(in_buffer)

    local out_buffer = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_lines(out_buffer, -2, -1, true, { tostring(max_calories) })
    return out_buffer
end

return P
