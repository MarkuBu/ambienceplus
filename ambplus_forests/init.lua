local forest_sound_timer = 1

local forestnodelist = {}

minetest.register_abm({
  nodenames = {"default:tree", "default:aspen_tree", "valleys_c:birch_tree", "valleys_c:cherry_blossom_tree", "valleys_c:fir_tree"},
  neighbors = {"group:leaves"},
  interval = 15,
  chance = 20,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if forest_sound_timer == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
          end
          local daytime = minetest.get_timeofday()*24000
          local newpos = forestnodelist[math.random(1, #forestnodelist)]
          local nextdirt = minetest.find_node_near(newpos, 15, {"group:soil"})
          if nextdirt ~= nil and ppos ~= nil and newpos ~= nil then
            local path = minetest.find_path(ppos, {x=nextdirt.x, y=nextdirt.y+1, z=nextdirt.z}, 50, 10, 10, "A*_noprefetch")

            if path ~= nil then
            print(node.name, #forestnodelist, vector.distance(ppos, newpos))
              if daytime > 5000 and daytime < 19250 then -- day
                minetest.sound_play("ambplus_forest", {
                  pos = newpos,
                  max_hear_distance = 60,
                  gain = 1,
                })
              else                                       -- night
                minetest.sound_play("ambplus_forest_night", {
                  pos = newpos,
                  max_hear_distance = 60,
                  gain = 1,
                })
              end
              forest_sound_timer = 0
            end
          end

          forest_sound_timer = 1
          forestnodelist = {}
        end) -- minetest.after() end

      forest_sound_timer = 0
      table.insert(forestnodelist, pos)
    else
      table.insert(forestnodelist, pos)
    end

  end,
})



local pine_sound_timer = 1
local pinenodelist = {}

minetest.register_abm({
  nodenames = {"default:pine_tree"},
  neighbors = {"group:leaves"},
  interval = 15,
  chance = 40,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if pine_sound_timer == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
          end
          local daytime = minetest.get_timeofday()*24000
          local newpos = pinenodelist[math.random(1, #pinenodelist)]
          local nextdirt = minetest.find_node_near(pos, 15, {"group:soil"})
          if nextdirt ~= nil and ppos ~= nil and newpos ~= nil then
            local path = minetest.find_path(ppos, {x=nextdirt.x, y=nextdirt.y+1, z=nextdirt.z}, 50, 10, 10, "A*_noprefetch")

            if path ~= nil then
            print("pine", #pinenodelist, vector.distance(ppos, newpos))
              if daytime > 5000 and daytime < 19250 then -- day
                minetest.sound_play("ambplus_forest", {
                  pos = newpos,
                  max_hear_distance = 60,
                  gain = 1,
                })
              else                                       -- night
                minetest.sound_play("ambplus_forest_night", {
                  pos = newpos,
                  max_hear_distance = 60,
                  gain = 1,
                })
              end
              pine_sound_timer = 0
            end
          end

          pine_sound_timer = 1
          pinenodelist = {}
        end) -- minetest.after() end

      pine_sound_timer = 0
      table.insert(pinenodelist, pos)
    else
      table.insert(pinenodelist, pos)
    end
  end,
})
