
--vim.g.gruvbox_flat_style = "dark"

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
--vim.g.gruvbox_colors = { hint = "orange", error = ""}
--vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer"  }
vim.opt.background = "dark" -- or "light" for light mode
vim.cmd [[
try
 colorscheme gruvbox-flat
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
