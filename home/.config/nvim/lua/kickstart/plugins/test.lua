return {
	{
		"nvim-neotest/neotest",
		lazy = true,
		optional = false,
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
		},
		opts = {
			adapters = {},
			status = { virtual_text = true },
			output = { open_on_run = true },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-go"),
				},
				status = { virtual_text = true },
				output = { open_on_run = true },
			})
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						-- Replace newline and tab characters with space for more compact diagnostics
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
		end,
		keys = {
			{
				"<leader>tf",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "[T]ests Run in [F]ile",
			},
			{
				"<leader>tr",
				function()
					require("neotest").run.run()
				end,
				desc = "[T]ests [R]un Nearest",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "[T]est [D]ebug Nearest",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "[T]est Toggle [S]ummary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true, auto_close = true })
				end,
				desc = "[T]est Show Output",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "[T]est Show [O]utput Panel",
			},
			{
				"<leader>tS",
				function()
					require("neotest").run.stop()
				end,
				desc = "[T]est Run Stop",
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
