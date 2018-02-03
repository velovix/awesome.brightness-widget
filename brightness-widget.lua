local wibox = require("wibox")
local awful = require("awful")
require("math")
require("string")

local Brightness = { mt = {}, wmt = {} }
Brightness.wmt.__index = Brightness
Brightness.__index = Brightness

config = awful.util.getdir("config")

function Brightness:isXBacklightInstalled()
	local prog = io.popen("xbacklight")
	prog:read('*all')
	local result = {prog:close()}

	return result[3] == 0
end

local function run(command)
	local prog = io.popen(command)
	local result = prog:read('*all')
	prog:close()
	return result
end

function Brightness:new(args)
	local obj = setmetatable({}, Brightness)

	obj.step = args.step or 5
	obj.cmd = args.cmd or "xbacklight"
	obj.inc = args.inc or "-inc"
	obj.dec = args.dec or "-dec"
	obj.set = args.set or "-set"
	obj.get = args.get or "-get"

	-- Create imagebox widget
	obj.widget = wibox.widget.imagebox()
	obj.widget:set_resize(false)
	obj.widget:set_image(config.."/awesome.brightness-widget/icons/4.png")

	-- Add a tooltip to the imagebox
	obj.tooltip = awful.tooltip({ objects = { K },
		timer_function = function() return obj:tooltipText() end } )
	obj.tooltip:add_to_object(obj.widget)

	-- Check the brightness every 5 seconds
	obj.timer = timer({ timeout = 5 })
	obj.timer:connect_signal("timeout", function() obj:update({}) end)
	obj.timer:start()

	obj:update()

	return obj
end

function Brightness:tooltipText()
	return string.sub(self:getBrightness(), 0, 2).."% Brightness"
end

function Brightness:update(status)
	local b = self:getBrightness()
	local img = math.floor((b/100)*7)
	self.widget:set_image(config.."/awesome.brightness-widget/icons/"..img..".png")
end

function Brightness:up()
	run(self.cmd.." "..self.inc.." "..self.step)
	self:update({})
end

function Brightness:down()
	run(self.cmd.." "..self.dec.." "..self.step)
	self:update({})
end

function Brightness:set(val)
	run(self.cmd.." "..self.set.." "..val)
	self:update({})
end

function Brightness:getBrightness()
	return run(self.cmd.." "..self.get)
end

function Brightness.mt:__call(...)
    return Brightness.new(...)
end

return Brightness


