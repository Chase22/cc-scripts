local dispatch = require "dispatch"
local monitor = require "monitor"
local nameUpdate = require "nameUpdate"

parallel.waitForAll(dispatch, monitor, nameUpdate)