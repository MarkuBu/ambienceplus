local jungle_sound_status = 1
local junglenodelist = {}

minetest.register_abm({
  nodenames = {"default:jungletree"},
  neighbors = {"default:jungleleaves", "valleys_c:jungleleaves2", "valleys_c:jungleleaves3"},
  interval = 10,
  chance = 50,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if jungle_sound_status == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
          end

          local daytime = minetest.get_timeofday()*24000
          local newpos = junglenodelist[math.random(1, #junglenodelist)]
          local nextdirt = minetest.find_node_near(newpos, 15, {"group:soil"})

          if nextdirt ~= nil and ppos ~= nil and newpos ~= nil then
            --local t0_us = minetest.get_us_time()
            local path = true --minetest.find_path(ppos, {x=nextdirt.x, y=nextdirt.y+1, z=nextdirt.z}, 50, 4, 4, "A*")
            --print("Pathfinder", minetest.get_us_time() - t0_us)
            if path ~= nil then
            --print(node.name, #junglenodelist, math.floor(vector.distance(ppos, newpos)+0.5), #path)
              if daytime > 5000 and daytime < 19250 then -- day
                minetest.sound_play("ambplus_jungle", {
                  pos = newpos,
                  max_hear_distance = 60,
                  gain = 1.5 --0.7+1/#path*5,
                })
              else                                       -- night
                minetest.sound_play("ambplus_jungle_night", {
                  pos = newpos,
                  max_hear_distance = 60,
                  gain = 1 --0.5+1/#path*5,
                })
              end
              jungle_sound_status = 0
            end
          end

          jungle_sound_status = 1
          junglenodelist = {}
        end) -- minetest.after() end

      jungle_sound_status = 0
      table.insert(junglenodelist, pos)
    else
      table.insert(junglenodelist, pos)
    end
  end,
})
