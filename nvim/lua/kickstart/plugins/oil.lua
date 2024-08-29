return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			keymaps = {
				["<Esc>"] = "actions.close",
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name)
					return vim.startswith(name, ".")
				end,
				-- This function defines what will never be shown, even when `show_hidden` is set
				-- is_always_hidden = function(name)
				-- 	return vim.startswith(name, ".git")
				-- end,
			},
		})
	end,
	keys = {
		{ "=", "<cmd>Oil<cr>", mode = "n", desc = "Open Filesystem" },
		{ "-", "<cmd>Oil --float<cr>", mode = "n", desc = "Open Floating Filesystem" },
	},
}
-- vim: ts=2 sts=2 sw=2 et
