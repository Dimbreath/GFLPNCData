-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroNetworkCtrl = class("HeroNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local cs_ColorUtility = (CS.UnityEngine).ColorUtility
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local LastSendType = {HeroLevelUp = 1, HeroSkillUp = 3, HeroPotential = 4}
HeroNetworkCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.reqHeroDetailTab = {}
  self.lastSendDataList = {}
  self.sendFormationData = {}
  self.fmtNameFreshData = {}
  self.heroSkinChange = {}
  self.heroRecordMsg = {}
  self.__onUpdateHeroEvent = BindCallback(self, self.OnUpdateHeroEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
end

HeroNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar, self, proto_csmsg.SC_HERO_AddStar, self.On_SC_HERO_AddStar)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SkillUpgrade, self, proto_csmsg.SC_HERO_SkillUpgrade, self.On_SC_HERO_SkillUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationFresh, self, proto_csmsg.SC_HERO_FormationFresh, self.On_SC_HERO_FormationFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationPickSkill, self, proto_csmsg.SC_HERO_FormationPickSkill, self.On_SC_HERO_FormationPickSkill)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationNameFresh, self, proto_csmsg.SC_HERO_FormationNameFresh, self.SC_HERO_FormationNameFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail, self, proto_csmsg.SC_RECOMMANDFORMATION_Detail, self.SC_RECOMMANDFORMATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_PotentialUpgrade, self, proto_csmsg.SC_HERO_PotentialUpgrade, self.SC_HERO_PotentialUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SkinChange, self, proto_csmsg.SC_HERO_SkinChange, self.SC_HERO_SkinChange)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Record, self, proto_csmsg.SC_HERO_Record, self.SC_HERO_Record)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Upgrade, self, proto_csmsg.SC_HERO_Upgrade, self.SC_HERO_Upgrade)
end

HeroNetworkCtrl.SC_HERO_Upgrade = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "add hero exp error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade)
  end
  do
    if msg.syncUpdateDiff == nil then
      error("msg.syncUpdateDiff is nil")
    end
    if (msg.syncUpdateDiff).hero == nil then
      error("msg.syncUpdateDiff.hero is nil")
    end
    if ((msg.syncUpdateDiff).hero).update == nil then
      error("msg.syncUpdateDiff.hero.update is nil")
    end
    local heroUpdateDic = ((msg.syncUpdateDiff).hero).update
    if heroUpdateDic == nil then
      error("Don\'t have heroDiff")
    else
      if (table.count)(heroUpdateDic) ~= 1 then
        error("Has mult hero data change, please check")
      end
    end
    local heroDataDiff, heroData = nil, nil
    local dataDiffDic = {}
    for heroId,heroMsg in pairs(heroUpdateDic) do
      heroData = PlayerDataCenter:GetHeroData(heroId)
      local skillLevelDic = {}
      for skillId,skillData in pairs(heroData.skillDic) do
        skillLevelDic[skillId] = skillData.level
      end
      heroDataDiff = {heroId = heroId, oldLevel = heroData.level, oldExp = heroData.curExp}
      dataDiffDic[heroId] = heroDataDiff
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade, dataDiffDic)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.On_SC_HERO_SkillUpgrade = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "add skill level error:" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
      ;
      (table.remove)(self.lastSendDataList, 1)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.CS_HERO_SkillUpgrade)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.On_SC_HERO_FormationFresh = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "hero formation fresh error:" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.On_SC_HERO_FormationPickSkill = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  do
    if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "hero formation Skill error:" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.SaveLastHeroData = function(self, saveLast, heroData)
  -- function num : 0_6 , upvalues : _ENV
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

HeroNetworkCtrl.CS_HERO_Upgrade = function(self, heroId, targetLevel, callback)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local msgTab = {hero = heroId, aimLv = targetLevel}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade, proto_csmsg.CS_HERO_Upgrade, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_Upgrade)
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  if heroData ~= nil then
    local saveLast = {}
    saveLast.type = LastSendType.HeroLevelUp
    self:SaveLastHeroData(saveLast, heroData)
    ;
    (table.insert)(self.lastSendDataList, saveLast)
  end
end

HeroNetworkCtrl.SendHeroAddStar = function(self, heroId, callback)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  local msgTab = {hero = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg.CS_HERO_AddStar, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar)
  self.heroAddStarCallbacl = callback
end

