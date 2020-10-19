-- file : application.lua
local module = {}

m = nil

function handle_mqtt_error(client, reason)
  tmr.create():alarm(10 * 1000, tmr.ALARM_SINGLE, mqtt_start)
end

function do_work(client)
  tmr.create():alarm(15000, tmr.ALARM_AUTO, function()
    val = adc.read(0)
    client:publish(config.ENDPOINT, val, 0, 0, function() print(val) end)
  end)
end

function mqtt_start()

  m = mqtt.Client(config.ID, 120)

  m:lwt(config.LWT, "0", 0, 0)

  m:on("connect", do_work)
  m:on("connfail", handle_mqtt_error)
  m:on("offline", function(client) print ("offline") end)

  -- on publish message receive event
  m:on("message", function(client, topic, data)
    print(topic .. ":" )
    if data ~= nil then
      print(data)
    end
  end)

  -- on publish overflow receive event
  m:on("overflow", function(client, topic, data)
    print(topic .. " partial overflowed message: " .. data )
  end)

  m:connect(config.HOST, config.PORT, false, nil, handle_mqtt_error)

end

function module.start()
  mqtt_start()
end

return module