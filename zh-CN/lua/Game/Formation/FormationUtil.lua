local FormationUtil = {}
local FmtEnum = require("Game.Formation.FmtEnum")
local FixedFmtHeroData = require("Game.PlayerData.Hero.FixedFmtHeroData")
local DungeonTypeFmtIdOffset = {[proto_csmsg_DungeonType.DungeonType_Daily] = 100}
local FmtFromModuleFmtIdOffset = {[(FmtEnum.eFmtFromModule).DailyDungeon] = 100, [(FmtEnum.eFmtFromModule).DailyDungeonLevel] = 100}
FormationUtil.GetFmtIdByDungeonType = function(dungeonType, fmtId)
  -- function num : 0_0 , upvalues : FormationUtil
  local offset = (FormationUtil.GetFmtIdOffsetByDungeonType)(dungeonType)
  local id = fmtId + offset
  return id
end

FormationUtil.GetFmtIdOffsetByDungeonType = function(dungeonType)
  -- function num : 0_1 , upvalues : DungeonTypeFmtIdOffset
  local offset = DungeonTypeFmtIdOffset[dungeonType] or 0
  return offset
end

FormationUtil.GetFmtIdOffsetByFmtFromModule = function(fmtFromModule)
  -- function num : 0_2 , upvalues : FmtFromModuleFmtIdOffset
  local offset = FmtFromModuleFmtIdOffset[fmtFromModule] or 0
  return offset
end

FormationUtil.SetFiexdFmt = function(fmtId, fixedHeroTeamId)
  -- function num : 0_3 , upvalues : _ENV, FixedFmtHeroData
  local assistTeamCfg = (ConfigData.assist_team)[fixedHeroTeamId]
  local fixedHeroDataList = {}
  local fixedHeroIdList = {}
  for k,heroId in ipairs(assistTeamCfg.param1) do
    local assistLv = (assistTeamCfg.assist_lvs)[k]
    local assistLvCfg = (ConfigData.assist_level)[assistLv]
    local heroData = (FixedFmtHeroData.FixedFmtHeroData)(heroId, assistLvCfg)
    ;
    (table.insert)(fixedHeroDataList, heroData)
    ;
    (table.insert)(fixedHeroIdList, heroId)
  end
  local formationData = (PlayerDataCenter.formationDic)[fmtId]
  if formationData == nil then
    formationData = PlayerDataCenter:CreateFormation(fmtId)
  end
  formationData:SetFmtFixedHeroList(fixedHeroDataList, fixedHeroIdList)
end

FormationUtil.ClearFiexdFmt = function(fmtId)
  -- function num : 0_4 , upvalues : _ENV
  local formationData = (PlayerDataCenter.formationDic)[fmtId]
  if formationData ~= nil then
    formationData:ClearFmtFixedHero()
  end
end

return FormationUtil

