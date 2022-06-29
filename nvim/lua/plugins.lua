local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
		profile = {
			enable = true,
			threshold = 0,
		},
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Colorscheme
    use {
      "sainnhe/everforest",
      config = function()
        vim.cmd "colorscheme everforest"
      end,
    }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "VimEnter",
      config = function()
        vim.notify = require "notify"
      end,
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Git
    use {
      "TimUntersberger/neogit",
			cmd = "Neogit",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("config.neogit").setup()
      end,
    }

		-- WhichKey
		use {
			 "folke/which-key.nvim",
			 event = "VimEnter",
			 config = function()
				 require("config.whichkey").setup()
			 end,
		 }

		-- IndentLine
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indentblankline").setup()
			end,
				}

	-- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }

    -- Easy hopping
    use {
      "phaazon/hop.nvim",
      cmd = { "HopWord", "HopChar1" },
      config = function()
        require("hop").setup {}
      end,
    }

    -- Easy motion
    use {
      "ggandor/lightspeed.nvim",
      keys = { "s", "S", "f", "F", "t", "T" },
      config = function()
        require("lightspeed").setup {}
      end,
    }
		
    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
    }

		--LuaLine StatusLine
		use {
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			config = function()
			 require("config.lualine").setup()
			end,
			requires = { "nvim-web-devicons" },
		}

		--better StatusLine
		use {
			"SmiteshP/nvim-gps",
			requires = "nvim-treesitter/nvim-treesitter",
			module = "nvim-gps",
			config = function()
				require("nvim-gps").setup()
			end,
		}

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
    }

      use {
        "nvim-telescope/telescope.nvim",
        opt = true,
        config = function()
          require("config.telescope").setup()
        end,
        cmd = { "Telescope" },
        module = "telescope",
        keys = { "<leader>f", "<leader>p" },
        wants = {
          "plenary.nvim",
          "popup.nvim",
          "telescope-fzf-native.nvim",
          "telescope-project.nvim",
          "telescope-repo.nvim",
          "telescope-file-browser.nvim",
          "project.nvim",
          "trouble.nvim",
        },
        requires = {
          "nvim-lua/popup.nvim",
          "nvim-lua/plenary.nvim",
          { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
          "nvim-telescope/telescope-project.nvim",
          "cljoly/telescope-repo.nvim",
          "nvim-telescope/telescope-file-browser.nvim",
          {
            "ahmedkhalf/project.nvim",
            config = function()
              require("project_nvim").setup {}
            end,
          },
        },
      }


		--NvimTree
		use {
		 "kyazdani42/nvim-tree.lua",
		 requires = {
			 "kyazdani42/nvim-web-devicons",
		 },
		 cmd = { "NvimTreeFindFileToggle", "NvimTreeClose" },
			 config = function()
				 require("config.nvimtree").setup()
			 end,
		}

		-- Buffer line
		use {
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			wants = "nvim-web-devicons",
			config = function()
				require("config.bufferline").setup()
			end,
		}

		--Cmp Completion
		use {
			"hrsh7th/nvim-cmp",
			--event = "InsertEnter",
			--opt = true,
			config = function()
				require("config.cmp").setup()
			end,
			wants = { "LuaSnip" },
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
				{
					"L3MON4D3/LuaSnip",
					wants = "friendly-snippets",
					config = function()
						require("config.luasnip").setup()
					end,
				},
				"rafamadriz/friendly-snippets",
				"honza/vim-snippets",
			},
		}
		-- Auto pairs
		use {
			"windwp/nvim-autopairs",
			wants = "nvim-treesitter",
			module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
			config = function()
				require("config.autopairs").setup()
			end,
		}

		-- Auto tag
		use {
			"windwp/nvim-ts-autotag",
			wants = "nvim-treesitter",
			event = "InsertEnter",
			config = function()
				require("nvim-ts-autotag").setup { enable = true }
			end,
		}

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      wants = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
    }

    -- LSP
		use {
			"neovim/nvim-lspconfig",
			--opt = true,
			--event = "BufReadPre",
			wants = {
				"nvim-lsp-installer",
				"cmp-nvim-lsp",
				"lua-dev.nvim",
				"vim-illuminate",
				"null-ls.nvim",
				"schemastore.nvim",
			},
			config = function()
				require("config.lsp").setup()
			end,
			requires = {
				"williamboman/nvim-lsp-installer",
				"folke/lua-dev.nvim",
				"RRethy/vim-illuminate",
				"jose-elias-alvarez/null-ls.nvim",
				{
					"j-hui/fidget.nvim",
					config = function()
						require("fidget").setup {}
					end,
				},
				"b0o/schemastore.nvim",
			},
		}

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- lspsaga.nvim
    use {
      "tami5/lspsaga.nvim",
      event = "VimEnter",
      cmd = { "Lspsaga" },
      config = function()
        require("lspsaga").setup {}
      end,
    }

		use {
			'lewis6991/gitsigns.nvim',
			config = function()
				require('gitsigns').setup()
			end
		}


	-- Rust
	use {
		"simrat39/rust-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
		module = "rust-tools",
		ft = { "rust" },
		config = function()
			require("rust-tools").setup {}
		end,
		}

		-- Debugging
		use {
			"mfussenegger/nvim-dap",
			opt = true,
			event = "BufReadPre",
			module = { "dap" },
			wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
			requires = {
				"Pocco81/DAPInstall.nvim",
				"theHamsta/nvim-dap-virtual-text",
				"rcarriga/nvim-dap-ui",
				"mfussenegger/nvim-dap-python",
				"nvim-telescope/telescope-dap.nvim",
				{ "leoluz/nvim-dap-go", module = "dap-go" },
				{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
			},
			config = function()
				require("config.dap").setup()
			end,
		}

		-- Testing
		use {
			"rcarriga/vim-ultest",
			requires = { "vim-test/vim-test" },
			opt = true,
			keys = { "<leader>t" },
			cmd = {
				"TestNearest",
				"TestFile",
				"TestSuite",
				"TestLast",
				"TestVisit",
				"Ultest",
				"UltestNearest",
				"UltestDebug",
				"UltestLast",
				"UltestSummary",
			},
			module = "ultest",
			run = ":UpdateRemotePlugins",
			config = function()
				require("config.test").setup()
			end,
		}

		use {
			"nvim-neotest/neotest",
			opt = true,
			wants = {
				"plenary.nvim",
				"nvim-treesitter",
				"FixCursorHold.nvim",
				"neotest-python",
				"neotest-plenary",
				"neotest-go",
				"neotest-jest",
				"neotest-vim-test",
			},
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
				"antoinemadec/FixCursorHold.nvim",
				"nvim-neotest/neotest-python",
				"nvim-neotest/neotest-plenary",
				"nvim-neotest/neotest-go",
				"haydenmeade/neotest-jest",
				"nvim-neotest/neotest-vim-test",
			},
			module = { "neotest" },
			config = function()
				require("config.neotest").setup()
			end,
		}

		--RestApi Helper
		use { "diepm/vim-rest-console", ft = { "rest" } }

		-- Select UI
    use {'nvim-telescope/telescope-ui-select.nvim' }


    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end

  end


  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
