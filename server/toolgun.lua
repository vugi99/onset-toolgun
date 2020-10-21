

if Toolgun_Command then
   AddCommand("toolgun", function(ply)
      SetPlayerWeapon(ply, Toolgun_weapon_id, 100000, true, 1, true)
   end)
end