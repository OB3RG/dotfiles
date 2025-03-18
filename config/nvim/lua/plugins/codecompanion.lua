return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://10.25.0.11:11434",
              api_key = "EMPTY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "granite-code"
              }
            }
          })
        end
      },
      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        }
      },
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "telescope", -- default|telescope|mini_pick
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
      },
  },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
      local map = require("helpers.keys").map

      map("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", "CodeCompanionActions")
      map("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", "CodeCompanionActions")
      map("n", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", "CodeCompanionChat Toggle")
      map("v", "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", "CodeCompanionChat Toggle")
      map("v", "ga", "<cmd>CodeCompanionChat Add<cr>", "CodeCompanionChat Add")
    end
  }
}
