function gadget:GetInfo()
	return {
		name = "Resource Gifts and Mex Income",
		desc = "Adds 1/1 resource income so that I don't have to tie it to units anymore, controls extractor income",
		author = "lurker (Dylan Petonke), Google Frog",
		date = "Sept 8 2009",
		license = "GPL",
		layer = 1,
		enabled = true
	}
end

local MEX_INCOME = 0.5 -- income of each mex

if (not gadgetHandler:IsSyncedCode()) then
	return -- No Unsynced
end

--- Detect metal extractors, manual entering of mexes possible
local mexDefs = {}

for i=1,#UnitDefs do
	local udef = UnitDefs[i]
	if (udef.extractsMetal > 0) then
		mexDefs[i] = true
	end
end

-- Initialise ally teams
local allyTeamInfo = {} -- list of players and mexes on a team

local allyTeamList = Spring.GetAllyTeamList()
local allyTeams = #allyTeamList
do
	for i=1,allyTeams do
		local allyTeamID = allyTeamList[i]
		local teamList = Spring.GetTeamList(allyTeamID)
		allyTeamInfo[allyTeamID] = {
			teams = 0,
			team = {},
			mexes = 0,
			mex = {},
			mexIndex = {},
		}
		for j=1,#teamList do
			local teamID = teamList[j]
			allyTeamInfo[allyTeamID].teams = allyTeamInfo[allyTeamID].teams + 1
			allyTeamInfo[allyTeamID].team[allyTeamInfo[allyTeamID].teams] = teamID
		end
	end
end

local function addMex(unitID)
	local allyTeam = allyTeamInfo[Spring.GetUnitAllyTeam(unitID)]
	allyTeam.mexes = allyTeam.mexes + 1
	allyTeam.mex[allyTeam.mexes] = unitID
	allyTeam.mexIndex[unitID] = allyTeam.mexes
end

local function removeMex(unitID)
	local allyTeam = allyTeamInfo[Spring.GetUnitAllyTeam(unitID)]
	allyTeam[allyTeam.mexIndex[unitID]] = allyTeam[allyTeam.mexes]
	allyTeam[allyTeam.mexes] = nil
	allyTeam.mexIndex[unitID] = nil
	allyTeam.mexes = allyTeam.mexes - 1
end

local function getMexIncomes()

	local income = {}

	for i=1,allyTeams do
		local allyTeamID = allyTeamList[i]
		local allyTeam = allyTeamInfo[allyTeamID]
		local mexCount = 0
		for i = 1, allyTeam.mexes do
			local unitID = allyTeam.mex[i]
			local stunned_or_inbuld = Spring.GetUnitIsStunned(unitID)
			if not stunned_or_inbuld then
				mexCount = mexCount + 1
			end
		end
		income[allyTeamID] = MEX_INCOME*mexCount/allyTeam.teams
	end

	return income
end

function gadget:Initialize(n)
	if ( Spring.GetModOptions().comm  == "sandbox" or Spring.GetModOptions().comm  == "feature" ) then

		for _,i in ipairs(Spring.GetTeamList()) do
			Spring.SetTeamResource(i,"e",1000000000000)
			Spring.SetTeamResource(i,"m",1000000000000)
		end
	end
	
	for _, unitID in ipairs(Spring.GetAllUnits()) do
		if (mexDefs[unitDefID]) then
			addMex(unitID)
		end
	end
end
	
function gadget:GameFrame(n)

	-- Give a trickle of resources to teams
	if n%32 == 4 then
		local mexIncome = getMexIncomes()
		for _,i in ipairs(Spring.GetTeamList()) do
			local _,_,_,_,_,allyTeamID = Spring.GetTeamInfo(i)
			if allyTeamID then -- don't give free stuff to GAIA
				Spring.AddTeamResource(i,"e",1)
				Spring.AddTeamResource(i,"m",0.5 + mexIncome[allyTeamID])
			end
		end
	--Give free resources to AI - Necessary for AI's to properly function
		for _,TeamID in ipairs(Spring.GetTeamList()) do
			local teamNum,leader,isDead,isAiTeam,side,allyTeam,teamCustomOptions = Spring.GetTeamInfo(TeamID)
			if isAiTeam then
				Spring.AddTeamResource(TeamID,"e",10)
			end
		end
	end

	-- Give free unlimited power to AI
	if n==60 and GG.TechGrant then
		for _,TeamID in ipairs(Spring.GetTeamList()) do
			local teamNum,leader,isDead,isAiTeam,side,allyTeam,teamCustomOptions = Spring.GetTeamInfo(TeamID)
			if isAiTeam then
				GG.TechGrant("Power",TeamID)
			end
		end
	end

	if n%1920 == 1 then
		for _,TeamID in ipairs(Spring.GetTeamList()) do
			local teamNum,leader,isDead,isAiTeam,side,allyTeam,teamCustomOptions = Spring.GetTeamInfo(TeamID)
			if isAiTeam then
				Spring.AddTeamResource(TeamID,"m",100)
			end
		end
	end
	
end

function gadget:UnitCreated(unitID, unitDefID, unitTeam)
	if (mexDefs[unitDefID]) then
		addMex(unitID)
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if (mexDefs[unitDefID]) then
		removeMex(unitID)
	end
end

function gadget:UnitGiven(unitID, unitDefID, teamID, oldTeamID)
	local _,_,_,_,_,newAllyTeam = Spring.GetTeamInfo(teamID)
	local _,_,_,_,_,oldAllyTeam = Spring.GetTeamInfo(oldTeamID)
	
	if (newAllyTeam ~= oldAllyTeam) then
		if (mexDefs[unitDefID]) then 
			addMex(unitID)
		end
	end
end

function gadget:UnitTaken(unitID, unitDefID, oldTeamID, teamID)
	local _,_,_,_,_,newAllyTeam = Spring.GetTeamInfo(teamID)
	local _,_,_,_,_,oldAllyTeam = Spring.GetTeamInfo(oldTeamID)
	
	if (newAllyTeam ~= oldAllyTeam) then
		if (mexDefs[unitDefID]) then 
			removeMex(unitID)
		end
	end
end
