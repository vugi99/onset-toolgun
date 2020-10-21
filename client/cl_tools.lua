

local regTool1 = {
    name = "Teleport Tool",
    --Tool_selected_event = "OnTeleportToolSelected",
    --Tool_unselected_event = "OnTeleportToolUnselected",
    Shoot_event = "OnToolgunTeleport",
}
local regTool2 = {
    name = "Spawn Object Tool",
    Shoot_event = "OnToolgunSpawnObject",
    Tool_index_max = 1872
}
local regTool3 = {
    name = "Remove Tool",
    Shoot_event = "OnToolgunDestroyThing"
}
local regTool4 = {
    name = "Explosion Tool",
    Shoot_event = "OnToolgunExplosion",
    Tool_index_max = 20
}
local regTool5 = {
    name = "Fireworks Tool",
    Shoot_event = "OnToolgunFireworks",
    Tool_index_max = 13
}
local regTool6 = {
    name = "Heal Tool",
    Shoot_event = "OnToolgunHeal"
}
local regTool7 = {
    name = "Set Spawn Tool",
    Shoot_event = "OnToolgunSetSpawn"
}

AddEvent("OnPackageStart", function()
   if TeleportTool then
      RegisterTool(regTool1)
   end
   if SpawnObjectTool then
      RegisterTool(regTool2)
   end
   if DestroyTool then
      RegisterTool(regTool3)
   end
   if ExplosionTool then
      RegisterTool(regTool4)
   end
   if FireworksTool then
      RegisterTool(regTool5)
   end
   if HealTool then
      RegisterTool(regTool6)
   end
   if SetSpawnTool then
      RegisterTool(regTool7)
   end
end)

AddEvent("OnToolgunTeleport", function(hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
    if (hitX ~= 0 and hitY ~= 0 and hitZ ~= 0) then
        local plyactor = GetPlayerActor(GetPlayerId())
        plyactor:SetActorLocation(FVector(hitX, hitY, hitZ + 100))
    end
end)

AddEvent("OnToolgunSpawnObject", function(selected, hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
    CallRemoteEvent("RE_OnToolgunSpawnObject", selected, hitX, hitY, hitZ)
end)

AddEvent("OnToolgunDestroyThing", function(hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
    if (hittype == 3 or hittype == 4 or hittype == 5 or hittype == 8) then
       CallRemoteEvent("RE_OnToolgunDestroyThing", hittype, hitid)
    end
end)

AddEvent("OnToolgunExplosion", function(selected, hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
    CallRemoteEvent("RE_OnToolgunExplosion", selected, hitX, hitY, hitZ)
end)

AddEvent("OnToolgunFireworks", function(selected, hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
    CreateFireworks(selected, hitX, hitY, hitZ, 90, 0, 0)
end)

AddEvent("OnToolgunHeal", function(hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
   if (hittype == 2 and hitid ~= GetPlayerId()) then
      CallRemoteEvent("RE_OnToolgunHeal", hitid)
   end
end)

AddEvent("OnToolgunSetSpawn", function(hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
    if (hitX ~= 0 and hitY ~= 0 and hitZ ~= 0) then
        CallRemoteEvent("RE_OnToolgunSetSpawn", hitX, hitY, hitZ)
    end
end)