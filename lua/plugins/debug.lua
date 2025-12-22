return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio", -- Required dependency for dap-ui
		"jay-babu/mason-nvim-dap.nvim", -- Bridges Mason to nvim-dap
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")

		require("mason-nvim-dap").setup({
			ensure_installed = { "codelldb" },
			handlers = {
				function(config)
					-- This sets up the adapter definition for codelldb automatically
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		ui.setup()

		local mason_path = vim.fn.stdpath("data") .. "/mason/"
		local codelldb_path = mason_path .. "packages/codelldb/extension/adapter/codelldb"

		dap.adapters.codelldb = {
			type = "server",
			host = "127.0.0.1",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
				-- On windows you may have to uncomment this:
				-- detached = false,
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		dap.configurations.c = dap.configurations.cpp

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>?", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "Debug: Evaluate Var" })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
