
local runService = game:GetService('RunService')
local isClient = runService:IsClient()
local base = require(if isClient then script.client else script.server)

local bindable = require(script.bindable)

local event = base.getEvent()


local module = {}
module.__index = module

local keys = {}

function module:GetKeys()
	return keys
end

function module:_gc()
	for i, v in pairs(keys) do
		if #v['_callbacks'] == 0 then
			keys[i] = nil
		end
	end
end

if isClient then
	event.OnClientEvent:Connect(function(key, ...)
		if keys[key] then
			keys[key]:_Fire(...)
		end
	end)
else
	event.OnServerEvent:Connect(function(player, key, ...)
		if keys[key] then
			keys[key]:_Fire(...)
		end
	end)
end

function module:__index(key)
	self:_gc()

	if not keys[key] then
		keys[key] = bindable(key)
	end

	return keys[key]
end


return setmetatable(module, {
	__index = module.__index
})
