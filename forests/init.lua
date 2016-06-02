local jungle_sound_counter = 0
local jungle_sound_timer = 0
local jungle_sound_last_time = os.clock()
minetest.register_abm({
  nodenames = {"default:jungletree"},
  neighbors = {"default:jungleleaves"},
  interval = 10,
  chance = 5000,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if jungle_sound_timer > 10 then
      minetest.sound_play("ambplus_jungle", {
        pos = pos,
        catch_up = false,
        max_hear_distance = 45,
        gain = 1,
      })
      jungle_sound_timer = 0
    end
    jungle_sound_timer = jungle_sound_timer + os.clock() - jungle_sound_last_time
    jungle_sound_last_time = os.clock()
  end,
})

--~ minetest.register_abm({
  --~ nodenames = {"default:pine_tree"},
  --~ neighbors = {"default:pine_needles"},
  --~ interval = 20,
  --~ chance = 5000,
  --~ action = function(pos, node, active_object_count, active_object_count_wider)
    --~ print('jungleabm')
    --~ minetest.sound_play("ambplus_jungle", {
      --~ pos = pos,
      --~ max_hear_distance = 50,
      --~ gain = 1,
    --~ })
  --~ end,
--~ })
--~ local timer = 0
--~ local counter = 0
--~ minetest.register_globalstep(function(dtime)
  --~ timer = timer + dtime;
  --~ counter = counter +1
  --~ if timer >= 1 then
    --~ -- Send "Minetest" to all players every 5 seconds
    --~ minetest.chat_send_all(counter)
    --~ timer = 0
    --~ counter = 0
  --~ end
--~ end)
