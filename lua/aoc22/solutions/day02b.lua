-- Predict the total score obtained by following a Rock-Paper-Scissors strategy

local buffer_utils = require("aoc22.lib.buffer_utils")
local day02 = require("aoc22.lib.day02")

local P = {}

local shape_decoder = {
    A = "rock",
    B = "paper",
    C = "scissors",
}

local outcome_decoder = {
    X = "lose",
    Y = "draw",
    Z = "win",
}

-- Get the shape you should play to get the desired outcome
-- in a round of rock-paper-scissors.
--
-- Params:
--  oponent: A string describing the shape played by the oponent.
--  outcome: A string describing the desired outcome of the round.
local function get_shape_to_play(oponent, outcome)
    if outcome == "draw" then
        return oponent
    end

    local should_play = {
        rock = { win = "paper", lose = "scissors" },
        paper = { win = "scissors", lose = "rock" },
        scissors = { win = "rock", lose = "paper" },
    }

    return should_play[oponent][outcome]
end

-- Get details of one round of rock-paper-scissors.
--
-- Returns the shape you played and the outcome.
--
-- Params:
--  description: A string describing the round: two space separated symbols
--               encoding the shape played by the oponent and the desired outcome.
local function get_round_info(description)
    local oponent_symbol, outcome_symbol = day02.get_symbols(description)
    local oponent = shape_decoder[oponent_symbol]
    local outcome = outcome_decoder[outcome_symbol]
    local should_play = get_shape_to_play(oponent, outcome)
    return should_play, outcome
end

function P.solve(in_buffer)
    local score = day02.score_game(in_buffer, get_round_info)

    local out_buffer = vim.api.nvim_create_buf(true, false)
    buffer_utils.replace_buffer_content(out_buffer, { score })
    return out_buffer
end

return P
