local module = {}
module.__index = module

function module.getEvent()
	local event = script.Parent:FindFirstChild('event')

	if not event then
		event = Instance.new('RemoteEvent')
		event.Name = 'event'
		event.Parent = script.Parent
	end

	return event
end

module.event = module.getEvent()

function module:FireClient(player: Player, ...)
	self.event = self.getEvent()

	self.event:FireClient(player, self._key, ...)
end

function module:FireAllClients(...)
	self.event = self.getEvent()

	self.event:FireAllClients(self._key, ...)
end

return setmetatable(module, {})
