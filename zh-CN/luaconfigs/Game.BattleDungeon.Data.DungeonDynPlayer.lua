-- params : ...
-- function num : 0 , upvalues : _ENV
local DynPlayer = require("Game.Exploration.Data.DynPlayer")
local DungeonDynPlayer = class("DungeonDynPlayer", DynPlayer)
local DynHero = require("Game.Exploration.Data.DynHero")
local ChipData = require("Game.PlayerData.Item.ChipData")
local DynEpBuffChip = require("Game.Exploration.Data.DynEpBuffChip")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DungeonDynPlayer.ctor = function(self)
  -- function num : 0_0
end

DungeonDynPlayer.CreateDungeonPlayer = function(roles, playerData, dungeonCfg, lastDeployData, treeId)
  -- function num : 0_1 , upvalues : DungeonDynPlayer
  local player = (DungeonDynPlayer.New)()
  player.__lastHeroPos = lastDeployData and lastDeployData.hero_pos or nil
  player:InitDynPlayer(roles, dungeonCfg, playerData, treeId)
  return player
end

DungeonDynPlayer.InitDynPlayer = function(self, roles, dungeonCfg, playerData, treeId)
  -- function num : 0_2 , upvalues : _ENV
  local heroDatas = {}
  for k,v in pairs(roles) do
    heroDatas[k] = v.stc
  end
  self:InitHeroTeam(roles)
  self.playerSkillMp = (playerData.dyc).mp
  self.playerUltSkillMp = (playerData.dyc).hmp
  self:InitPlayerSkill((playerData.stc).skillGroup, treeId)
  self:DeployHeroTeam(dungeonCfg.size_row, dungeonCfg.size_col, dungeonCfg.deploy_rows, self.__lastHeroPos)
  self:__UpdateCoordInBattleEditor()
  self:UpdateHeroAttr(heroDatas)
end

DungeonDynPlayer.InitHeroTeam = function(self, roles)
  -- function num : 0_3 , upvalues : _ENV, HeroData, DynHero
  self.heroList = {}
  self.heroDic = {}
  local tmpHeroIndexDic = {}
  local battleRoleCount = (ConfigData.game_config).max_stage_hero
  for uid,battleRole in pairs(roles) do
    local heroTeamIndex = (battleRole.dyc).formationIdx
    local roleType = battleRole.roleType
    local heroCfg = (ConfigData.hero_data)[(battleRole.stc).dataId]
    local oriHeroData = (PlayerDataCenter.heroDic)[(battleRole.stc).dataId]
    if oriHeroData == nil or not oriHeroData.skinId then
      local heroData = (HeroData.New)({
basic = {id = (battleRole.stc).dataId, level = (battleRole.stc).level, exp = 0, star = (battleRole.stc).rank, potentialLvl = (battleRole.stc).potential, ts = -1, career = heroCfg.career, company = heroCfg.camp, skinId = (battleRole.stc).skinId}
})
      for k,v in pairs((battleRole.stc).skillGroup) do
        if (heroData.skillDic)[k] ~= nil then
          ((heroData.skillDic)[k]):UpdateSkill(v)
        end
      end
      do
        local dynHeroData = (DynHero.New)(heroData, (battleRole.stc).uid, roleType)
        dynHeroData:SetDynHeroFmtIdx(heroTeamIndex)
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (self.heroDic)[heroData.dataId] = dynHeroData
        tmpHeroIndexDic[dynHeroData] = heroTeamIndex
        ;
        (table.insert)(self.heroList, dynHeroData)
        -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_STMT

      end
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
end

DungeonDynPlayer.InitPlayerSkillCustom = function(self, playerSkillDic, CSTId)
  -- function num : 0_4 , upvalues : _ENV, DynBattleSkill, ExplorationEnum
  self.playerOriginSkillList = {}
  self.CSTId = CSTId
  if playerSkillDic ~= nil then
    for k,skillId in pairs(playerSkillDic) do
      local data = (DynBattleSkill.New)(skillId, 1, (ExplorationEnum.eBattleSkillType).Original)
      ;
      (table.insert)(self.playerOriginSkillList, data)
    end
  end
end

DungeonDynPlayer.ExecuteAllSuitChip2NewHeroList = function(self, newHeroList)
  -- function num : 0_5
end

DungeonDynPlayer.__UpdateChipSuitDiff = function(self, chipShowDel, chipShowAdd)
  -- function num : 0_6 , upvalues : _ENV, DynPlayer
  if BattleEditorManager ~= nil and BattleEditorManager.simulateChipSuit then
    (DynPlayer.__UpdateChipSuitDiff)(self, chipShowDel, chipShowAdd)
  end
end

DungeonDynPlayer.__UpdateCoordInBattleEditor = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if BattleEditorManager ~= nil and BattleEditorManager.DeployFormation then
    BattleEditorManager:DeployTeam(self.heroList)
  end
end

return DungeonDynPlayer

