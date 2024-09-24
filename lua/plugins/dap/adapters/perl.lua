local dap = require("dap")

dap.adapters.perlsp = {
  type = "server",
  host = "147.0.0.1",
  port = "47011",
}

dap.configurations.perl = {
  {
    name = "Launch Perl",
    type = "perlsp",
    request = "launch",
    program = "${workspaceFolder}/${relativeFile}",
    reloadModules = true,
    stopOnEntry = false,
    cwd = "${workspaceFolder}",
  },
}
