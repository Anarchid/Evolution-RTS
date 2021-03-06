function gadget:GetInfo()
    return {
        name      = 'Engine Hotfixes for Various Engine Kludges',
        desc      = '',
        author    = '',
        version   = 'v1.0',
        date      = 'April 2011',
        license   = 'GNU GPL, v2 or later',
        layer     = 0,
        enabled   = true
    }
end

----------------------------------------------------------------
-- Synced only
----------------------------------------------------------------
if gadgetHandler:IsSyncedCode() then

----------------------------------------------------------------
-- Callins
----------------------------------------------------------------

--Instagibb any features that are unlucky enough to be in the build radius of new construction projects
	function gadget:UnitCreated(uID, uDefID, uTeam, bID)
   
		local uDef = UnitDefs[uDefID]
		if uDef.isBuilding or uDef.isFactory then
			local ux, uy, uz = Spring.GetUnitPosition(uID)
			local xr, zr
			if Spring.GetUnitBuildFacing(uID) % 2 == 0 then
				xr, zr = 4 * uDef.xsize, 4 * uDef.zsize
			else
				xr, zr = 4 * uDef.zsize, 4 * uDef.xsize
			end
		
			local features = Spring.GetFeaturesInRectangle(ux-xr, uz-zr, ux+xr, uz+zr)
			for i = 1, #features do
				local fID = features[i]
				local fDefID = Spring.GetFeatureDefID(fID)
				local fDef = FeatureDefs[fDefID]
			
				if (not fDef.geoThermal) and (fDef.name ~= 'geovent') then
					local fx, fy, fz = Spring.GetFeaturePosition(fID)
					Spring.DestroyFeature(fID)
					Spring.SpawnCEG('sparklegreen', fx, fy, fz)
					Spring.PlaySoundFile('sounds/reclaimed.wav', 1, fx, fy, fz)
				end
			end
		end
	end
	
	function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)
		if weaponDefID == -1 then
			return 0
		end
		return damage
	end

end

	--UNSYNCED