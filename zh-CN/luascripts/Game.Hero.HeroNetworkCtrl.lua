-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroNetworkCtrl = class("HeroNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local LastSendType = {HeroLevelUp = 1, HeroStarUp = 2, HeroSkillUp = 3}
HeroNetworkCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.reqHeroDetailTab = {}
  self.lastSendDataList = {}
  self.sendFormationData = {}
  self.fmtNameFreshData = {}
  self.__onUpdateHeroEvent = BindCallback(self, self.OnUpdateHeroEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
end

HeroNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_AddExp, self, proto_csmsg.SC_HERO_AddExp, self.On_SC_HERO_AddExp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar, self, proto_csmsg.SC_HERO_AddStar, self.On_SC_HERO_AddStar)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SkillUpgrade, self, proto_csmsg.SC_HERO_SkillUpgrade, self.On_SC_HERO_SkillUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationFresh, self, proto_csmsg.SC_HERO_FormationFresh, self.On_SC_HERO_FormationFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationPickSkill, self, proto_csmsg.SC_HERO_FormationPickSkill, self.On_SC_HERO_FormationPickSkill)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_ReqHeroDetail, self, proto_csmsg.SC_BATTLE_ReqHeroDetail, self.SC_BATTLE_ReqHeroDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationNameFresh, self, proto_csmsg.SC_HERO_FormationNameFresh, self.SC_HERO_FormationNameFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BATTLE_ReqPlayerDetail, self, proto_csmsg.SC_BATTLE_ReqPlayerDetail, self.SC_BATTLE_ReqPlayerDetail)
end

HeroNetworkCtrl.On_SC_HERO_AddExp = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "add hero exp error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddExp)
    return 
  end
end

HeroNetworkCtrl.On_SC_HERO_AddStar = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "add hero star error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar)
    return 
  end
end

HeroNetworkCtrl.On_SC_HERO_SkillUpgrade = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "add skill level error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    ;
    (table.remove)(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.CS_HERO_SkillUpgrade)
    return 
  end
end

HeroNetworkCtrl.On_SC_HERO_FormationFresh = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "hero formation fresh error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
  end
end

HeroNetworkCtrl.On_SC_HERO_FormationPickSkill = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "hero formation Skill error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
  end
end

HeroNetworkCtrl.SaveLastHeroData = function(self, saveLast, heroData)
  -- function num : 0_7 , upvalues : _ENV
  saveLast.heroId = heroData.dataId
  saveLast.level = heroData.level
  saveLast.star = heroData.star
  saveLast.rank = heroData.rank
  saveLast.fightingPower = heroData:GetFightingPower()
  saveLast.attr = {}
  saveLast.skill = {}
  saveLast.heroData = heroData
  for k,v in pairs(eHeroShowAttrList) do
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

    (saveLast.attr)[v] = heroData:GetAttr(v, nil, true)
  end
  for k,v in pairs(heroData.skillDic) do
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

    if v:GetIsUnlock() then
      (saveLast.skill)[k] = v
    end
  end
  saveLast.athslotList = heroData:GetAthSlotList()
end

HeroNetworkCtrl.SendHeroAddExp = function(self, heroId, itemTab)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local msgTab = {hero = heroId, items = itemTab}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_AddExp, proto_csmsg.CS_HERO_AddExp, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddExp, proto_csmsg_MSG_ID.MSG_SC_HERO_AddExp)
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  if heroData ~= nil then
    local saveLast = {}
    saveLast.type = LastSendType.HeroLevelUp
    self:SaveLastHeroData(saveLast, heroData)
    ;
    (table.insert)(self.lastSendDataList, saveLast)
  end
end

HeroNetworkCtrl.SendHeroAddStar = function(self, heroId)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local msgTab = {hero = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg.CS_HERO_AddStar, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar)
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  if heroData ~= nil then
    local saveLast = {}
    saveLast.type = LastSendType.HeroStarUp
    self:SaveLastHeroData(saveLast, heroData)
    ;
    (table.insert)(self.lastSendDataList, saveLast)
  end
end

HeroNetworkCtrl.SendHeroSkillUp = function(self, heroId, skillId)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local msgTab = {hero = heroId, skill = skillId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_SkillUpgrade, proto_csmsg.CS_HERO_SkillUpgrade, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_SkillUpgrade, proto_csmsg_MSG_ID.MSG_SC_HERO_SkillUpgrade)
  local saveLast = {}
  saveLast.type = LastSendType.HeroSkillUp
  saveLast.heroId = heroId
  saveLast.skillId = skillId
  ;
  (table.insert)(self.lastSendDataList, saveLast)
