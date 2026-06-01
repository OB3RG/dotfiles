return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      wk.add({
        {"<leader>f", group = "File"},
        {"<leader>d", group = "Delete/Close"},
        {"<leader>q", group = "Quit"},
        {"<leader>s", group = "Search"},
        {"<leader>l", group = "LSP"},
        {"<leader>u", group = "UI"},
        {"<leader>b", group = "Buffer"},
        {"<leader>w", group = "Window"},
        {"<leader>n", group = "Test"},
        {"<leader>g", group = "Git"},
        {"<leader>e", group = "Explorer"},
        {"<leader>t", group = "Toggle"},
        {"<leader>L", group = "Lazy"},
        {"<leader>M", group = "Mason"},
      })
    end
  }
}
