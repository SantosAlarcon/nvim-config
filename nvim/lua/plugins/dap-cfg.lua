return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "mxsdev/nvim-dap-vscode-js",
        "mfussenegger/nvim-dap-python",
        "jbyuki/one-small-step-for-vimkind",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",
    },
    event = "BufReadPost",
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local vt = require("nvim-dap-virtual-text")

        dapui.setup()
        vt.setup()

        -- DAP-UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        require("dap-python").setup("~/Documentos/Python/debugpy/bin/python3.12")

        -- require("dap-vscode-js").setup({
        --     node_path = "/usr/local/bin/node",
        --     debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/vsDebugServerBundle",
        --     -- debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        --     debugger_cmd = {"vscode-js-debug"},
        --     adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node", "node-terminal" },
        -- })

        for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
            dap.configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file in Node",
                    program = "${file}",
                    runtimeExecutable = "node",
                    sourceMaps = true,
                    cwd = vim.fn.getcwd(),
                    skipFiles = {
                        "<node_internals>/**",
                        "<node_modules>/**",
                    },
                    resolveSourceMapLocations = {
                        "${workspaceFolder}/**",
                        "!**/node_modules/**",
                    },
                },
                {
                    type = "pwa-chrome",
                    request = "launch",
                    name = "Launch file in Chrome",
                    program = "${file}",
                    sourceMaps = true,
                    cwd = vim.fn.getcwd(),
                    runtimeExecutable = "node",
                },
                {
                    type = "pwa-msedge",
                    request = "launch",
                    name = "Launch file in Microsoft Edge",
                    program = "${file}",
                    sourceMaps = true,
                    cwd = vim.fn.getcwd(),
                    runtimeExecutable = "node",
                },
            }
        end
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = 8123,
            executable = { command = "js-debug-adapter" },
        }

        dap.configurations.lua = {
            {
                type = "nlua",
                request = "attach",
                name = "Attach to running Neovim instance",
            },
        }

        dap.adapters.nlua = function(callback, config)
            callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
        end

        vim.keymap.set("n", "<leader>dl", function()
            require("osv").launch({ port = 8086 })
        end, { noremap = true })

        vim.keymap.set("n", "<leader>dw", function()
            local widgets = require("dap.ui.widgets")
            widgets.hover()
        end)

        vim.keymap.set("n", "<leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end)

        -- KEYMAPS
        vim.keymap.set(
            "n",
            "<Leader>db",
            ":DapToggleBreakpoint<cr>",
            { silent = true, desc = "Añadir punto de ruptura" }
        )
        vim.keymap.set("n", "<Leader>dc", ":DapContinue<cr>", { silent = true, desc = "Comenzar depuración" })
    end,
}
