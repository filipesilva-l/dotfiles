vim.cmd("compiler dotnet")

vim.g.dotnet_errors_only = false
vim.g.dotnet_show_project_file = false

local function find_dotnet_project()
    local current_file = vim.fn.expand("%:p")
    local cwd = vim.fn.getcwd()

    local csproj_path = vim.fs.find(function(name, _)
        return name:match("%.csproj$")
    end, {
        path = current_file,
        upward = true,
        stop = cwd,
        type = "file",
    })[1]

    if csproj_path then
        return vim.fs.dirname(csproj_path)
    end

    -- Fallback to cwd
    return cwd
end

local function build_nearest_project()
    local project_dir = find_dotnet_project()

    vim.cmd("Dispatch dotnet build -nologo -consoleLoggerParameters:NoSummary -verbosity:quiet " .. project_dir)
end

vim.keymap.set("n", "<leader>db", build_nearest_project, { buffer = true, desc = "build nearest project" })

local function build_solution()
    vim.cmd(":Dispatch dotnet build -nologo -consoleLoggerParameters:NoSummary -verbosity:quiet " .. vim.fn.getcwd())
end

vim.keymap.set("n", "<leader>ds", build_solution, { buffer = true, desc = "build solution" })

local function build_affected(from)
    vim.cmd("Dispatch dotnet_build_affected " .. vim.fn.shellescape(from))
end

vim.keymap.set("n", "<leader>da", function() build_affected("@-") end, { buffer = true, desc = "build affected from @-" })
vim.keymap.set("n", "<leader>dA", function() build_affected("trunk()") end, { buffer = true, desc = "build affected from trunk()" })
