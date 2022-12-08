-- Common helpers for day 7

local buffer_utils = require("aoc22.lib.buffer_utils")

-- Prototype for files
local File = {}

-- Construct a new file
--
-- Params:
--  size: The file size
function File:new(size)
    local file = {
        size = size
    }

    setmetatable(file, self)
    self.__index = self
    return file
end

-- Prototype for directories
local Directory = {}

-- Construct a new directory
--
-- Params:
--  parent: The parent directory
function Directory:new(parent)
    local directory = {
        parent = parent,
        content = {},
    }

    setmetatable(directory, self)
    self.__index = self
    return directory
end

-- Iterate over the children of a directory
-- Yields triples of name, type ("file" or "directory") and the file/directory objects
function Directory:children()
    return pairs(self.content)
end

-- Get directory sizes
--
-- Returns a table with the total sizes of all sub-directories.
-- The last item in the table is the total size of this directory
--
-- Params:
--  directory: The directory to operate on
function Directory:get_sizes()
    local size = 0
    local subdir_sizes = {}


    for _, obj in self:children() do
        if getmetatable(obj) == File then
            size = size + obj.size
        elseif getmetatable(obj) == Directory then
            local child_sizes = obj:get_sizes()
            size = size + child_sizes[#child_sizes]
            vim.list_extend(subdir_sizes, child_sizes)
        else
            error(string.format("Unknown object type %s", vim.inspect(obj)))
        end
    end

    table.insert(subdir_sizes, size)

    return subdir_sizes
end

-- Command patterns
local CMD_PATTERNS = {
    "(cd) (%S+)",
    "(ls)",
}

-- Parse a command.
--
-- Returns the command and the argument (if any)
--
-- Params:
--  cmdline: The command line to parse
local function parse_command(cmdline)
    for _, pattern in ipairs(CMD_PATTERNS) do
        local cmd, arg = cmdline:match("^%$ " .. pattern .. "$")
        if cmd then
            return cmd, arg
        end
    end
end

-- Prototype for the machine
local Machine = {}

-- Construct a new machine
--
-- Initialises:
--  directory_tree: to an single empty root directory
--  cwd: (the current working directory) to the root directory
function Machine:new()
    local machine = {
        directory_tree = {
            ["/"] = Directory:new(),
        },
    }
    machine.cwd = machine.directory_tree["/"]

    setmetatable(machine, self)
    self.__index = self
    return machine
end

-- Change directory
--
-- Params:
--  kwds: Keyword arguments:
--          arg: The directory to change to
function Machine:cd(kwds)
    local to = kwds.arg
    if to == "/" then
        self.cwd = self.directory_tree["/"]
    elseif to == ".." then
        local target = self.cwd.parent
        assert(target, "Current directory has no parent. Can't go up.")
        self.cwd = target
    else
        local target = self.cwd.content[to]
        assert(target, string.format("No such directory: %q", to))
        self.cwd = target
    end
end

-- Process a directory listing
--
-- Params:
--  kwds: Keyword arguments:
--          output: The ls command output as a list of strings
function Machine:ls(kwds)
    local output = kwds.output
    local line_parsers = {
        function(line)
            local size, name = line:match("^(%d+) (%S+)$")
            if name then
                return name, File:new(tonumber(size))
            end
        end,
        function(line)
            local name = line:match("^dir (%S+)$")
            if name then
                return name, Directory:new(self.cwd)
            end
        end,
    }

    for _, line in ipairs(output) do
        for _, parser in ipairs(line_parsers) do
            local name, obj = parser(line)
            if name then
                self.cwd.content[name] = obj
                break
            end
        end

    end
end

-- Interpret "shell" commands to construct directory tree
--
-- Params:
--  in_buffer: Handle for buffer with shell input
function Machine:interpret_commands(in_buffer)
    local state = {}

    local function do_current_cmd()
        if state.current_cmd then
            local cmd_fn = self[state.current_cmd]
            cmd_fn(self, { arg = state.current_arg, output = state.output })
        end
    end

    for _, line in buffer_utils.iter_lines(in_buffer, { skip_blank = true }) do
        local next_cmd, arg = parse_command(line)

        if next_cmd then
            do_current_cmd()
            state = { current_cmd = next_cmd, current_arg = arg, output = {} }
        else
            table.insert(state.output, line)
        end
    end

    -- When the loop ends, we won't have processed the last command read, so process it now.
    do_current_cmd()
end

-- Get the root directory
function Machine:get_root_dir()
    return self.directory_tree["/"]
end

local P = {}

function P.Machine()
    return Machine:new()
end

return P
