
AddRemoteEvent("RE_OnToolgunSpawnObject", function(ply, selected, hitX, hitY, hitZ)
    CreateObject(selected, hitX, hitY, hitZ)
end)

AddRemoteEvent("RE_OnToolgunDestroyThing", function(ply, hittype, hitid)
    if (hittype == 3 and IsValidVehicle(hitid)) then
       DestroyVehicle(hitid)
    elseif (hittype == 4 and IsValidNPC(hitid)) then
        DestroyNPC(hitid)
    elseif (hittype == 5 and IsValidObject(hitid)) then
        DestroyObject(hitid)
    elseif (hittype == 8 and IsValidDoor(hitid)) then
        DestroyDoor(hitid)
    end
end)

AddRemoteEvent("RE_OnToolgunExplosion", function(ply, selected, hitX, hitY, hitZ)
    CreateExplosion(selected, hitX, hitY, hitZ)
end)

AddRemoteEvent("RE_OnToolgunHeal", function(ply, ply2)
    SetPlayerHealth(ply2, 100)
end)

AddRemoteEvent("RE_OnToolgunSetSpawn", function(ply, x, y, z)
    SetPlayerSpawnLocation(ply, x, y, z + 100, 0)
end)