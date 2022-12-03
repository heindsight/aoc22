-- Utility functions for operating on vim buffers

local P = {}

-- Assert that the given buffer is loaded
--
-- Params:
--  buffer: A buffer handle
function P.assert_loaded(buffer)
   assert(vim.api.nvim_buf_is_loaded(buffer), "Cannot operate on an unloaded buffer")
end

-- Buffer line iterator function.
-- Return the next line number and it's content (if there is one)
--
-- Params:
--  buffer: A buffer handle.
--  lineno: The current line number.
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
--
-- Params:
--  buffer: The handle of the buffer to iterate over
function P.iter_lines(buffer)
    P.assert_loaded(buffer)
    return buf_next_line, buffer, -1
end

-- Replace the content of a buffer with a new set of lines
--
-- Params:
--  buffer: The handle of the buffer to operate on.
--  lines:  A list of the new lines to replace the content of the buffer.
function P.replace_buffer_content(buffer, lines)
    vim.api.nvim_buf_set_lines(buffer, 0, -1, true, vim.tbl_map(tostring, lines))
end

return P
