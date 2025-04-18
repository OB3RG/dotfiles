return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "ollama",
      auto_suggestions_provider = "ollama",
      ollama = {
        endpoint = "10.25.0.11:11434",
        model = "granite-code"
      },
      suggestion = {
        debounce = 300,
        throttle = 1000
      },
      cursor_applying_provider = 'ollama', -- In this example, use Groq for applying, but you can also use any provider you want.
      behaviour = {
        enable_cursor_planning_mode = true, -- enable cursor planning mode!
        auto_suggestions = false,
        auto_set_highlight_group = true,
      },
      rag_service = {
        enabled = false, -- Enables the RAG service
        host_mount = '/home/oberg/Work', -- Host mount path for the rag service
        provider = "ollama", -- The provider to use for RAG service (e.g. openai or ollama)
        llm_model = "granite-code", -- The LLM model to use for RAG service
        embed_model = "nomic-embed-text", -- The embedding model to use for RAG service
        endpoint = "http://10.25.0.11:11434", -- The API endpoint for RAG service
        runner = "docker"
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}

