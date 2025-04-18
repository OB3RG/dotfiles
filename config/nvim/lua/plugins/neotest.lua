return {
  "nvim-neotest/neotest", -- Neotest itself
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" },
  },
  config = function()
    local neotest_golang_opts = {
       go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
       dap_go_enabled = false,
    }  -- Specify custom configuration
    require("neotest").setup({
      adapters = {
        require("neotest-golang")(neotest_golang_opts), -- Registration
      },
    })

    local map = require("helpers.keys").map
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

  end,
}
