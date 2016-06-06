local jungle_sound_timer = 11
local jungle_sound_last_time = os.clock()
minetest.register_abm({
  nodenames = {"default:jungletree"},
  neighbors = {"default:jungleleaves", "valleys_c:jungleleaves2", "valleys_c:jungleleaves3"},
  interval = 10,
  chance = 5000,
  action = function(pos, node, active_object_count, active_object_count_wider)
    for _,player in ipairs(minetest.get_connected_players()) do
      local ppos = player:getpos()
      -- no new sounds if player is underground. Should use heightmap
      if ppos.y < 0 then return end
    end

    local daytime = minetest.get_timeofday()*24000
    if jungle_sound_timer > 10 then
      if daytime > 5000 and daytime < 19250 then -- day
        minetest.sound_play("ambplus_jungle", {
          pos = pos,
          max_hear_distance = 45,
          gain = 1.5,
        })
      else                                       -- night
        minetest.sound_play("ambplus_jungle_night", {
          pos = pos,
          max_hear_distance = 45,
          gain = 1,
        })
      end
      jungle_sound_timer = 0
    end
    jungle_sound_timer = jungle_sound_timer + os.clock() - jungle_sound_last_time
    jungle_sound_last_time = os.clock()
  end,
})
