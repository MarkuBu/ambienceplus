local forest_sound_timer = 11
local forest_sound_last_time = os.clock()
local ppos
minetest.register_abm({
  nodenames = {"default:tree", "default:aspen_tree"},
  neighbors = {"group:leaves"},
  interval = 10,
  chance = 200,
  action = function(pos, node, active_object_count, active_object_count_wider)
    print(node.name)
    for _,player in ipairs(minetest.get_connected_players()) do
      ppos = player:getpos()
      -- no new sounds if player is underground. Should use heightmap
      --if ppos.y < 0 then return end
    end

    local daytime = minetest.get_timeofday()*24000
    if forest_sound_timer > 2 then
      local nextair = minetest.find_node_near(pos, 15, {"group:soil"})
      if nextair and ppos then
        local path = minetest.find_path(ppos, {x=nextair.x, y=nextair.y+1, z=nextair.z}, 70, 10, 10, "A*_noprefetch")
        if path then
          if daytime > 5000 and daytime < 19250 then -- day
            minetest.sound_play("ambplus_forest", {
              pos = pos,
              max_hear_distance = 45,
              gain = 1,
            })
          else                                       -- night
            minetest.sound_play("ambplus_forest_night", {
              pos = pos,
              max_hear_distance = 45,
              gain = 1,
            })
          end
          forest_sound_timer = 0
        end
      end
    end
    forest_sound_timer = forest_sound_timer + os.clock() - forest_sound_last_time
    forest_sound_last_time = os.clock()
  end,
})

local pine_sound_timer = 11
local pine_sound_last_time = os.clock()
minetest.register_abm({
  nodenames = {"default:pine_tree"},
  neighbors = {"group:leaves"},
  interval = 10,
  chance = 500,
  action = function(pos, node, active_object_count, active_object_count_wider)
    print(node.name)
    for _,player in ipairs(minetest.get_connected_players()) do
      ppos = player:getpos()
      -- no new sounds if player is underground. Should use heightmap
      --if ppos.y < 0 then return end
    end

    local daytime = minetest.get_timeofday()*24000
    if pine_sound_timer > 2 then
      local nextair = minetest.find_node_near(pos, 15, {"group:soil"})
      if nextair and ppos then
        local path = minetest.find_path(ppos, {x=nextair.x, y=nextair.y+1, z=nextair.z}, 70, 10, 10, "A*_noprefetch")
        if path then
          if daytime > 5000 and daytime < 19250 then -- day
            minetest.sound_play("ambplus_forest", {
              pos = pos,
              max_hear_distance = 45,
              gain = 1,
            })
          else                                       -- night
            minetest.sound_play("ambplus_forest_night", {
              pos = pos,
              max_hear_distance = 45,
              gain = 1,
            })
          end
          pine_sound_timer = 0
        end
      end
    end
    pine_sound_timer = pine_sound_timer + os.clock() - pine_sound_last_time
    pine_sound_last_time = os.clock()
  end,
})
