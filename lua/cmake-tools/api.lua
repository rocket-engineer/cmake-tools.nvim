local config = require("cmake-tools.config")

M = {}

M.provide_config_settings = function(config_settings)
  -- print(vim.inspect(config_settings))

  -- update source directory
  config.cwd = config_settings.source_dir

  -- update build directory
  if config_settings.build_dir ~= nil and
     config_settings.build_dir ~= "" then
    config:update_build_dir(config_settings.build_dir, config_settings.build_dir)
    config.overwrite_preset_build_dir = false
  end

  -- initial cache
  if config_settings.initial_cache ~= nil and
     config_settings.initial_cache ~= "" then
    config.initial_cache = config_settings.initial_cache
  end
  -- update preset
  if config_settings.preset ~= nil and
     config_settings.preset ~= "" then
    config.configure_preset = config_settings.preset
    -- config.build_preset = config_settings.preset
  end

end

return M
