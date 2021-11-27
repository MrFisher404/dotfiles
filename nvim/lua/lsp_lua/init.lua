local util = require('lspconfig').util
-- Your custom attach function for nvim-lspconfig goes here.
local on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.j
  local opts = { noremap=true, silent=true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', '<space>fd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', '<space>fi', '<cmd>Telescope lsp_implementations<CR>', opts)
      buf_set_keymap('n', '<space>fu', '<cmd>Telescope lsp_references<CR>', opts)
      buf_set_keymap('n', '<space><space>', '<cmd>Telescope lsp_code_actions<CR>', opts)
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>ep', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', '<space>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

vim.lsp.set_log_level("debug")
-- Sumneko
-- Lua LSP
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = "/home/timpe/languageservers/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Omnisharp
-- C# LSP

local find_root_dir = function(file, _)
    if file:sub(-#".csx") == ".csx" then
        return util.path.dirname(file)
    end
    return util.root_pattern("*.sln")(file) or util.root_pattern("*.csproj")(file)
end
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/timpe/languageservers/omnisharp-roslyn-server/run"
require'lspconfig'.omnisharp.setup{
    rootPath = {'home/timpe/development/devinite/devinite.FullWithoutExternal.sln'},
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    filetypes = {'cache', 'cs', 'csproj', 'dll', 'nuget', 'props', 'sln', 'targets'},
    root_dir = find_root_dir
}

-- Bash
--Bashls

require'lspconfig'.bashls.setup{}
