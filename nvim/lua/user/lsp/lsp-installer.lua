local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

local lspconfig = require("lspconfig")
local opts = {
on_attach = require("user.lsp.handlers").on_attach,
capabilities = require("user.lsp.handlers").capabilities,
}

lsp_installer.setup{}

lspconfig.sumneko_lua.setup{
    opts = vim.tbl_deep_extend("force", require("user.lsp.settings.jsonls"), opts),
}

lspconfig.omnisharp.setup{
    opts = vim.tbl_deep_extend("force", require("user.lsp.settings.omnisharp"), opts)
}

lspconfig.jsonls.setup{
    opts = vim.tbl_deep_extend("force", require("user.lsp.settings.jsonls"), opts)
}

lspconfig.pyright.setup{}
--[[
lsp_installer.on_server_ready(function(server)

	 if server.name == "jsonls" then
	 	local jsonls_opts = require("user.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 if server.name == "omnisharp" then
	 	local omnisharp_opts = require("user.lsp.settings.omnisharp")
	 	opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)
	 end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
]]--
