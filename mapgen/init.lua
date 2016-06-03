-- Create a table of biome ids, so I can use the biomemap.
local i
local biome_ids = {}
for name, desc in pairs(minetest.registered_biomes) do
  i = minetest.get_biome_id(desc.name)
  biome_ids[i] = desc.name
  print(desc.name)
end

--print(dump(biome_ids))



-- the mapgen function
minetest.register_on_generated(function(minp, maxp, seed)
  local heatmap = minetest.get_mapgen_object("heatmap")
  local heightmap = minetest.get_mapgen_object("heightmap")
  -- The biomemap is a table of biome index numbers for each horizontal
  --  location. It's created in the mapgen, and is right most of the time.
  --  It's off in about 1% of cases, for various reasons.
  -- Bear in mind that biomes can change from one voxel to the next.
  local biomemap = minetest.get_mapgen_object("biomemap")
  local gennotify = minetest.get_mapgen_object("gennotify")
  --print(dump(biomemap))
end)
