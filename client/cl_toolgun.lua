
local ToolgunTools = {}
local toolselected = nil
local index_selected = nil
local toolgun_equipped = false

AddEvent("OnPackageStart", function()
    Weapon = GetWeaponIdentifier():NewWeapon(Toolgun_weapon_id)
    Weapon:SetWeaponType(1)
    Weapon:SetWeaponSubType(1)
    Weapon:SetWeaponModel(USkeletalMesh.LoadFromAsset("/Game/Weapons/Meshes/Pistol03/SK_Pistol03"))
    Weapon:SetStaticWeaponModel(UStaticMesh.LoadFromAsset("/Game/Weapons/Meshes/Pistol03/SM_Pistol03"))
    Weapon:SetMeshScale(FVector(1.100000, 1.100000, 1.100000))
    Weapon:SetEquipTime(0.23)
    Weapon:SetUnequipTime(0.45)
    Weapon:SetAimWalkSpeed(170.0)
    Weapon:SetCameraAimTargetOffset(FVector(170.000000, 65.000000, 14.000000))
    Weapon:SetCameraAimFoV(65.0)
    Weapon:SetAimBlendTime(0.35)
    Weapon:SetRange(13000.0)
    Weapon:SetRecoil(0.0)
    Weapon:SetCameraShake(0.0)
    Weapon:SetCameraShakeCrouching(0.0)
    Weapon:SetSpreadMin(0.1)
    Weapon:SetSpreadMax(0.2)
    Weapon:SetSpreadMovementModifier(0.2)
    Weapon:SetSpreadCrouchingModifier(-0.3)
    Weapon:SetRateOfFire(150.0)
    Weapon:SetMagazineModel(nil)
    Weapon:SetMagazineSize(100)
    Weapon:SetMagazineDropTime(0.0)
    Weapon:SetScope(false)
    Weapon:SetShotSound(USoundCue.LoadFromAsset("/Game/Weapons/Sounds/Cues/HZPistol03_Cue"))
    Weapon:SetShotAnimation(UAnimSequence.LoadFromAsset("/Game/Weapons/Animations/A_Pistol03_Fire"))
    Weapon:SetShotAnimationTime(0.3)
    Weapon:SetMuzzleFlash(UParticleSystem.LoadFromAsset("/Game/Weapons/VFX/Particles/Weapons/PS_Pistol"))
    Weapon:SetShellDelay(0.0)
    Weapon:SetProjectileShell(UParticleSystem.LoadFromAsset("/Game/Weapons/VFX/Particles/Shells/P_Shell"))
    Weapon:SetShellSmoke(UParticleSystem.LoadFromAsset("/Game/Weapons/VFX/Impacts/Particles/P_ShellSmoke"))
    Weapon:SetAttachmentLocationModifier(FVector(-9.619288, 3.477018, 1.700000))
    Weapon:SetAttachmentRotationModifier(FRotator(10.565318, 86.711197, 10.886045))
    Weapon:SetReloadAnimation(UAnimSequence.LoadFromAsset("/Game/Weapons/Animations/A_Pistol03_Reload"))
    Weapon:SetReloadAnimationTime(0.96)
    Weapon:SetCharacterReloadAnimation(UAnimSequence.LoadFromAsset("/Game/Character/Animations/Handgun/A_HG_Reload"))
    Weapon:SetLeftHandIKLocation(FVector(-2.000000, 9.000000, -5.000000))
    Weapon:SetLeftHandARIdleIKLocation(FVector(0.000000, 0.000000, 0.000000))
    Weapon:SetLeftHandARIdleIKLocationCrouching(FVector(0.000000, 0.000000, 0.000000))
    Weapon:SetHUDImage(UTexture2D.LoadFromAsset("/Game/Weapons/Images/T_Pistol03"))
    Weapon:SetAllowAimWhileCrouching(true)
    Weapon:SetZoomInSound(nil)
    Weapon:SetZoomOutSound(nil)
    Weapon:SetEquipSound(USoundCue.LoadFromAsset("/Game/Character/Sounds/Holster/Equip_Fabric_1_A_Cue"))
    Weapon:SetUnequipSound(USoundCue.LoadFromAsset("/Game/Character/Sounds/Holster/UnEquip_Fabric_1_A_Cue1"))
    Weapon:SetReloadStartSound(USoundCue.LoadFromAsset("/Game/Weapons/Sounds/Cues/HZRemoveMag_Cue"))
    Weapon:SetReloadEndSound(USoundCue.LoadFromAsset("/Game/Weapons/Sounds/Cues/HZInsertMag_Cue"))
    Weapon:SetNoAmmoSound(USoundCue.LoadFromAsset("/Game/Weapons/Sounds/Cues/HZEmptyMag_Cue"))
    GetWeaponIdentifier():RegisterWeapon(Weapon)
end)

