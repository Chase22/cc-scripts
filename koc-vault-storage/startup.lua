local dispatch = require "dispatch"
local monitor = require "monitor"

parallel.waitForAll(dispatch, monitor)