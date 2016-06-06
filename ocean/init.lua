local ocean_sound_timer = 1
local water_level = tonumber(minetest.setting_get("water_level"))

local nodelist = {}

-- don't play ocean sounds in a puddle
local function is_large(pos, size)
  local node1 = minetest.get_node({x=pos.x, y=pos.y, z=pos.z-size})
  local node2 = minetest.get_node({x=pos.x, y=pos.y, z=pos.z+size})
  local node3 = minetest.get_node({x=pos.x-size, y=pos.y, z=pos.z})
  local node4 = minetest.get_node({x=pos.x+size, y=pos.y, z=pos.z})
  if node1.name == "default:water_source"
     and node2.name == "default:water_source"
     and node3.name == "default:water_source"
     and node4.name == "default:water_source" then
     return true
  else
    return false
  end
end


minetest.register_abm({
  -- only nodes at the surface
  nodenames = {"default:water_source"},
  neighbors = {"air"},
  interval = 10,
  chance = 100,
  action = function(pos, node, active_object_count, active_object_count_wider)

    if ocean_sound_timer == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
            -- no new sounds if player is underground. Should use heightmap
          end
          if ppos.y > -5 then
            local newpos = nodelist[math.random(1, #nodelist)]
            if newpos and is_large(newpos, 5) then
              minetest.sound_play("ambplus_lake", {
                pos = newpos,
                max_hear_distance = 70,
                gain = 1.5,
              })
            end
          end
          ocean_sound_timer = 1
          nodelist = {}
        end)
      ocean_sound_timer = 0
      table.insert(nodelist, pos)
    else
      table.insert(nodelist, pos)
    end

  end,
})
