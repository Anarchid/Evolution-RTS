-- UNITDEF -- ESTORAGE --
--------------------------------------------------------------------------------

local unitName = "estorage"

--------------------------------------------------------------------------------

local unitDef = {
  activateWhenBuilt  = true,
  buildAngle         = 8196,
  buildCostEnergy    = 0,
  buildCostMetal     = 20,
  builder            = false,
  buildTime          = 5,
  canAttack			 = false,
  category           = "BUILDING NOTAIR ECO",
  corpse             = "ammobox",
  description        = "Resource Storage - Stores 50m/50e",
  energyStorage      = 50,
  energyUse          = 0,
  explodeAs          = "ESTOR_BUILDING",
  footprintX         = 6,
  footprintZ         = 6,
  idleAutoHeal       = .5,
  idleTime           = 2200,
  icontype           = "eco",
  maxDamage          = 1200,
  maxSlope           = 50,
  maxWaterDepth      = 0,
  metalStorage       = 50,
  name               = "Storage",
  objectName         = "estorage.s3o",
  radarDistance      = 0,
  repairable		 = false,
  selfDestructAs     = "ESTOR_BUILDING",
  side               = "CORE",
  sightDistance      = 367,
  smoothAnim         = true,
  unitname           = "estorage",
  workerTime         = 0,
  yardMap            = "oooooo oooooo oooooo oooooo oooooo oooooo ",
  
sfxtypes = {
	pieceExplosionGenerators = {
		"deathceg0",
		"deathceg1",
	},
	
	explosiongenerators = {
	  "custom:blacksmoke",
    },
},
  
  sounds = {
    underattack        = "unitsunderattack1",
    select = {
      "gdenergy",
    },
  },
  weapons = {
    [1]  = {
      def                = "fusionfx",
    },
    [2]  = {
      def                = "fusionfx2",
    },
  },
   customParams = {
    needed_cover = 2,
	death_sounds = "generic",
	armortype   = "building", 
	normaltex = "unittextures/estoragenormal.png", 
	helptext = [[Storage Facility

Will increase your storage reserves by +50

+50 Metal Storage

+50 Energy Storage]],
  },
	buildingGroundDecalDecaySpeed=30,
	buildingGroundDecalSizeX=9,
	buildingGroundDecalSizeY=9,
	useBuildingGroundDecal = true,
	buildingGroundDecalType=[[estorage_aoplane.dds]],
}


--------------------------------------------------------------------------------

local weaponDefs = {
  fusionfx = {

    AreaOfEffect       = 0,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    rgbColor           = "0.8 0.5 0",
    rgbColor2          = "0.5 0.5 0.5",
    coreThickness      = 0.1,
    craterBoost        = 0,
    craterMult         = 0,
    explosionGenerator = "custom:empty",
    fallOffRate        = 0.5,
    minintensity       = 1,
    impulseFactor      = 0,
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "fake",
    noSelfDamage       = true,
    range              = 650,
    reloadtime         = 0.1,
    WeaponType         = "BeamLaser",
    selfprop           = true,
    soundTrigger       = true,
    startVelocity      = 1500,
    targetMoveError    = 0.3,
    thickness          = 1,
    turret             = true,
    weaponVelocity     = 1500,
    damage = {
      default            = 1E-06,
    },
  },
    fusionfx2 = {
    AreaOfEffect       = 0,
    avoidFeature       = false,
    avoidFriendly      = false,
    beamTime           = 0.1,
    beamWeapon         = true,
    collideFeature     = false,
    collideFriendly    = false,
    coreThickness      = 0.5,
    duration           = 0.9,
    energypershot      = 0,
    explosionGenerator = "custom:empty",
    fallOffRate        = 0.5,
    fireStarter        = 50,
    
    largeBeamLaser     = true,
    lineOfSight        = true,
    name               = "fake",
    range              = 500,
    reloadtime         = 1,
    WeaponType         = "LaserCannon",
    rgbColor           = "0.5 0 0",
    rgbColor2          = "0.2 0.2 0.2",
    soundTrigger       = true,
    sweep              = "1",
    sweepfire          = true,
    targetMoveError    = 0.3,
    texture1           = "plasmaball",
    texture2           = "empty",
    thickness          = 2,
    tolerance          = 1000,
    turret             = true,
    weaponVelocity     = 300,
    damage = {
      default            = 1E-06,
    },
  },
}
unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
