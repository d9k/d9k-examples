local config_factory = require("lapis.config")

config_factory("development", {
  port = 9001,
--  logging = {
--    queries = true,
--    requests = true
--  },
--  secret = "please-change-me",
--  session_name = "lapis_session",
--  measure_performance = true
})
