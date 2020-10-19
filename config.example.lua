-- file : config.lua
local module = {}

module.SSID = "asdf"
module.PASSWORD = "qwerty"

module.HOST = "broker.example.com"
module.PORT = 1884
module.ID = node.chipid()

module.ENDPOINT = string.format ("telegraf/%s/moisture", module.ID)
module.LWT = string.format ("telegraf/%s/lwt", module.ID)

return module