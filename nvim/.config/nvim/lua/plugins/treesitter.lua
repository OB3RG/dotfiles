-- Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- new rewritten version, required for Neovim 0.12+
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			"MeanderingProgrammer/treesitter-modules.nvim", -- provides highlight, indent, fold, incremental_selection
		},
		config = function()
			local ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "vimdoc", "vim" }

			-- Install missing parsers on startup
			local installed = require("nvim-treesitter.config").get_installed()
			local to_install = vim.iter(ensure_installed):filter(function(parser)
				return not vim.tbl_contains(installed, parser)
			end):totable()
			if #to_install > 0 then
				require("nvim-treesitter").install(to_install)
			end

			-- Enable treesitter features via treesitter-modules.nvim
			require("treesitter-modules").setup({
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<C-s>",
						node_decremental = "<C-backspace>",
					},
				},
			})
		end,
	},
}
