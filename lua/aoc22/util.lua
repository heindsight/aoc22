-- Helper functions

local P = {}

-- Assert that the given buffer is loaded
function P.assert_loaded(bufnr)
    assert(vim.api.nvim_buf_is_loaded(bufnr), "Cannot iterate over an unloaded buffer")
end

-- Buffer line iterator function.
-- Return the next line number and it's content (if there is one)
local function buf_next_line(buffer, lineno)
    P.assert_loaded(buffer)
    lineno = lineno + 1
    if lineno < vim.api.nvim_buf_line_count(buffer) then
        local lines = vim.api.nvim_buf_get_lines(buffer, lineno, lineno + 1, true)
        return lineno, lines[1]
    end
end

-- Iterate over all lines in the buffer
-- Yields pairs of line number (zero based) and content
function P.iter_lines(buffer)
    P.assert_loaded(buffer)
    return buf_next_line, buffer, -1
end

return P
