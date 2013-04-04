--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    weapondefs_post.lua
--  brief:   weaponDef post processing
--  author:  Dave Rodgers
--
--  Copyright (C) 2008.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  Per-unitDef weaponDefs
--

local function isbool(x)   return (type(x) == 'boolean') end
local function istable(x)  return (type(x) == 'table')   end
local function isnumber(x) return (type(x) == 'number')  end
local function isstring(x) return (type(x) == 'string')  end

local function tobool(val)
  local t = type(val)
  if (t == 'nil') then
    return false
  elseif (t == 'boolean') then
    return val
  elseif (t == 'number') then
    return (val ~= 0)
  elseif (t == 'string') then
    return ((val ~= '0') and (val ~= 'false'))
  end
  return false
end

--------------------------------------------------------------------------------

local function BackwardCompability(wdName,wd)
  -- weapon reloadTime and stockpileTime were seperated in 77b1
  if (tobool(wd.stockpile) and (wd.stockpiletime==nil)) then
    wd.stockpiletime = wd.reloadtime
    wd.reloadtime    = 2             -- 2 seconds
  end

  -- auto detect ota weapontypes
  if (wd.weapontype==nil) then
    local rendertype = tonumber(wd.rendertype) or 0
    if (tobool(wd.dropped)) then
      wd.weapontype = "AircraftBomb";
    elseif (tobool(wd.vlaunch)) then
      wd.weapontype = "StarburstLauncher";
    elseif (tobool(wd.beamlaser)) then
      wd.weapontype = "BeamLaser";
    elseif (tobool(wd.isshield)) then
      wd.weapontype = "Shield";
    elseif (tobool(wd.waterweapon)) then
      wd.weapontype = "TorpedoLauncher";
    elseif (wdName:lower():find("disintegrator",1,true)) then
      wd.weaponType = "DGun"
    elseif (tobool(wd.lineofsight)) then
      if (rendertype==7) then
        wd.weapontype = "LightningCannon";

      -- swta fix (outdated?)
      elseif (wd.model and wd.model:lower():find("laser",1,true)) then
        wd.weapontype = "LaserCannon";

      elseif (tobool(wd.beamweapon)) then
        wd.weapontype = "LaserCannon";
      elseif (tobool(wd.smoketrail)) then
        wd.weapontype = "MissileLauncher";
      elseif (rendertype==4 and tonumber(wd.color)==2) then
        wd.weapontype = "EmgCannon";
      elseif (rendertype==5) then
        wd.weapontype = "Flame";
      --elseif(rendertype==1) then
      --  wd.weapontype = "MissileLauncher";
      else
        wd.weapontype = "Cannon";
      end
    else
      wd.weapontype = "Cannon";
    end
  end

  weapondamage = tonumber(wd.damage.default)
  if (weapondamage > 0) then
		if (wd.customparams) then
		local damagetypelower = string.lower(wd.customparams.damagetype)
-- hovers
		if (damagetypelower == "raider") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*2
			elseif (damagetypelower == "flametankraider") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*4
				
			elseif (damagetypelower == "raiderlight") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*2
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "tankdestroyermediumtank") then
				wd.damage.ARMORED = 		weapondamage*2
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "tankdestroyer") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
				
			elseif (damagetypelower	== "tankdestroyeramphib") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.25
				
			elseif (damagetypelower	== "heavytankdestroyer") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.5
				
			elseif (damagetypelower	== "armoredtankdestroyer") then
				wd.damage.ARMORED = 		weapondamage*2
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "riot") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*2
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "antibuilding") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*2
				
			elseif (damagetypelower	== "antibuildingkrab") then
				wd.damage.ARMORED = 		weapondamage*0.1
				wd.damage.LIGHT = 			weapondamage*0.1
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "antibuildinglobster") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*4
				
			elseif (damagetypelower	== "antibuildingassimilator") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*4
			
			elseif (damagetypelower	== "antibuildingfatso") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*8
			
			elseif (damagetypelower	== "antibuildingallterrassault") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*8
				
			elseif (damagetypelower	== "hoverbomb") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*4
				
			elseif (damagetypelower	== "antiair") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
