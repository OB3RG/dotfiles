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
  end,
}
