local status_ok, _ = pcall(require, "dap")
if not status_ok then
    print("dap could not be loaded")
  return
end

require("user.dap.dapconfig").setup()
