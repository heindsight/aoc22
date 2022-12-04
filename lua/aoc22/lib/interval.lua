-- A prototype for interval objects

local Interval = {}

-- Check whether an interval contains a given number or other interval
--
-- Params:
--  other: The number or other interval.
function Interval:contains(other)
    if type(other) == "number" then
        other = Interval:new{other, other}
    end
    return self.lower <= other.lower and self.upper >= other.upper
end

-- Check whether an interval intersects another
--
-- Params:
--  other: The other endpoint
function Interval:intersects(other)
    return self:contains(other) or other:contains(self.lower) or other:contains(self.upper)
end

-- Construct a new interval with the given endpoints
--
-- Params:
--  endpoits: The endpoints of the interval
function Interval:new(endpoints)
    local lower, upper = unpack(endpoints)

    if lower > upper then
        lower, upper = upper, lower
    end

    local interval = { lower = lower, upper = upper }
    setmetatable(interval, self)
    self.__index = self
    return interval
end

local P = {}

function P.Interval(endpoints)
    return Interval:new(endpoints)
end

return P
