-- UNITDEF -- ESCOUT --
--------------------------------------------------------------------------------

local unitName = "escout"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 10,
  bankscale          = "1",
  brakeRate          = 4,
  buildCostEnergy    = 0,
  buildCostMetal     = 40,
  builder            = false,
  buildTime          = 5,
  canFly             = true,
  canGuard           = true,
  canMove            = true,
  canPatrol          = true,
  canstop            = "1",
  category           = "VTOL",
  collide            = false,
  collisionSphereScale = 1,
  corpse             = "ammobox",
  cruiseAlt          = 180,
  description        = "Air Scout - Armortype: Light",
  energyMake         = 0.2,
  energyStorage      = 0,
  energyUse          = 0.2,
  explodeAs          = "SMALL_UNIT",
  footprintX         = 2,
  footprintZ         = 2,
  iconType           = "air",
  idleAutoHeal       = .5,
  idleTime           = 2200,
  maxAcc             = 0.5,
  maxDamage          = 160,
  maxSlope           = 10,
  maxVelocity        = 20,
  maxWaterDepth      = 0,
  metalStorage       = 0,
  name               = "(A)irScout",
  objectName         = "escout.s3o",
  radarDistance      = 2000,
  sonarDistance      = 1000,
  selfDestructAs     = "SMALL_UNIT",
  side               = "ARM",
  sightDistance      = 750,
  smoothAnim         = true,
  turnRate           = 800,
  unitname           = "escout",
  workerTime         = 0,
  sfxtypes = {
    explosiongenerators = {
      "custom:jethtrail",
    },
  },
  sounds = {
    underattack        = "unitsunderattack1",
    ok = {
      "ack",
    },
    select = {
      "unitselect",
    },
  },
   customParams = {
	twokhotkey = 'a',
    RequireTech = "4 Power",
	armortype   = "lightarmor",
	normaltex = "unittextures/escoutnormal.png", 
  },
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------