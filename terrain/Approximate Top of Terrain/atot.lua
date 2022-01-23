--Approximate Top of Terrain

local module = {}

function module.part2Region(part)
	assert(part and part:IsA('Part'), 'atot.part2Region requires a part')

	local pos = part.Position
	local hSize = part.Size / Vector3.new(2, 2, 2)

	local c1 = pos - hSize
	local c2 = pos + hSize


	local min = c1:Min(c2)
	local max = c1:Max(c2)

	return Region3.new(min, max)
end

function module.atot(terrain, region, resolution)
	local positions = {}

	local rSize = region.Size
	local rPos = region.CFrame.Position

	local min = rPos - (rSize / Vector3.new(2, 2, 2))

	local materials, occupancies = terrain:ReadVoxels(region, resolution)

	local size = materials.Size

	for x = 1, size.X, 1 do
		for z = 1, size.Z do

			for y = size.Y, 1, -1 do
				if materials[x][y][z].Name ~= 'Air' then
					-- xyzPos is the voxel pos * resolution
					-- (voxels to position)
					local xyzPos = Vector3.new(x, y, z) * Vector3.new(4, 4, 4)

					-- oPos is the occupancy of a voxel to y position
					local oPos = Vector3.new(0, 4 * occupancies[x][y][z], 0)

					-- approximate position of the surface of the voxel
					local surfacePos = min + xyzPos + oPos - Vector3.new(2, 2, 2)

					if not positions[x] then
						positions[x] = {}
					end

					positions[x][z] = surfacePos

					break
				end
			end
		end
	end

	return positions
end

return module
