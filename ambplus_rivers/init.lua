local river_sound_timer = 1
local rivernodelist = {}

minetest.register_abm({
  nodenames = {"default:river_water_flowing"},
  neighbors = {"default:river_water_flowing"},
  interval = 15,
  chance = 20,
  catch_up = false,

  action = function(pos, node, active_object_count, active_object_count_wider)

    if river_sound_timer == 1 then
      minetest.after(1,  function()
          local ppos
          for _,player in ipairs(minetest.get_connected_players()) do
            ppos = player:getpos()
            -- no new sounds if player is underground. Should use heightmap
          end
          if ppos.y > -5 then
            local newpos = rivernodelist[math.random(1, #rivernodelist)]
            if newpos then
              --minetest.set_node(newpos, {name="default:meselamp"})
              minetest.sound_play("ambplus_river", {
                pos = newpos,
                max_hear_distance = 45,
                gain = 0.8,
              })
            end
          end
          river_sound_timer = 1
          rivernodelist = {}
        end)
      river_sound_timer = 0
      table.insert(rivernodelist, pos)
    else
      table.insert(rivernodelist, pos)
    end

  end,
})
