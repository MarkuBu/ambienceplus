local ocean_sound_status = 1
local water_level = tonumber(minetest.setting_get("water_level"))

local oceannodelist = {}

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
  interval = 15,
  chance = 20,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if ocean_sound_status == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
          end

          if ppos.y > -5 then
            local daytime = minetest.get_timeofday()*24000
            local newpos = oceannodelist[math.random(1, #oceannodelist)]
            if newpos ~= nil then
              if daytime > 5000 and daytime < 19250 then -- day

              --print("ocean", #oceannodelist, math.floor(vector.distance(ppos, newpos)+0.5))
                minetest.sound_play("ambplus_lake", {
                  pos = newpos,
                  max_hear_distance = 80,
                  gain = 2,
                })
                if math.random(1, 5) == 1 then  -- play randomly seagulls at day
                  minetest.sound_play("ambplus_seagulls", {
                    pos = newpos,
                    max_hear_distance = 80,
                    gain = 2,
                  })
                end
              else
                minetest.sound_play("ambplus_lake", {
                  pos = newpos,
                  max_hear_distance = 80,
                  gain = 2,
                })              end
            end
          end
          ocean_sound_status = 1
          oceannodelist = {}
        end)
      ocean_sound_status = 0
      if  is_large(pos, 8) then
        table.insert(oceannodelist, pos)
      end
    else
      if  is_large(pos, 8) then
        table.insert(oceannodelist, pos)
      end
    end

  end,
})
