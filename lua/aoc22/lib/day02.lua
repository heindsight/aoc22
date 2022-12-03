-- Common helpers for day 2 -- Rock Paper Scissors score calculation

local buffer_utils = require("aoc22.lib.buffer_utils")

local shape_scores = {
    rock = 1,
    paper = 2,
    scissors = 3,
}

local outcome_scores = {
    win = 6,
    draw = 3,
    lose = 0,
}

local P = {}

-- Get the rock-paper-scissors symbols from an input line
--
-- Params:
--  description: A string containing 2 space separated symbols describing
--               one round of a rock-paper-scissors game.
function P.get_symbols(description)
    return unpack(vim.split(description, " ", { trimempty = true }), 1, 2)
end

-- Calculate your score for a rock-paper-scissors game
--
-- Params:
--  in_buffer:         The input buffer handle. Each line in the buffer should have
--                     two space-separated symbols to describe one round of the game.
--  get_round_details: A function to get the outcome of a single round. Should take
--                     a round description string (one line from the input) and return
--                     the shape played and the outcome.
function P.score_game(in_buffer, get_round_details)
    local score = 0
    for _, round_description in buffer_utils.iter_lines(in_buffer, { skip_blank = true }) do
        local played, outcome = get_round_details(round_description)
        score = score + shape_scores[played] + outcome_scores[outcome]
    end
    return score
end

return P
