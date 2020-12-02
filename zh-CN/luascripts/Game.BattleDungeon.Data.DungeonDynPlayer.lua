-- params : ...
-- function num : 0 , upvalues : _ENV
local DynPlayer = require("Game.Exploration.Data.DynPlayer")
local DungeonDynPlayer = class("DungeonDynPlayer", DynPlayer)
local DynHero = require("Game.Exploration.Data.DynHero")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
DungeonDynPlayer.ctor = function(self)
  -- function num : 0_0
end

DungeonDynPlayer.CreateDungeonPlayer = function(heroDatas, formationData, dungeonCfg)
  -- function num : 0_1 , upvalues : DungeonDynPlayer
  local player = (DungeonDynPlayer.New)()
  player:InitDynPlayer(heroDatas, formationData, dungeonCfg)
  return player
end

DungeonDynPlayer.InitDynPlayer = function(self, heroDatas, formationData, dungeonCfg)
  -- function num : 0_2
  self:InitHeroTeam(formationData.data)
  self:InitPlayerSkill(formationData.userSkill, formationData.cst)
  self:DeployHeroTeam(dungeonCfg)
  self:UpdateHeroAttr(heroDatas)
end

DungeonDynPlayer.InitHeroTeam = function(self, formData)
  -- function num : 0_3 , upvalues : _ENV, DynHero
  self.heroList = {}
  self.heroDic = {}
  local tmpHeroIndexDic = {}
  local battleRoleCount = (ConfigData.game_config).max_stage_hero
  for heroTeamIndex,heroId in pairs(formData) do
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    if heroData ~= nil then
      local dynHeroData = (DynHero.New)(heroData)
      dynHeroData.onBench = battleRoleCount < heroTeamIndex
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.heroDic)[heroId] = dynHeroData
      tmpHeroIndexDic[dynHeroData] = heroTeamIndex
      ;
      (table.insert)(self.heroList, dynHeroData)
    else
      error("player not have hero:" .. tostring(heroId))
    end
  end
  ;
  (table.sort)(self.heroList, function(hero1, hero2)
    -- function num : 0_3_0 , upvalues : tmpHeroIndexDic
    do return tmpHeroIndexDic[hero1] < tmpHeroIndexDic[hero2] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self:InitMirrorHeroTeam()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return DungeonDynPlayer

