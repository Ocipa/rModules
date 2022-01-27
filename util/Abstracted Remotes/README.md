# Abstracted Remotes

> Made for personal use, if you have a use for it, feel free to use it for what the repository [license]() permits.

This module further abstracts remote events and functions. Why? Why not.

## API

```lua
aRemote.name:Connect(callback)
-- name: name of event to connect to
-- callback(function): the function to call when event [name] is fired

--> returns(Listener): returns a listener for when event [name] is fired
```
```lua
Listener:Disconnect()
--> returns: nil
```
```lua
aRemote.name:FireServer(...)
--> returns: nil
```
```lua
aRemote.name:FireClient(player, ...)
--> player(Player): player to fire remote event to

--> returns: nil
```
```lua
aRemote.name:FireAllClients(...)
--> returns: nil
```
```lua
aRemote:GetKeys()
--> returns(Table): a table of keys and their metatables
```

## Quick Use

```lua
-- Client Script
local replicatedStorage = game:GetService('ReplicatedStorage')
local aRemote = require(replicatedStorage.aRemote)

aRemote.TestEvent:FireServer('Hello World!')
```

```lua
-- Server Script
local replicatedStorage = game:GetService('ReplicatedStorage')
local aRemote = require(replicatedStorage.aRemote)

aRemote.TestEvent:Connect(function(...)
	print(...) --> prints 'Hello World!'
end)
```