return {
	"zbirenbaum/copilot-cmp",
	event = "InsertEnter",
	config = function()
		require("copilot_cmp").setup()
	end,
	dependencies = {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
