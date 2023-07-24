local dispatch = require "dispatch"
local monitor = require "monitorVault"
local nameUpdate = require "nameUpdate"

parallel.waitForAll(dispatch, monitor, nameUpdate)