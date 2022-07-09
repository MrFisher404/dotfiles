local M = {}

local Terminal = require("toggleterm.terminal").Terminal

local git_tui = "lazygit"

local git_client = Terminal:new {
  cmd = git_tui,
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}


local standard_term = Terminal:new {
  cmd = "neofetch",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
	on_open = function (term)
		vim.api.nvim_buf_set_keymap(term.bufnr, "i", "q", "<cmd>close<Cr>", {noremap = true, silent = true})
	end,
}

function M.git_client_toggle()
  git_client:toggle()
end


function M.term_toggle()
  standard_term:toggle()
end
return M