HeroNetworkCtrl.On_SC_HERO_AddStar = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse, CheckerTypeId
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "add hero star error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar)
    self.heroAddStarCallbacl = nil
  end
  do
    local heroDiffMsg = (msg.syncUpdateDiff).hero
    if heroDiffMsg == nil then
      error("star up don\'t have heroDiff")
    end
    local heroUpdateDic = heroDiffMsg.update
    if heroUpdateDic == nil then
      error("star up don\'t have heroDiff")
    else
      if (table.count)(heroUpdateDic) ~= 1 then
        error("starup has mult hero data change, please check")
      end
    end
    local starupDataDiff, heroData = nil, nil
    for heroId,heroMsg in pairs(heroUpdateDic) do
      heroData = PlayerDataCenter:GetHeroData(heroId)
      local skillLevelDic = {}
      for skillId,skillData in pairs(heroData.skillDic) do
        skillLevelDic[skillId] = skillData.level
      end
      starupDataDiff = {heroId = heroId, oldRank = heroData.rank, oldpower = heroData:GetFightingPower(), oldAthslotList = heroData:GetAthSlotList(), oldSkillLevelDic = skillLevelDic}
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.MinHeroStar)
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.MaxHeroStar)
    starupDataDiff.curRank = heroData.rank
    starupDataDiff.curPower = heroData:GetFightingPower()
    starupDataDiff.curAthslotList = heroData:GetAthSlotList()
    local skillLevelDic = {}
    for skillId,skillData in pairs(heroData.skillDic) do
      skillLevelDic[skillId] = skillData.level
    end
    starupDataDiff.skillLevelDic = skillLevelDic
    MsgCenter:Broadcast(eMsgEventId.OnHeroRankChange, starupDataDiff.heroId)
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    -- function num : 0_9_0 , upvalues : _ENV, starupDataDiff, self
    if window == nil then
      return 
    end
    local skinId = nil
    local preRankCfg = ((ConfigData.hero_star)[starupDataDiff.heroId])[starupDataDiff.curRank]
    if preRankCfg ~= nil then
      for index,itemId in ipairs(preRankCfg.rank_itemIds) do
        local itemConfig = (ConfigData.item)[itemId]
        if itemConfig ~= nil and itemConfig.type == eItemType.Skin then
          skinId = itemId
          self:CS_HERO_SkinChange(starupDataDiff.heroId, skinId or 0)
          break
        end
      end
    end
    do
      window:InitGetHeroList({starupDataDiff.heroId}, true, nil, nil, nil, nil, {[starupDataDiff.heroId] = skinId})
      local oldPower = starupDataDiff.oldpower
      local curPower = starupDataDiff.curPower
      window:SetCloseFunction(BindCallback(self, function()
      -- function num : 0_9_0_0 , upvalues : _ENV, starupDataDiff, self, oldPower, curPower
      UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUpSuccess, function(win)
        -- function num : 0_9_0_0_0 , upvalues : starupDataDiff, _ENV, self, oldPower, curPower
        win:InitStarUpSuccess(starupDataDiff)
        win:SetStarUpSuccessCloseCallBack(BindCallback(self, self.__ShowHeroPowerUpSuccess, oldPower, curPower))
      end
)
    end
, oldPower, curPower, window))
      AudioManager:PlayAudioById(1024)
      if self.heroAddStarCallbacl ~= nil then
        (self.heroAddStarCallbacl)()
        self.heroAddStarCallbacl = nil
      end
    end
  end
)
  end
end

HeroNetworkCtrl.SendHeroSkillUp = function(self, heroId, skillId, callback)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local msgTab = {hero = heroId, skill = skillId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_SkillUpgrade, proto_csmsg.CS_HERO_SkillUpgrade, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_SkillUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_SkillUpgrade)
  local saveLast = {}
  saveLast.type = LastSendType.HeroSkillUp
  saveLast.heroId = heroId
  saveLast.skillId = skillId
  saveLast.fightingPower = (PlayerDataCenter:GetHeroData(heroId)):GetFightingPower()
  ;
  (table.insert)(self.lastSendDataList, saveLast)
end