function RegisterTool(tool)
    table.insert(ToolgunTools, tool)
    toolselected = 1
    index_selected = 1
end
AddFunctionExport("RegisterTool", RegisterTool)

local function table_count(tbl)
    local nb = 0
    for k, v in pairs(tbl) do
       nb = nb + 1
    end
    return nb
end

AddEvent("OnKeyPress", function(key)
   if (GetPlayerWeapon(GetPlayerEquippedWeaponSlot(GetPlayerId())) == Toolgun_weapon_id and toolselected) then
       if (key == "Mouse Wheel Down" and ToolgunTools[toolselected].Tool_table) then
            if index_selected - 1 == 0 then
               index_selected = table_count(ToolgunTools[toolselected].Tool_table)
            else
                index_selected = index_selected - 1
            end
       elseif (key == "Mouse Wheel Down" and ToolgunTools[toolselected].Tool_index_max) then
            if index_selected - 1 == 0 then
                index_selected = ToolgunTools[toolselected].Tool_index_max
            else
                index_selected = index_selected - 1
            end
       elseif (key == "Mouse Wheel Up" and ToolgunTools[toolselected].Tool_table) then
            if index_selected == table_count(ToolgunTools[toolselected].Tool_table) then
                index_selected = 1
            else
                index_selected = index_selected + 1
            end
       elseif (key == "Mouse Wheel Up" and ToolgunTools[toolselected].Tool_index_max) then
            if index_selected == ToolgunTools[toolselected].Tool_index_max then
                index_selected = 1
            else
                index_selected = index_selected + 1
            end
      elseif key == "Middle Mouse Button" then
            if ToolgunTools[toolselected].Tool_unselected_event then
               CallEvent(ToolgunTools[toolselected].Tool_unselected_event)
            end
            if toolselected == table_count(ToolgunTools) then
                toolselected = 1
            else
                toolselected = toolselected + 1
            end
            index_selected = 1
            if ToolgunTools[toolselected].Tool_selected_event then
               CallEvent(ToolgunTools[toolselected].Tool_selected_event)
            end
       end
   end
end)

AddEvent("OnRenderHUD", function()
   if GetPlayerWeapon(GetPlayerEquippedWeaponSlot(GetPlayerId())) == Toolgun_weapon_id then
      if not toolgun_equipped then
         toolgun_equipped = true
         if ToolgunTools[toolselected].Tool_selected_event then
            CallEvent(ToolgunTools[toolselected].Tool_selected_event)
         end
      end
      if toolselected then
        local tool = ToolgunTools[toolselected]
        DrawText(1, 300, tool.name)
        DrawText(1, 350, "Press the Middle Mouse Button to change the selected tool")
        if tool.Tool_table then
            DrawText(1, 320, "Selected : " .. tostring(tool.Tool_table[index_selected]))
            DrawText(1, 370, "Use The Mouse Wheel to change the selected value")
        elseif tool.Tool_index_max then
            DrawText(1, 320, "Selected : " .. tostring(index_selected))
            DrawText(1, 370, "Use The Mouse Wheel to change the selected value")
        end
      end
   elseif toolgun_equipped then
      toolgun_equipped = false
      if ToolgunTools[toolselected].Tool_unselected_event then
         CallEvent(ToolgunTools[toolselected].Tool_unselected_event)
      end
      index_selected = 1
   end
end)

AddEvent("OnPlayerWeaponShot", function(hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
    if (GetPlayerWeapon(GetPlayerEquippedWeaponSlot(GetPlayerId())) == Toolgun_weapon_id and toolselected) then
        if ToolgunTools[toolselected].Tool_table then
           CallEvent(ToolgunTools[toolselected].Shoot_event, index_selected, ToolgunTools[toolselected].Tool_table[index_selected], hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
        elseif ToolgunTools[toolselected].Tool_index_max then
            CallEvent(ToolgunTools[toolselected].Shoot_event, index_selected, hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
        else
            CallEvent(ToolgunTools[toolselected].Shoot_event, hittype, hitid, hitX, hitY, hitZ, startX, startY, startZ, normalX, normalY, normalZ, BoneName)
        end
    end
end)