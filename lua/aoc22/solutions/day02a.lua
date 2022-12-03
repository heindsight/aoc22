-- Predict the total score obtained by following a Rock-Paper-Scissors strategy

local buffer_utils = require("aoc22.lib.buffer_utils")
local day02 = require("aoc22.lib.day02")

local P = {}

local shape_decoder = {
    A = "rock",
    B = "paper",
    C = "scissors",
    X = "rock",
    Y = "paper",
    Z = "scissors",
}

-- Get the oucome of one round of rock-paper-scissors
--
-- Params:
--  oponent: A string describing the shape played by the oponent
--  you:     A string describing the shape you played.
local function get_outcome(oponent, you)
    if you == oponent then
        return "draw"
    end

    local outcomes = {
        rock = { paper = "win", scissors = "lose" },
        scissors = { rock = "win", paper = "lose" },
        paper = { scissors = "win", rock = "lose" },
    }

    return outcomes[oponent][you]
end

-- Get details of one round of rock-paper-scissors.
--
-- Returns the shape you played and the outcome.
--
-- Params:
--  description: A string describing the round: two space separated symbols
--               encoding the shapes played by the oponent and by you.
local function get_round_info(description)
    local oponent_symbol, your_symbol = day02.get_symbols(description)
    local oponent = shape_decoder[oponent_symbol]
    local you = shape_decoder[your_symbol]
    local outcome = get_outcome(oponent, you)
    return you, outcome
end

function P.solve(in_buffer)
    local score = day02.score_game(in_buffer, get_round_info)
    return buffer_utils.write_new_buffer({ score })
end

return P
