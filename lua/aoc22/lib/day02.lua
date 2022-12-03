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

function P.get_symbols(description)
    return unpack(vim.split(description, " ", { trimempty = true }), 1, 2)
end

function P.score_game(in_buffer, get_round_details)
    local score = 0
    for _, round_description in buffer_utils.iter_lines(in_buffer) do
        local played, outcome = get_round_details(round_description)
        score = score + shape_scores[played] + outcome_scores[outcome]
    end
    return score
end

return P
