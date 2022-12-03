-- Utility functions for operating on vim buffers

local P = {}

-- Assert that the given buffer is loaded
--
-- Params:
--  buffer: A buffer handle
function P.assert_loaded(buffer)
    assert(vim.api.nvim_buf_is_loaded(buffer), "Cannot operate on an unloaded buffer")
end

-- Iterate over all lines in the buffer
-- Yields pairs of line number (zero based) and content
--
-- Params:
--  buffer: The handle of the buffer to iterate over
--  opts:   Optional keyword arguments:
--          - skip_blank: if true, the iteration will skip over blank lines.
function P.iter_lines(buffer, opts)
    P.assert_loaded(buffer)

    opts = opts or {}
    local skip_blank = opts.skip_blank

    -- Buffer line iterator function.
    -- Return the next line number and it's content (if there is one)
    --
    -- Params:
    --  buff: A buffer handle.
    --  lineno: The current line number.
    local function buf_next_line(buff, lineno)
        P.assert_loaded(buff)

        lineno = lineno + 1

        if skip_blank then
            -- Get the next non-blank line.
            -- We need to add 1 to the lineno and subtract 1 from the result, because `nextnonblank` uses
            -- 1-based line numbers whereas `nvim_buf_get_lines` uses 0-based line numbers.
            lineno = vim.api.nvim_buf_call(buff, function() return vim.fn.nextnonblank(lineno + 1) end) - 1
        end

        if 0 <= lineno and lineno < vim.api.nvim_buf_line_count(buff) then
            local lines = vim.api.nvim_buf_get_lines(buff, lineno, lineno + 1, true)
            return lineno, lines[1]
        end
    end

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

-- Create a new buffer and write
function P.write_new_buffer(lines)
    local out_buffer = vim.api.nvim_create_buf(true, false)
    P.replace_buffer_content(out_buffer, lines)
    return out_buffer
end

return P
