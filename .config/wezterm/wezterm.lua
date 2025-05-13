local Config = require 'config'

-- require('events.status-left').setup()
-- require('events.status-right').setup()

return Config:new()
    :append(require 'config.behaviour')
    :append(require 'config.keys')
    :append(require 'config.ui')
    :append(require 'config.tabs')
    :get()
