local lapis = require('lapis')
local config_factory = require('lapis.config')

local to_json = require('lapis.util').to_json
local after_dispatch = require('lapis.nginx.context').after_dispatch

config_factory("development", {
--  port = 9001,
--  logging = {
--    queries = true,
--    requests = true
--  },
--  secret = "please-change-me",
--  session_name = "lapis_session",
  measure_performance = true
})

local app = lapis.Application()

print([===[   ////NOTICE ME!////   ]===])

app:get("/", function()
  return "Welcome to Lapis " .. require("lapis.version")
end)

local is_dev_env = function()
  config = config_factory.get()
  return config._name == "development"
end

app:get("/lua_debug", function()
  require('mobdebug').start()
  local name = ngx.var.arg_name or "Anonymous"
  ngx.say("Hello, ", name, "!")
  ngx.say("Done debugging.")
  require('mobdebug').done()
  config = config_factory.get()
  ngx.say(config._name)
end)

if is_dev_env() then
  app:before_filter(function(self)
    after_dispatch(function()
      print('performance: ', to_json(ngx.ctx.performance))
--      print('performance: ', to_json({test = 123}))
    end) -- after_dispatch
  end) -- app:before_filter
end -- is_dev_enf

return app
