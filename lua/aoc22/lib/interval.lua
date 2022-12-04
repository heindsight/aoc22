-- A prototype for interval objects

local P = {}

P.Interval = {}

-- Check whether an interval contains a given number or other interval
--
-- Params:
--  other: The number or other interval.
function P.Interval:contains(other)
    if type(other) == "number" then
        other = P.Interval:new(other, other)
    end
    return self.lower <= other.lower and self.upper >= other.upper
end

-- Check whether an interval intersects another
--
-- Params:
--  other: The other endpoint
function P.Interval:intersects(other)
    return self:contains(other) or other:contains(self.lower) or other:contains(self.upper)
end

-- Construct a new interval with the given endpoints
--
-- Params:
--  lower: The lower endpoint of the interval
--  upper: The upper endpoint of the interval
function P.Interval:new(lower, upper)
    if lower > upper then
        lower, upper = upper, lower
    end

    local interval = { lower = lower, upper = upper }
    setmetatable(interval, self)
    self.__index = self
    return interval
end

return P
