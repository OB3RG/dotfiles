-- Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- nvim-treesitter does not support lazy-loading
		build = ":TSUpdate",
		config = function()
			-- Configure treesitter with proper API
			require("nvim-treesitter.configs").setup({
				-- Install parsers
				ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "vimdoc", "vim" },

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				-- Enable syntax highlighting
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				-- Enable incremental selection
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
