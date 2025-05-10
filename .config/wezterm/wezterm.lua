local Config = require 'config'

require('events.status-left').setup()
require('events.status-right').setup()

local config = Config:init()
    :append(require 'config.keys')
    :append(require 'config.ui')
    :append(require 'config.tabs')

return config.options
