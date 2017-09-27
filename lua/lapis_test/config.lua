local config_factory = require('lapis.config')

-- copy config_passwords.lua.template to config_passwords.lua and set values!
local config_passwords = require('config_passwords')

-- print(config_passwords.secret)

config_factory("development", {
  port = 9001,
  logging = {
    queries = true, -- default: true
    requests = true -- default: true
  },
  secret = config_passwords.secret,
  session_name = "d9k_lapis_test_session",
  measure_performance = true
})
