local M = {}

function M.setup()
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
        runner = "unittest",
      },
      require "neotest-jest",
      require "neotest-go",
      require "neotest-plenary",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua" },
				allow_file_types = { "haskell", "elixir", "csharp", "cs"},
      },
    },
  }
end

return M
