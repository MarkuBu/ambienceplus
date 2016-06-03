local ocean_sound_timer = 11
local ocean_sound_last_time = os.clock()

minetest.register_abm({
  -- only nodes at the surface
  nodenames = {"default:water_source"},
  neighbors = {"default:air"},
  interval = 20,
  chance = 100,
  action = function(pos, node, active_object_count, active_object_count_wider)
    for _,player in ipairs(minetest.get_connected_players()) do
      local ppos = player:getpos()
      -- no new sounds if player is underground. Should use heightmap
      if ppos.y < 0 then return end
    end
    -- don't play ocean sounds in a puddle
    local node1 = minetest.get_node({x=pos.x, y=pos.y, z=pos.z-10})
    local node2 = minetest.get_node({x=pos.x, y=pos.y, z=pos.z+10})
    local node3 = minetest.get_node({x=pos.x-10, y=pos.y, z=pos.z})
    local node4 = minetest.get_node({x=pos.x+10, y=pos.y, z=pos.z})

    -- skip some ABM calls and play sounds only at sea level
    if ocean_sound_timer > 8 and pos.y == 1
      and node1.name == "default:water_source"
      and node2.name == "default:water_source"
      and node3.name == "default:water_source"
      and node4.name == "default:water_source" then
      minetest.sound_play("ambplus_ocean", {
        pos = pos,
        catch_up = false,
        max_hear_distance = 60,
        gain = 1.5,
      })
      ocean_sound_timer = 0
    end
    ocean_sound_timer = ocean_sound_timer + os.clock() - ocean_sound_last_time
    ocean_sound_last_time = os.clock()
  end,
})
