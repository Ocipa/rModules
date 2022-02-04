local runService = game:GetService('RunService')
local isClient = runService:IsClient()
local base = require(if isClient then script.Parent.client else script.Parent.server)

local module = {}
module.__index = module

function module:Connect(callback)
	local thread = coroutine.create(function(...)
		local args = {...}

		while true do
			callback(table.unpack(args))

			args = {coroutine.yield(...)}
		end
	end)

	table.insert(self._callbacks, thread)

	return {
		Disconnect = function()
			self._callbacks[table.find(self._callbacks, thread)] = nil
		end,
	}
end

function module:_Fire(...)
	for _, v in pairs(self._callbacks) do
		coroutine.resume(v, ...)
	end
end


function module:__call(key)
	self = setmetatable({}, setmetatable(base, module))

	self._key = key
	self._callbacks = {}

	return self
end

return setmetatable(module, {
	__call = module.__call
})
