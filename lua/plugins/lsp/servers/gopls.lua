-- gopls LSP configuration
-- https://github.com/golang/tools/tree/master/gopls

local util = require("lspconfig.util")

-- Get the Go path from environment or default location
local function get_go_path()
    if vim.env.GOPATH then
        return vim.env.GOPATH
    end
    -- Default GOPATH
    return vim.fs.joinpath(vim.env.HOME, "go")
end

-- Configure environment with proper Go paths
local function setup_go_env()
    local go_path = get_go_path()
    vim.env.GOPATH = go_path
    vim.env.PATH = string.format("%s/bin:%s", go_path, vim.env.PATH)
end

-- Setup Go environment on startup
setup_go_env()

---@type config.lsp.ClientConfig
local config = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            -- Advanced analysis settings
            analyses = {
                unusedparams = true,
                shadow = true,
                fieldalignment = true,
                nilness = true,
                unusedwrite = true,
                useany = true,
            },
            -- Code style and formatting
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            -- Build configuration
            buildFlags = { "-tags=integration,e2e" },
            -- Imports organization
            importShortcut = "Both",
            -- Module configuration
            expandWorkspaceToModule = true,
            -- Documentation
            hoverKind = "FullDocumentation",
            -- Completion
            matcher = "Fuzzy",
            -- Code lenses
            codelenses = {
                gc_details = true,
                generate = true,
                regenerate_cgo = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
            },
        },
    },
    on_init = function(client)
        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            gopls = {
                -- Set local module path
                localPath = client.config.root_dir
            }
        })
    end
}

return config
