# Advent of Code 2022

This year, I've decided to do [Advent of Code](https://adventofcode.com/2022) as
a [Neovim](https://neovim.io/) [Lua plugin](https://neovim.io/doc/user/lua.html).

## Installing

- You will need [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- Use your favourite (neo)vim package manager... or clone this repository into your packages path
  (see `:help packages` or https://neovim.io/doc/user/repeat.html#packages for more information).
  For example:

```
$ mkdir -p ~/.config/nvim/pack/start/fun
$ cd ~/.config/nvim/pack/start/fun
$ git clone https://github.com/heindsight/aoc22.git
```

## Running the solutions

The plugin defines an `:AoC22` command that can be used to run the solutions. For example to solve
the Day 1 part A puzzle, open your puzzle input in Neovim and run:

```
:AoC22 day01a
```

Puzzle input will be read from the current buffer, on completion output will be written to a new
buffer and loaded into a new split window.

## Reloading

The plugin also defines an `:AoC22Reload` command, which can be used to reload the solutions. This is
mainly useful during development, as it allows me to modify the code, reload and then run the
updated code without needing to quit and restart neovim.