end

HeroNetworkCtrl.OnUpdateHeroEvent = function(self, heroList)
  -- function num : 0_11 , upvalues : _ENV, LastSendType, HeroEnterDataUtil
  if #self.lastSendDataList == 0 then
    return 
  end
  local lastData = (table.remove)(self.lastSendDataList, 1)
  -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

  if lastData.type == LastSendType.HeroLevelUp and lastData.level < (lastData.heroData).level then
    HeroEnterDataUtil:OnHeroLevelChange(lastData.level, (lastData.heroData).level, lastData.heroId)
    ;
    (UIManager:ShowWindow(UIWindowTypeID.HeroLevelUpSuccess)):InitHeroLevelData(lastData, lastData.heroData)
  end
  -- DECOMPILER ERROR at PC51: Unhandled construct in 'MakeBoolean' P1

  if lastData.type == LastSendType.HeroStarUp and lastData.rank ~= (lastData.heroData).rank then
    MsgCenter:Broadcast(eMsgEventId.OnHeroRankChange, (lastData.heroData).dataId)
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    -- function num : 0_11_0 , upvalues : lastData, _ENV
    if window == nil then
      return 
    end
    window:InitGetHeroList({(lastData.heroData).dataId}, true)
    AudioManager:PlayAudioById(1024)
  end
)
    HeroEnterDataUtil:OnHeroRankChange(lastData.rank, (lastData.heroData).rank, lastData.heroId)
  end
  if lastData.type == LastSendType.HeroSkillUp then
    local heroData = (PlayerDataCenter.heroDic)[lastData.heroId]
    if heroData ~= nil then
      local skillData = (heroData.skillDic)[lastData.skillId]
      if skillData ~= nil then
        if skillData.type == eHeroSkillType.LifeSkill then
          HeroEnterDataUtil:OnLifeSkillLevelUp(skillData)
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    -- function num : 0_11_1 , upvalues : _ENV
    if window == nil then
      return 
    end
    window:ShowTips(ConfigData:GetTipContent(TipContent.hero_Skill_upgradeSuccess))
  end
)
      end
    end
  end
end

HeroNetworkCtrl.SendFormationFresh = function(self, formationId, data)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.sendFormationData).id = formationId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.sendFormationData).data = data
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh, proto_csmsg.CS_HERO_FormationFresh, self.sendFormationData)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.sendFormationData).data = nil
end

HeroNetworkCtrl.SendFormationSkill = function(self, formationId, userSkill)
  -- function num : 0_13 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.sendFormationData).id = formationId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.sendFormationData).userSkill = userSkill
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationPickSkill, proto_csmsg.CS_HERO_FormationPickSkill, self.sendFormationData)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.sendFormationData).userSkill = nil
end

HeroNetworkCtrl.CS_HERO_FormationNameFresh = function(self, fmtId, name, callBack)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.fmtNameFreshData).id = fmtId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.fmtNameFreshData).name = name
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh, proto_csmsg.CS_HERO_FormationNameFresh, self.fmtNameFreshData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_FormationNameFresh)
end

HeroNetworkCtrl.SC_HERO_FormationNameFresh = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None or msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
  else
    local errorMsg = "HeroNetworkCtrl:SC_HERO_FormationNameFresh error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
  end
end

HeroNetworkCtrl.CS_BATTLE_ReqHeroDetail = function(self, heroIdDic, callBack)
  -- function num : 0_16 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.reqHeroDetailTab).data = heroIdDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqHeroDetail, proto_csmsg.CS_BATTLE_ReqHeroDetail, self.reqHeroDetailTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqHeroDetail, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_ReqHeroDetail)
end

HeroNetworkCtrl.SC_BATTLE_ReqHeroDetail = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_BATTLE_ReqHeroDetail error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqHeroDetail)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqHeroDetail, msg)
  end
end

HeroNetworkCtrl.CS_BATTLE_ReqPlayerDetail = function(self, callBack)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqPlayerDetail, proto_csmsg.CS_BATTLE_ReqPlayerDetail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqPlayerDetail, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_ReqPlayerDetail)
end

HeroNetworkCtrl.SC_BATTLE_ReqPlayerDetail = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_BATTLE_ReqHeroDetail error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqPlayerDetail)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqPlayerDetail, msg)
  end
end

HeroNetworkCtrl.Reset = function(self)
  -- function num : 0_20
  self.lastSendDataList = {}
  self.lastSendFormation = {}
end

return HeroNetworkCtrl

