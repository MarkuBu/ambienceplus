local river_sound_timer = 11
local river_sound_last_time = os.clock()
minetest.register_abm({
  nodenames = {"default:river_water_flowing"},
  neighbors = {"default:river_water_flowing"},
  interval = 5,
  chance = 10,
  action = function(pos, node, active_object_count, active_object_count_wider)
    for _,player in ipairs(minetest.get_connected_players()) do
      local ppos = player:getpos()
      -- no new sounds if player is underground. Should use heightmap
      if ppos.y < 0 then return end
    end
    if river_sound_timer > 2 then
      minetest.sound_play("ambplus_river", {
        pos = pos,
        max_hear_distance = 45,
        gain = 0.3,
      })
      river_sound_timer = 0
    end
    river_sound_timer = river_sound_timer + os.clock() - river_sound_last_time
    river_sound_last_time = os.clock()
  end,
})
