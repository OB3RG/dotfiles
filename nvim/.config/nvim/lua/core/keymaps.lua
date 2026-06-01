local map = require("helpers.keys").map

-- Quick access to some common actions
map("n", "<leader>fw", "<cmd>w<cr>", "Write")
map("n", "<leader>fa", "<cmd>wa<cr>", "Write all")
map("n", "<leader>qq", "<cmd>q<cr>", "Quit")
map("n", "<leader>qa", "<cmd>qa!<cr>", "Quit all")
map("n", "<leader>dw", "<cmd>close<cr>", "Window")

-- Diagnostic keymaps
map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Easier access to beginning and end of lines
map("n", "<M-h>", "^", "Go to beginning of line")
map("n", "<M-l>", "$", "Go to end of line")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>db", buffers.delete_this, "Current buffer")
map("n", "<leader>do", buffers.delete_others, "Other buffers")
map("n", "<leader>da", buffers.delete_all, "All buffers")
map("n", "<C-c>", ":bp|bd #<CR>", "Move the prev buffer and close buffer previously open")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Switch between light and dark modes
map("n", "<leader>ut", function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end, "Toggle between light and dark themes")

-- Clear after search
map("n", "<leader>ur", "<cmd>nohl<cr>", "Clear highlights")

-- File explorer
map({ "n", "v" }, "<leader>e", "<cmd>Neotree reveal<cr>", "Toggle file explorer")

-- Lazy plugin manager
map("n", "<leader>L", "<cmd>Lazy<cr>", "Show Lazy")

-- Mason LSP manager
map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")

-- Telescope search functions
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recently opened")
map("n", "<leader><space>", "<cmd>Telescope buffers<cr>", "Open buffers")
map("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, "Search in current buffer")
map("n", "<leader>sf", "<cmd>Telescope find_files<cr>", "Files")
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", "Help")
map("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", "Current word")
map("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", "Grep")
map("n", "<leader>sd", function()
	require("telescope.builtin").diagnostics({wrap_results = true, line_width = 'full'})
end, "Diagnostics")
map("n", "<C-p>", "<cmd>Telescope keymaps<cr>", "Search keymaps")

-- Git functions
map("n", "<leader>ga", "<cmd>Git add %<cr>", "Stage the current file")
map("n", "<leader>gb", "<cmd>Git blame<cr>", "Show the blame")

-- Neotest functions
map("n", "<leader>nr", "<cmd>lua require('neotest').run.run()<cr>", "Run nearest test")
map("n", "<leader>nf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run current file")
map("n", "<leader>na", "<cmd>lua require('neotest').run.run({ suite = true })<cr>", "Run all tests")
map("n", "<leader>nd", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug nearest test")
map("n", "<leader>ns", "<cmd>lua require('neotest').run.stop()<cr>", "Stop test")
map("n", "<leader>nn", "<cmd>lua require('neotest').run.attach()<cr>", "Attach to nearest test")
map("n", "<leader>no", "<cmd>lua require('neotest').output.open()<cr>", "Show test output")
map("n", "<leader>np", "<cmd>lua require('neotest').output_panel.toggle()<cr>", "Toggle output panel")
map("n", "<leader>nv", "<cmd>lua require('neotest').summary.toggle()<cr>", "Toggle summary")
map("n", "<leader>nc", "<cmd>lua require('neotest').run.run({ suite = true, env = { CI = true } })<cr>", "Run all tests with CI")
