local forest_sound_status = 1
local forestnodelist = {}

minetest.register_abm({
  nodenames = {"default:tree", "default:aspen_tree", "valleys_c:birch_tree", "valleys_c:cherry_blossom_tree", "valleys_c:fir_tree"},
  neighbors = {"group:leaves"},
  interval = 20,
  chance = 20,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if forest_sound_status == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
          end

          local daytime = minetest.get_timeofday()*24000
          local newpos = forestnodelist[math.random(1, #forestnodelist)]
          local nextdirt = minetest.find_node_near(newpos, 15, {"group:soil"})

          if nextdirt ~= nil and ppos ~= nil and newpos ~= nil then
            --local t0_us = minetest.get_us_time()
            local path = true --minetest.find_path(ppos, {x=nextdirt.x, y=nextdirt.y+1, z=nextdirt.z}, 50, 4, 4, "A*")
            --print("Pathfinder", minetest.get_us_time() - t0_us)
            if path ~= nil then
            --print(node.name, #forestnodelist, math.floor(vector.distance(ppos, newpos)+0.5), #path)
              if daytime > 5000 and daytime < 19250 then -- day
                minetest.sound_play("ambplus_forest", {
                  pos = newpos,
                  max_hear_distance = 40,
                  gain = 1 --0.2+1/#path*5,
                })
              else                                       -- night
                minetest.sound_play("ambplus_forest_night", {
                  pos = newpos,
                  max_hear_distance = 40,
                  gain = 1 --0.2+1/#path*5,
                })
              end
              forest_sound_status = 0
            end
          end

          forest_sound_status = 1
          forestnodelist = {}
        end) -- minetest.after() end

      forest_sound_status = 0
      table.insert(forestnodelist, pos)
    else
      table.insert(forestnodelist, pos)
    end

  end,
})



local pine_sound_status = 1
local pinenodelist = {}

minetest.register_abm({
  nodenames = {"default:pine_tree"},
  neighbors = {"group:leaves"},
  interval = 20,
  chance = 40,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if pine_sound_status == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
          end

          local daytime = minetest.get_timeofday()*24000
          local newpos = pinenodelist[math.random(1, #pinenodelist)]
          local nextdirt = minetest.find_node_near(pos, 15, {"group:soil"})

          if nextdirt ~= nil and ppos ~= nil and newpos ~= nil then
            --local t0_us = minetest.get_us_time()
            local path = true --minetest.find_path(ppos, {x=nextdirt.x, y=nextdirt.y+1, z=nextdirt.z}, 50, 4, 4, "A*")
            --print("Pathfinder", minetest.get_us_time() - t0_us)
            if path ~= nil then
            --print("pine", #pinenodelist, math.floor(vector.distance(ppos, newpos)+0.5), #path)
              if daytime > 5000 and daytime < 19250 then -- day
                minetest.sound_play("ambplus_forest", {
                  pos = newpos,
                  max_hear_distance = 40,
                  gain = 1 --0.2+1/#path*5,
                })
              else                                       -- night
                minetest.sound_play("ambplus_forest_night", {
                  pos = newpos,
                  max_hear_distance = 40,
                  gain = 1-- 0.2+1/#path*5,
                })
              end
              pine_sound_status = 0
            end
          end

          pine_sound_status = 1
          pinenodelist = {}
        end) -- minetest.after() end

      pine_sound_status = 0
      table.insert(pinenodelist, pos)
    else
      table.insert(pinenodelist, pos)
    end
  end,
})
