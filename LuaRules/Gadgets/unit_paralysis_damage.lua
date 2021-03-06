----------------------------------------------------------------------------------------------------------------------------------------------------------------function gadget:GetInfo()  return {    name      = "Paralysis",    desc      = "Handels paralysis system and adds extra_damage to lightning weapons",    author    = "Google Frog",    date      = "Apr, 2010",    license   = "GNU GPL, v2 or later",    layer     = 0,    enabled   = true  --  loaded by default?  }end----------------------------------------------------------------------------------------------------------------------------------------------------------------if (not gadgetHandler:IsSyncedCode()) then  return false  --  no unsynced codeendlocal spGetUnitHealth = Spring.GetUnitHealthlocal spSetUnitHealth = Spring.SetUnitHealthlocal spGetUnitDefID  = Spring.GetUnitDefIDlocal extraNormalDamageList = {}local extraNormalDamageFalloffList = {}for i=1,#WeaponDefs do	if WeaponDefs[i].customParams and WeaponDefs[i].customParams.extra_damage then 		extraNormalDamageList[i] = WeaponDefs[i].customParams.extra_damage		if WeaponDefs[i].customParams.extra_damage_falloff_max then			extraNormalDamageFalloffList[i] = 1/WeaponDefs[i].customParams.extra_damage_falloff_max		end	endend function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer,                             weaponDefID, attackerID, attackerDefID, attackerTeam)		if paralyzer then -- the weapon deals paralysis damage				local health, maxHealth = Spring.GetUnitHealth(unitID)		if extraNormalDamageList[weaponDefID] then			attackerID = attackerID or -1			local extraDamage = extraNormalDamageList[weaponDefID]			if extraNormalDamageFalloffList[weaponDefID] then				local armored, mult = Spring.GetUnitArmored(unitID)				if armored then					damage = damage/mult				end				extraDamage = extraDamage*damage*extraNormalDamageFalloffList[weaponDefID]			end			-- be careful; this line can cause recursion! don't make it do paralyzer damage			Spring.AddUnitDamage(unitID, extraDamage, 0, attackerID, weaponDefID)		end		if health and maxHealth and health ~= 0 then -- taking no chances.			return damage*maxHealth/health		end	end		return damageend