-- turrets
			elseif (damagetypelower	== "antilight") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*4
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "antilightturret") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*4
				wd.damage.BUILDING  = 		weapondamage*0.1
				
			elseif (damagetypelower	== "antiarmored") then
				wd.damage.ARMORED = 		weapondamage*2
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "antiairturret") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "heavytankdestroyerturret") then
				wd.damage.ARMORED = 		weapondamage*6
				wd.damage.LIGHT = 			weapondamage*3
				wd.damage.BUILDING  = 		weapondamage*0.1
			
			elseif (damagetypelower	== "lrpc") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*4
				
-- aircraft
			elseif (damagetypelower	== "gunshipdrone") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1.5
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "fighter") then
				wd.damage.ARMORED = 		weapondamage*1.5
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
			elseif (damagetypelower	== "bomber") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*8
				
			elseif (damagetypelower	== "gunship") then
				wd.damage.ARMORED = 		weapondamage*4
				wd.damage.LIGHT = 			weapondamage*4
				wd.damage.BUILDING  = 		weapondamage*1
				
-- all terrain
-- amphib

-- destroyers
			elseif (damagetypelower	== "destroyertankkiller") then
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*0.1
				
			elseif (damagetypelower	== "destroyerbuildingkiller") then
				wd.damage.ARMORED = 		weapondamage*0.1
				wd.damage.LIGHT = 			weapondamage*0.1
				wd.damage.BUILDING  = 		weapondamage*2

			else -- medium weapon
				wd.damage.ARMORED = 		weapondamage*1
				wd.damage.LIGHT = 			weapondamage*1
				wd.damage.BUILDING  = 		weapondamage*1
				
			end
		end
  end
  
  
  
  -- 
  if (tobool(wd.ballistic) or tobool(wd.dropped)) then
    wd.gravityaffected = true
  end
end

--------------------------------------------------------------------------------

local function ProcessUnitDef(udName, ud)

  local wds = ud.weapondefs
  if (not istable(wds)) then
    return
  end

  -- add this unitDef's weaponDefs
  for wdName, wd in pairs(wds) do
    if (isstring(wdName) and istable(wd)) then
      local fullName = udName .. '_' .. wdName
      WeaponDefs[fullName] = wd
      wd.filename = ud.filename
    end
  end

  -- convert the weapon names
  local weapons = ud.weapons
  if (istable(weapons)) then
    for i = 1, 32 do
      local w = weapons[i]
      if (istable(w)) then
        if (isstring(w.def)) then
          local ldef = string.lower(w.def)
          local fullName = udName .. '_' .. ldef
          local wd = WeaponDefs[fullName]
          if (istable(wd)) then
            w.name = fullName
          end
        end
        w.def = nil
      end
    end
  end

  -- convert the death explosions
  if (isstring(ud.explodeas)) then
    local fullName = udName .. '_' .. ud.explodeas
    if (WeaponDefs[fullName]) then
      ud.explodeas = fullName
    end
  end
  if (isstring(ud.selfdestructas)) then
    local fullName = udName .. '_' .. ud.selfdestructas
    if (WeaponDefs[fullName]) then
      ud.selfdestructas = fullName
    end
  end
end

--------------------------------------------------------------------------------

local function ProcessWeaponDef(wdName, wd)
  -- backward compability
  BackwardCompability(wdName,wd)
end

--------------------------------------------------------------------------------

-- Process the unitDefs
local UnitDefs = DEFS.unitDefs

for udName, ud in pairs(UnitDefs) do
  if (isstring(udName) and istable(ud)) then
    ProcessUnitDef(udName, ud)
  end
end


for wdName, wd in pairs(WeaponDefs) do
  if (isstring(wdName) and istable(wd)) then
    ProcessWeaponDef(wdName, wd)
  end
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------