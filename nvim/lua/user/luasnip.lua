local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config{

  history = true,
  updateevents = "TextChanged, TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error"} },
      },
    },
  },
}

ls.snippets = {
  all = {
    ls.parser.parse_snippet("expand", "-- this is what was expanded")
  },

  lua = {

  },
}
