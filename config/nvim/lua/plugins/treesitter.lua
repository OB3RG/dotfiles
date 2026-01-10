-- Highlight, edit, and navigate code
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false, -- nvim-treesitter does not support lazy-loading
		build = ":TSUpdate",
		config = function()
			-- Install parsers
			require("nvim-treesitter").install({ "c", "cpp", "go", "lua", "python", "rust", "vimdoc", "vim" })

			-- Enable treesitter highlighting for all filetypes
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})

			-- Enable incremental selection
			vim.keymap.set("n", "<C-space>", function()
				vim.cmd("normal! v")
				require("nvim-treesitter.incremental_selection").init_selection()
			end, { desc = "Init selection" })
			vim.keymap.set("v", "<C-space>", function()
				require("nvim-treesitter.incremental_selection").node_incremental()
			end, { desc = "Increment selection" })
			vim.keymap.set("v", "<C-s>", function()
				require("nvim-treesitter.incremental_selection").scope_incremental()
			end, { desc = "Scope increment" })
			vim.keymap.set("v", "<C-backspace>", function()
				require("nvim-treesitter.incremental_selection").node_decremental()
			end, { desc = "Decrement selection" })
		end,
	},
}
