local base = require("Game.PlayerData.Hero.HeroData")
local FriendSupportHeroData = class("FriendSupportHeroData", base)
local attrIdOffset = 100
FriendSupportHeroData.ctor = function(self, data)
  -- function num : 0_0
  self.isFriendSupport = true
  self.athDic = {}
  self.athSkills = {}
  self.skillLevelDic = {}
  self.attrAddDic = {}
  self._defaultPow = nil
  self._pow = nil
  self.userInfo = nil
end

FriendSupportHeroData.GenSupportHeroData = function(userInfoData, briefId, fixCfg)
  -- function num : 0_1 , upvalues : FriendSupportHeroData
  local SupportHeroData = userInfoData:GetSupportHeroDataById(briefId)
  local assistsBrief = SupportHeroData.assistsBrief
  local assistsRandom = SupportHeroData.assistsRandom
  local data = (FriendSupportHeroData.CreatSupportHeroDataBase)(assistsBrief, assistsRandom, fixCfg)
  data.userInfo = userInfoData
  return data
end

FriendSupportHeroData.CreatSupportHeroDataBase = function(assistsBrief, assistsRandom, fixCfg)
  -- function num : 0_2 , upvalues : FriendSupportHeroData, _ENV
  local basic = {}
  local skillLevelData = {}
  basic.id = assistsBrief.id
  basic.level = assistsBrief.level
  basic.exp = 0
  basic.ts = nil
  basic.potentialLvl = assistsBrief.potential
  basic.archive = nil
  basic.audio = nil
  basic.star = assistsBrief.star
  basic.skinId = assistsBrief.skin
  if fixCfg ~= nil then
    basic.level = fixCfg.fixLv
    basic.potentialLvl = fixCfg.fixPotential
  end
  if assistsRandom ~= nil then
    skillLevelData = assistsRandom.skills
  end
  local fakeData = {}
  fakeData.basic = basic
  fakeData.skill = {}
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (fakeData.skill).data = skillLevelData
  local data = (FriendSupportHeroData.New)(fakeData)
  data._defaultPow = assistsBrief.power
  if fixCfg ~= nil then
    for skillId,skillData in pairs(data.skillDic) do
      if (skillData:IsNormalSkill() or skillData:IsPassiveSkill()) and fixCfg.fixSkillLv < skillData.level then
        skillData:UpdateSkill(fixCfg.fixSkillLv)
      end
    end
  end
  do
    if assistsRandom ~= nil then
      data.skillLevelDic = assistsRandom.skills
      data.athDic = assistsRandom.athLoc
      data.athSkills = assistsRandom.athSkills
      data.attrAddDic = assistsRandom.athAttr
    end
    data.isRemoveAllBounce = true
    data:CalSupporterPow()
    data:CalAthSuit()
    data._assistsBrief = assistsBrief
    data._assistsRandom = assistsRandom
    return data
  end
end

FriendSupportHeroData.OnSupporterLevelChange = function(self, level)
  -- function num : 0_3
  self.level = level
  self:__UpdateBaseArriDic()
  self:CalSupporterPow()
end

FriendSupportHeroData.CalSupporterPow = function(self)
  -- function num : 0_4
  self._pow = self:GetFightingPower()
end

FriendSupportHeroData.GetSupporterPow = function(self)
  -- function num : 0_5
  return self._pow or 0
end

FriendSupportHeroData.GetFightingPower = function(self, isDefault)
  -- function num : 0_6 , upvalues : base
  do return not isDefault or self._defaultPow or 0 end
  return (base.GetFightingPower)(self)
end

FriendSupportHeroData.CalAthSuit = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local suitDic = {}
  for _,athId in pairs(self.athDic) do
    local athCfg = (ConfigData.arithmetic)[athId]
    if athCfg ~= nil then
      local suitId = athCfg.suit
      if not suitDic[suitId] then
        local count = suitId or 0 == 0 or 0
      end
      suitDic[suitId] = count + 1
    end
  end
  for suitId,count in pairs(suitDic) do
    local athSuitCfg = (ConfigData.ath_suit)[suitId]
    if count < (athSuitCfg[1]).num then
      suitDic[suitId] = nil
    end
  end
  self.athSuitDic = suitDic
end

FriendSupportHeroData.GetAthSlotInfo = function(self, index)
  -- function num : 0_8 , upvalues : _ENV
  local res = {}
  for key,athId in pairs(self.athDic) do
    local tempIndex = key >> 16
    if tempIndex == index then
      local slot = key & 65535
      res[slot] = athId
    end
  end
  return res
end

FriendSupportHeroData.GetAthSuit = function(self)
  -- function num : 0_9
  return self.athSuitDic
end

FriendSupportHeroData.GetSkillFightingPower = function(self, heroPower)
  -- function num : 0_10 , upvalues : _ENV, base
  local fightingPower = 0
  for skillId,skillLevel in pairs(self.athSkills) do
    local battleCfg = (ConfigData.battle_skill)[skillId]
    fightingPower = PlayerDataCenter:GetBattleSkillFightPower(skillId, skillLevel, heroPower) + fightingPower
  end
  return (base.GetSkillFightingPower)(self, heroPower) + (fightingPower)
end

FriendSupportHeroData.GetUserInfo = function(self)
  -- function num : 0_11
  return self.userInfo
end

FriendSupportHeroData.UseFixCfg2ChangeSupportorAttr = function(self, fixCfg)
  -- function num : 0_12 , upvalues : _ENV
  if self.__fixCfg ~= fixCfg then
    do return  end
    local fakeData = {
basic = {level = fixCfg.fixLv, potentialLvl = fixCfg.fixPotential}
}
    self:UpdateHeroData(fakeData)
    for skillId,skillData in pairs(self.skillDic) do
      if (skillData:IsNormalSkill() or skillData:IsPassiveSkill()) and fixCfg.fixSkillLv < skillData.level then
        skillData:UpdateSkill(fixCfg.fixSkillLv)
      end
    end
    self:CalSupporterPow()
  end
end

FriendSupportHeroData.__CalBaseAttr = function(self, attrId, withoutAth, athHeroId)
  -- function num : 0_13 , upvalues : attrIdOffset, base
  local baseAttrId = attrId + attrIdOffset
  return (base.__CalBaseAttr)(self, attrId, withoutAth, athHeroId) + ((self.attrAddDic)[baseAttrId] or 0)
end

FriendSupportHeroData.__CalRatioAttr = function(self, atrValue, attrId, withoutAth, athHeroId)
  -- function num : 0_14 , upvalues : attrIdOffset, base
  local ratioAttrId = attrId + attrIdOffset * 2
  return (base.__CalRatioAttr)(self, atrValue, attrId, withoutAth, athHeroId, (self.attrAddDic)[ratioAttrId])
end

FriendSupportHeroData.__CalExtraAttr = function(self, atrValue, attrId, withoutAth, athHeroId)
  -- function num : 0_15 , upvalues : base
  return (base.__CalExtraAttr)(self, atrValue, attrId, withoutAth, athHeroId) + ((self.attrAddDic)[attrId] or 0)
end

FriendSupportHeroData.GetAthSlotList = function(self, isFull)
  -- function num : 0_16 , upvalues : base
  return (base.GetAthSlotList)(self, isFull, (self._assistsBrief).star, (self._assistsBrief).potential, (self._assistsBrief).level)
end

return FriendSupportHeroData

