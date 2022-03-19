local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "c_sharp", "lua", "dockerfile", "bash", "css", "json", "javascript", "json5", "python", "regex", "rst", "yaml", "vim",-- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

require'nvim-treesitter.configs'.setup {
      textobjects = {
            move = {
                  enable = true,
                  set_jumps = true, -- whether to set jumps in the jumplist
                  goto_next_start = {
                        ["<space>jd"] = "@method.outer",
                        ["]]"] = "@class.outer",
                      },
                  goto_next_end = {
                        ["]M"] = "@body.outer",
                        ["]["] = "@class.outer",
                      },
                  goto_previous_start = {
                        ["[m"] = "@method.outer",
                        ["[["] = "@class.outer",
                      },
                  goto_previous_end = {
                        ["[M"] = "@method.outer",
                        ["[]"] = "@class.outer",
                      },
                },
          },
}
