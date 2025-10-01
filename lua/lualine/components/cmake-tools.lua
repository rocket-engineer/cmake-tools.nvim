-- ## Usage
--
--   require("lualine").setup({
--     sections = {
--       lualine_x = { "cmake-tools" },
--     },
--   })
--
-- ## Options
--

local M = require("lualine.component"):extend()
local cmake = require("cmake-tools")

local icons = {
  ui = {
    Search = "",
    Gear = "",
    Debug = "",
    Run = "",
  },
}

function M:init(options)
  M.super.init(self, options)

  -- self.options.label = self.options.label or ""
  -- if self.options.colored == nil then
  --   self.options.colored = true
  -- end
  -- if self.options.colored then
  --   overseer.on_setup(function()
  --     self:update_colors()
  --   end)
  -- end
  -- self.symbols = vim.tbl_extend(
  --   "keep",
  --   self.options.symbols or {},
  --   self.options.icons_enabled ~= false and default_icons or default_no_icons
  -- )
end

function M:update_status()
  if not cmake.is_cmake_project() then
    return
  end

  local pieces = {}

  -- move cmake-tools to the middle
  table.insert(pieces, "%=")

  -- Part 1: Configuration
  if cmake.has_cmake_preset() then
    local configure_preset = cmake.get_configure_preset()
    local part = "Preset: " .. (configure_preset and configure_preset or "N/A")

    table.insert(pieces, icons.ui.Search)
    table.insert(pieces, part)
  else
    local type = cmake.get_build_type()
    local part = "Build Type: " .. (type and type or "")

    table.insert(pieces, icons.ui.Search)
    table.insert(pieces, part)
  end
  table.insert(pieces, " | ")

  -- Part 2: Build
  table.insert(pieces, icons.ui.Gear)
  table.insert(pieces, "Build")
  if cmake.has_cmake_preset() then
    local build_preset = cmake.get_build_preset()
    local nprocs = cmake.get_nprocs()

    local part = "Target: " .. (build_preset and build_preset or "N/A")
    if nprocs > 1 then
      part = part .. " (N=" .. nprocs .. ")"
    end

    table.insert(pieces, part)
  else
    local build_target = cmake.get_build_target()
    local nprocs = cmake.get_nprocs()

    local part = "Target: " .. (build_target and build_target or "N/A")
    if nprocs > 1 then
      part = part .. " (N=" .. nprocs .. ")"
    end

    table.insert(pieces, part)
  end
  table.insert(pieces, " | ")

  -- Part 3: Execution
  table.insert(pieces, icons.ui.Run)
  table.insert(pieces, "Run")
  table.insert(pieces, icons.ui.Debug)
  table.insert(pieces, "Debug")
  local launch_target = cmake.get_launch_target()
  local part3 = "Target: " .. (launch_target and launch_target or "X")
  table.insert(pieces, part3)

  if #pieces > 0 then
    return table.concat(pieces, " ")
  end
end

return M