HeroNetworkCtrl.OnUpdateHeroEvent = function(self, heroList)
  -- function num : 0_11 , upvalues : _ENV, LastSendType, HeroEnterDataUtil
  if #self.lastSendDataList == 0 then
    return 
  end
  local lastData = (table.remove)(self.lastSendDataList, 1)
  -- DECOMPILER ERROR at PC24: Unhandled construct in 'MakeBoolean' P1

  if lastData.type == LastSendType.HeroLevelUp and lastData.level < (lastData.heroData).level then
    local win = UIManager:ShowWindow(UIWindowTypeID.MessageSide)
    if win ~= nil then
      local number = (lastData.heroData):GetFightingPower() - lastData.fightingPower
      win:ShowTips(number, 2.5, eMessageSideType.efficiency)
    end
  end
  do
    if lastData.type == LastSendType.HeroSkillUp then
      local heroData = (PlayerDataCenter.heroDic)[lastData.heroId]
      if heroData ~= nil then
        local skillData = (heroData.skillDic)[lastData.skillId]
        if skillData ~= nil then
          if skillData.type == eHeroSkillType.LifeSkill then
            HeroEnterDataUtil:OnLifeSkillLevelUp(skillData)
          end
          local window = UIManager:ShowWindow(UIWindowTypeID.MessageSide)
          if window ~= nil then
            window:ShowTips(ConfigData:GetTipContent(TipContent.hero_Skill_upgradeSuccess))
          end
          self:__ShowHeroPowerUpSuccess(lastData.fightingPower, (heroData:GetFightingPower()), nil)
        end
      end
    else
    end
    do
      if lastData.type == LastSendType.HeroPotential then
      end
    end
  end
end

HeroNetworkCtrl.SendFormationFresh = function(self, formationId, data)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.sendFormationData).id = formationId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.sendFormationData).data = data
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh, proto_csmsg.CS_HERO_FormationFresh, self.sendFormationData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh, proto_csmsg_MSG_ID.MSG_SC_HERO_FormationFresh)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

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
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
  else
    local errorMsg = "HeroNetworkCtrl:SC_HERO_FormationNameFresh error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(errorMsg)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
  end
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.__ShowHeroPowerUpSuccess = function(self, lastHeroPower, curHeroPower, window, callback)
  -- function num : 0_16 , upvalues : _ENV
  if window ~= nil then
    window:Delete()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
    -- function num : 0_16_0 , upvalues : lastHeroPower, curHeroPower, callback
    if win ~= nil then
      win:InitHeroPowerUpSuccess(lastHeroPower, curHeroPower)
      win:SetBackClickAction(callback)
    end
  end
)
end

HeroNetworkCtrl.CS_RECOMMANDFORMATION_Detail = function(self, stageId)
  -- function num : 0_17 , upvalues : _ENV, cs_WaitNetworkResponse
  local sendData = {Id = stageId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg.CS_RECOMMANDFORMATION_Detail, sendData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail)
end

HeroNetworkCtrl.SC_RECOMMANDFORMATION_Detail = function(self, msg)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_RECOMMANDFORMATION_Detail error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      return 
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
    local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
    recommeCtr:ReceiveRecommeFormation(msg)
  end
end

HeroNetworkCtrl.CS_HERO_PotentialUpgrade = function(self, heroId, callBack)
  -- function num : 0_19 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
  local sendData = {hero = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, proto_csmsg.CS_HERO_PotentialUpgrade, sendData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_PotentialUpgrade)
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  if heroData ~= nil then
    local saveLast = {}
    saveLast.type = LastSendType.HeroPotential
    self:SaveLastHeroData(saveLast, heroData)
    ;
    (table.insert)(self.lastSendDataList, saveLast)
  end
end

HeroNetworkCtrl.SC_HERO_PotentialUpgrade = function(self, msg)
  -- function num : 0_20 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_PotentialUpgrade error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, (self.lastSendDataList)[#self.lastSendDataList])
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.CS_HERO_SkinChange = function(self, heroId, skinId, callback)
  -- function num : 0_21 , upvalues : _ENV, cs_WaitNetworkResponse
  self.heroSkinChange = {hero = heroId, skin = skinId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_SkinChange, proto_csmsg.CS_HERO_SkinChange, self.heroSkinChange)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_SkinChange)
end

HeroNetworkCtrl.SC_HERO_SkinChange = function(self, msg)
  -- function num : 0_22 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_SkinChange error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_SkinChange)
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
    if msg.ret == proto_csmsg_ErrorCode.None then
      MsgCenter:Broadcast(eMsgEventId.OnHeroSkinChange, (self.heroSkinChange).hero, (self.heroSkinChange).skin)
    end
  end
end

HeroNetworkCtrl.CS_HERO_Record = function(self, heroId, type, val, callBack)
  -- function num : 0_23 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.heroRecordMsg).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.heroRecordMsg).typ = type
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.heroRecordMsg).val = val
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_Record, proto_csmsg.CS_HERO_Record, self.heroRecordMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_Record, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_Record)
end

HeroNetworkCtrl.SC_HERO_Record = function(self, msg)
  -- function num : 0_24 , upvalues : _ENV, cs_MessageCommon
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_Record error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      return 
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.Reset = function(self)
  -- function num : 0_25
  self.lastSendDataList = {}
  self.lastSendFormation = {}
end

return HeroNetworkCtrl

