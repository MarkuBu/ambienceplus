local forest_sound_timer = 1

local forestnodelist = {}

minetest.register_abm({
  nodenames = {"default:tree", "default:aspen_tree"},
  neighbors = {"group:leaves"},
  interval = 15,
  chance = 20,
  catch_up = false,
  action = function(pos, node, active_object_count, active_object_count_wider)
    --print(node.name)
    --minetest.set_node(pos, {name="default:meselamp"})
    if forest_sound_timer == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
            -- no new sounds if player is underground. Should use heightmap
          end
      print("tree")
          local daytime = minetest.get_timeofday()*24000
          local newpos = forestnodelist[math.random(1, #forestnodelist)]
          local nextdirt = minetest.find_node_near(newpos, 15, {"group:soil"})
          if nextdirt and ppos then

            local path = minetest.find_path(ppos, {x=nextdirt.x, y=nextdirt.y+1, z=nextdirt.z}, 70, 10, 10, "A*_noprefetch")
            if path then
              if daytime > 5000 and daytime < 19250 then -- day
                minetest.sound_play("ambplus_forest", {
                  pos = newpos,
                  max_hear_distance = 45,
                  gain = 1,
                })
              else                                       -- night
                minetest.sound_play("ambplus_forest_night", {
                  pos = newpos,
                  max_hear_distance = 45,
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
    --print(node.name)
    --minetest.set_node(pos, {name="default:meselamp"})
    if pine_sound_timer == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
            -- no new sounds if player is underground. Should use heightmap
          end
      print("pine")
          local daytime = minetest.get_timeofday()*24000
          local newpos = pinenodelist[math.random(1, #pinenodelist)]
          local nextdirt = minetest.find_node_near(pos, 15, {"group:soil"})
          if nextdirt and ppos then
            local path = minetest.find_path(ppos, {x=nextdirt.x, y=nextdirt.y+1, z=nextdirt.z}, 70, 10, 10, "A*_noprefetch")
            if path then
              if daytime > 5000 and daytime < 19250 then -- day
                minetest.sound_play("ambplus_forest", {
                  pos = newpos,
                  max_hear_distance = 45,
                  gain = 1,
                })
              else                                       -- night
                minetest.sound_play("ambplus_forest_night", {
                  pos = newpos,
                  max_hear_distance = 45,
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
