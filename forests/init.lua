local forest_sound_timer = 11
local forest_sound_last_time = os.clock()
minetest.register_abm({
  nodenames = {"default:tree", "default:aspen_tree"},
  neighbors = {"group:leaves"},
  interval = 7,
  chance = 3000,
  action = function(pos, node, active_object_count, active_object_count_wider)
    print(node.name)
    for _,player in ipairs(minetest.get_connected_players()) do
      local ppos = player:getpos()
      -- no new sounds if player is underground. Should use heightmap
      if ppos.y < 0 then return end
    end

    local daytime = minetest.get_timeofday()*24000
    if forest_sound_timer > 10 then
      if daytime > 5000 and daytime < 19250 then -- day
        minetest.sound_play("ambplus_forest", {
          pos = pos,
          catch_up = false,
          max_hear_distance = 45,
          gain = 1,
        })
      else                                       -- night
        minetest.sound_play("ambplus_forest_night", {
          pos = pos,
          catch_up = false,
          max_hear_distance = 45,
          gain = 0.5,
        })
      end
      forest_sound_timer = 0
    end
    forest_sound_timer = forest_sound_timer + os.clock() - forest_sound_last_time
    forest_sound_last_time = os.clock()
  end,
})

local forest_sound_timer = 11
local forest_sound_last_time = os.clock()
minetest.register_abm({
  nodenames = {"default:pine_tree"},
  neighbors = {"group:leaves"},
  interval = 10,
  chance = 4000,
  action = function(pos, node, active_object_count, active_object_count_wider)
    print(node.name)
    for _,player in ipairs(minetest.get_connected_players()) do
      local ppos = player:getpos()
      -- no new sounds if player is underground. Should use heightmap
      if ppos.y < 0 then return end
    end

    local daytime = minetest.get_timeofday()*24000
    if forest_sound_timer > 10 then
      if daytime > 5000 and daytime < 19250 then -- day
        minetest.sound_play("ambplus_forest", {
          pos = pos,
          catch_up = false,
          max_hear_distance = 45,
          gain = 1,
        })
      else                                       -- night
        minetest.sound_play("ambplus_forest_night", {
          pos = pos,
          catch_up = false,
          max_hear_distance = 45,
          gain = 0.5,
        })
      end
      forest_sound_timer = 0
    end
    forest_sound_timer = forest_sound_timer + os.clock() - forest_sound_last_time
    forest_sound_last_time = os.clock()
  end,
})
