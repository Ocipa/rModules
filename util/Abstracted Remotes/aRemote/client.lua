local module = {}
module.__index = module

function module.getEvent()
	local event = script.Parent:WaitForChild('event')

	return event
end

module.event = module.getEvent()

function module:FireServer(...)
	self.event = self.getEvent()

	self.event:FireServer(self._key, ...)
end

return setmetatable(module, {})
