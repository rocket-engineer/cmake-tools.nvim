local has_toggleterm, _ = pcall(require, "toggleterm")
if not has_toggleterm then
  return
end

local terminal = require("toggleterm.terminal")

local M = {
  term = nil,
}

function M.run_ccmake(cmd, build_dir)
  M.term = terminal.Terminal:new({
    cmd = cmd .. " " .. build_dir,
    direction = "float",
    hidden = true,
    highlights = {
      Normal = {
        guibg = "#000000",
      },
    }
  })

  M.term:toggle()
end

function M.show(opts)
  M.term:open()
end

function M.close(opts)
  M.term:close()
end

return M
