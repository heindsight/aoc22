-- Utility functions for operating on lists of values

local P = {}

-- Insert a value in a sorted list, keeping the list sorted.
--
-- Params:
--  list:      A list-like table to insert into.
--  new_value: The value to insert into the list.
function P.insert_sorted(list, new_value)
    for i, value in ipairs(list) do
        if value < new_value then
            table.insert(list, i, new_value)
            return
        end
    end
    table.insert(list, new_value)
end

-- Sum a list of numbers
--
-- Params:
--  list: A list-like table to sum up.
function P.sum(list)
    return vim.fn.reduce(list, function(val_a, val_b) return val_a + val_b end, 0)
end

-- Sum a list of numbers that satisfy a predicate
--
-- Params:
--  list: A list-like table to sum up.
function P.sum_if(list, predicate)
    return vim.fn.reduce(
        list,
        function(acc, val)
            if predicate(val) then
                return acc + val
            else
                return acc
            end
        end,
        0
    )
end

return P
