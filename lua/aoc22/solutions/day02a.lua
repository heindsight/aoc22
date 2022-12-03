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

local function get_round_info(description)
    local oponent_symbol, your_symbol = unpack(vim.split(description, " ", { trimempty = true }), 1, 2)
    local oponent = shape_decoder[oponent_symbol]
    local you = shape_decoder[your_symbol]
    local outcome = get_outcome(oponent, you)
    return you, outcome
end

function P.solve(in_buffer)
    local score = day02.score_game(in_buffer, get_round_info)

    local out_buffer = vim.api.nvim_create_buf(true, false)
    buffer_utils.replace_buffer_content(out_buffer, { score })
    return out_buffer
end

return P
