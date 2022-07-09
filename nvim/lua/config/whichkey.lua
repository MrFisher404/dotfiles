local M = {}

local whichkey = require "which-key"
--local legendary = require "legendary"
local next = next

local conf = {
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
	},
}
whichkey.setup(conf)

local opts = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
	mode = "v", -- Visual mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
	local keymap_f = nil -- File search
	local keymap_p = nil -- Project search

	keymap_f = {
		name = "Find",
		a = { "<cmd>Alpha<cr>", "Alpha" },
		f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
		d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
		b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
		h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
		m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
		o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
		u = { "<cmd>lua require('telescope.builtin').lsp_references({includeDeclaration = false})<cr>", "Usages" },
		s = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "String Live Grep" },
		c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
		w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
		l = { "<cmd>Telescope file_browser path=%:p:h hidden=true<cr>", "Local File Browser" },
		e = { "<cmd>NvimTreeFindFileToggle<cr>", "Explorer" },
	}

	keymap_p = {
		name = "Project",
		p = { "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>", "List" },
		s = { "<cmd>lua require'telescope'.extensions.repo.list{}<cr>", "Search" },
		P = { "<cmd>TermExec cmd='BROWSER=brave yarn dev'<cr>", "Slidev" },
	}

	local keymap = {
		["w"] = { "<cmd>update!<CR>", "Save" },
		["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },

		a = {
			name = "Attempt",
			n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
			i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
			r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
			d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
			c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
			s = { "<Cmd>Telescope attempt<Cr>", "Search" },
		},

		b = {
			name = "Buffer",
			c = { "<Cmd>BDelete this<Cr>", "Close Buffer" },
			f = { "<Cmd>BDelete! this<Cr>", "Force Close Buffer" },
			D = { "<Cmd>BWipeout other<Cr>", "Delete All Buffers" },
			b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
			p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
			m = { "<Cmd>JABSOpen<Cr>", "Menu" },
		},

		c = {
			name = "Code",
			g = { "<cmd>Neogen func<Cr>", "Func Doc" },
			G = { "<cmd>Neogen class<Cr>", "Class Doc" },
			d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
			T = { "<cmd>TodoTelescope<Cr>", "TODO" },
			x = "Swap Next Param",
			X = "Swap Prev Param",
			-- f = "Select Outer Function",
			-- F = "Select Outer Class",
		},

		d = {
			name = "Debug",
		},

		e = {
			name = "Error",
			r = {"<cmd>TroubleRefresh<Cr>", "Refresh"},
			t = {"<cmd>TroubleToggle<Cr>", "Toggle"},
			n = {"<cmd>require('trouble').next({skip_groups = true, jump = true})<Cr>", "Next"},
			p = {"<cmd>require('trouble').previous({skip_groups = true, jump = true})<Cr>", "Previous"},
		},

		f = keymap_f,
		p = keymap_p,

		j = {
			name = "Jump",
			a = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add File" },
			m = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "UI Menu" },
			c = { "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", "Command Menu" },
		},
		["0"] = { "<cmd>lua require('utils.term').term_toggle()<CR>", "Terminal" },
		["1"] = { "<Cmd>lua require('harpoon.ui').nav_file(1) <Cr>", "File 1" },
		["2"] = { "<Cmd>lua require('harpoon.ui').nav_file(2) <Cr>", "File 2" },
		["3"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(1)<Cr>", "Terminal 1" },
		["4"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(2)<Cr>", "Terminal 2" },
		["5"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,1)<Cr>", "Command 1" },
		["6"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,2)<Cr>", "Command 2" },

		t = {
			name = "neoTest",
			a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
			f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
			F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
			l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
			L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
			n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
			N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
			o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
			S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
			s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
		},


		n = {
			name = "Notes",
			r = { "<Cmd>ZkNew { dir = 'referencenotes', date = 'today', title = vim.fn.input('Title: ') }<CR>", "Reference" },
			c = { "<cmd>ZkNew { dir = 'capturenotes', date = 'today', title = vim.fn.input('Title: ')}<cr>", "Capture" },
			t = { "<cmd>ZkTags<cr>", "Tags" },
		},



		r = {
			name = "Refactor",
			i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
			p = { [[ <Esc><Cmd>lua require('refactoring').debug.printf({below = false})<CR>]], "Debug Print" },
			c = { [[ <Esc><Cmd>lua require('refactoring').debug.cleanup({below = false})<CR>]], "Debug Cleanup" },
		},

		s = {
			name = "Search",
			o = { [[ <Esc><Cmd>lua require('spectre').open()<CR>]], "Open" },
		},

		v = {
			name = "Vimspector",
			G = { "<cmd>lua require('config.vimspector').generate_debug_profile()<cr>", "Generate Debug Profile" },
			I = { "<cmd>VimspectorInstall<cr>", "Install" },
			U = { "<cmd>VimspectorUpdate<cr>", "Update" },
			R = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to Cursor" },
			c = { "<cmd>call vimspector#Continue()<cr>", "Continue" },
			i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
			o = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
			s = { "<cmd>call vimspector#Launch()<cr>", "Start" },
			t = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
			u = { "<cmd>call vimspector#StepOut()<cr>", "Step Out" },
			S = { "<cmd>call vimspector#Stop()<cr>", "Stop" },
			r = { "<cmd>call vimspector#Restart()<cr>", "Restart" },
			x = { "<cmd>VimspectorReset<cr>", "Reset" },
			H = { "<cmd>lua require('config.vimspector').toggle_human_mode()<cr>", "Toggle HUMAN mode" },
		},

		z = {
			name = "System",
			-- c = { "<cmd>PackerCompile<cr>", "Compile" },
			c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
			d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
			D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			m = { "<cmd>lua require('telescope').extensions.macroscope.default()<cr>", "Macros" },
			p = { "<cmd>PackerProfile<cr>", "Profile" },
			s = { "<cmd>PackerSync<cr>", "Sync" },
			S = { "<cmd>PackerStatus<cr>", "Status" },
			u = { "<cmd>PackerUpdate<cr>", "Update" },
			-- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
			-- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
			x = { "<cmd>Telescope cder<cr>", "Change Directory" },
			e = { "!!$SHELL<CR>", "Execute line" },
			W = { "<cmd>lua require('utils.session').toggle_session()<cr>", "Toggle Workspace Saving" },
			w = { "<cmd>lua require('utils.session').list_session()<cr>", "Restore Workspace" },
			z = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
		},

		o = {
			name = "Open",
			f = {"<cmd>ToggleTerm direction=float <Cr>", "Terminal Float"},
			h = {"<cmd>ToggleTerm direction=horizontal size=15<Cr>", "Terminal Horizontal"},
			v = {"<cmd>ToggleTerm direction=vertical size=80<Cr>", "Terminal Vertical"},

		},

		g = {
			name = "Git",
			b = { "<cmd>GitBlameToggle<CR>", "Blame" },
			g = { "<cmd>lua require('utils.term').git_client_toggle()<CR>", "Git TUI" },
		},
	}
	whichkey.register(keymap, opts)
	--legendary.bind_whichkey(keymap, opts, false)
end

local function visual_keymap()
	local keymap = {
		g = {
			name = "Git",
			y = {
				"<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
				"Link",
			},
		},

		r = {
			name = "Refactor",
			e = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
			f = {
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function to File')<CR>]],
				"Extract Function to File",
			},
			v = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
			i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
			r = { [[ <Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
			V = { [[ <Esc><Cmd>lua require('refactoring').debug.print_var({})<CR>]], "Debug Print Var" },
		},
	}

	whichkey.register(keymap, v_opts)
	--legendary.bind_whichkey(keymap, v_opts, false)
end

local function code_keymap()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			vim.schedule(CodeRunner)
		end,
	})

	function CodeRunner()
		local bufnr = vim.api.nvim_get_current_buf()
		local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local fname = vim.fn.expand "%:p:t"
		local keymap_c = {} -- normal key map
		local keymap_c_v = {} -- visual key map

		if ft == "python" then
			keymap_c = {
				name = "Code",
				r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
				m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
			}
		elseif ft == "lua" then
			keymap_c = {
				name = "Code",
				r = { "<cmd>luafile %<cr>", "Run" },
			}
		elseif ft == "rust" then
			keymap_c = {
				name = "Code",
				r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
				D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
				h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
				R = { "<cmd>RustRunnables<cr>", "Runnables" },
			}
		elseif ft == "go" then
			keymap_c = {
				name = "Code",
				r = { "<cmd>GoRun<cr>", "Run" },
			}
		elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
			keymap_c = {
				name = "Code",
				o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
				r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
				i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
				F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
				u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
				R = { "<cmd>lua require('config.test').javascript_runner()<cr>", "Choose Test Runner" },
				s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
				t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
			}
		elseif ft == "java" then
			keymap_c = {
				name = "Code",
				o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
				v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
				c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
				t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
				n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
			}
			keymap_c_v = {
				name = "Code",
				v = { "<cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
				c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
				m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
			}
		end

		if fname == "package.json" then
			keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
			keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
			keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
			keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
		end

		if fname == "Cargo.toml" then
			keymap_c.u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" }
		end

		if next(keymap_c) ~= nil then
			local k = { c = keymap_c }
			local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
			whichkey.register(k, o)
			--legendary.bind_whichkey(k, o, false)
		end

		if next(keymap_c_v) ~= nil then
			local k = { c = keymap_c_v }
			local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
			whichkey.register(k, o)
			--legendary.bind_whichkey(k, o, false)
		end
	end
end

function M.setup()
	normal_keymap()
	visual_keymap()
	code_keymap()
end

return M
