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
  end

end

M.provide_build_settings = function(build_settings)
  -- print(vim.inspect(build_settings))

  if build_settings.building ~= nil then
    local building = build_settings.building

    -- number of processors
    if building.nprocs ~= nil then
      config.nprocs = building.nprocs
    end

    -- build and launch target
    if building.target ~= nil and
       building.target ~= "" then
      config.build_target = building.target
      config.launch_target = building.target
    end
  end

  if build_settings.execution ~= nil then
    local execution = build_settings.execution

    -- working directory
    if execution.cwd ~= nil and
       execution.cwd ~= "" then
      config.base_settings.working_dir = execution.cwd
    end

    -- specify target settings
    if build_settings.building ~= nil then
      local building = build_settings.building

      if building.target ~= nil and
         building.target ~= "" then
        local target = building.target
        local target_settings = {}

        -- executable arguments
        if execution.args ~= nil and
           execution.args ~= "" then
          target_settings["args"] = execution.args
        end

        -- executable environment variables
        if execution.envs ~= nil and
           execution.envs ~= "" then
          target_settings["env"] = execution.envs
        end

        config.target_settings[target] = target_settings
      end
    end
  end

end

return M
