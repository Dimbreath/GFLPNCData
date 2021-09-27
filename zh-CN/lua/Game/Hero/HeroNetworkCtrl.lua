local HeroNetworkCtrl = class("HeroNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local util = require("XLua.Common.xlua_util")
local LastSendType = {HeroLevelUp = 1, HeroSkillUp = 3, HeroPotential = 4, HeroQuest = 5}
HeroNetworkCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.reqHeroDetailTab = {}
  self.lastSendDataList = {}
  self.sendFormationData = {}
  self.fmtNameFreshData = {}
  self.heroSkinChange = {}
  self.heroRecordMsg = {}
  self.heroQuestMsg = {}
  self.mergeMsg = {}
  self.__onUpdateHeroEvent = BindCallback(self, self.OnUpdateHeroEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onUpdateHeroEvent)
end

HeroNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar, self, proto_csmsg.SC_HERO_AddStar, self.On_SC_HERO_AddStar)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SkillUpgrade, self, proto_csmsg.SC_HERO_SkillUpgrade, self.On_SC_HERO_SkillUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationFresh, self, proto_csmsg.SC_HERO_FormationFresh, self.On_SC_HERO_FormationFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_FormationNameFresh, self, proto_csmsg.SC_HERO_FormationNameFresh, self.SC_HERO_FormationNameFresh)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail, self, proto_csmsg.SC_RECOMMANDFORMATION_Detail, self.SC_RECOMMANDFORMATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_PotentialUpgrade, self, proto_csmsg.SC_HERO_PotentialUpgrade, self.SC_HERO_PotentialUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_SkinChange, self, proto_csmsg.SC_HERO_SkinChange, self.SC_HERO_SkinChange)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Record, self, proto_csmsg.SC_HERO_Record, self.SC_HERO_Record)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_Upgrade, self, proto_csmsg.SC_HERO_Upgrade, self.SC_HERO_Upgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_QuestFinish, self, proto_csmsg.SC_HERO_QuestFinish, self.SC_HERO_QuestFinish)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_HeroOneKeyPick, self, proto_csmsg.SC_QUEST_HeroOneKeyPick, self.SC_QUEST_HeroOneKeyPick)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_MERGE, self, proto_csmsg.SC_HERO_MERGE, self.SC_HERO_MERGE)
end

HeroNetworkCtrl.SC_HERO_Upgrade = function(self, msg)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "add hero exp error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
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
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "add skill level error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      ;
      (table.remove)(self.lastSendDataList, 1)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.CS_HERO_SkillUpgrade)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.On_SC_HERO_FormationFresh = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "hero formation fresh error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationFresh)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.SaveLastHeroData = function(self, saveLast, heroData)
  -- function num : 0_5 , upvalues : _ENV
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
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
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
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  local msgTab = {hero = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg.CS_HERO_AddStar, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar)
  self.heroAddStarCallbacl = callback
end

HeroNetworkCtrl.On_SC_HERO_AddStar = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse, util
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "add hero star error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar)
    self.heroAddStarCallbacl = nil
  end
  do
    local starupDataDiff, heroData, itemIds, itemCounts = self:_GetHeroStarDiffData(msg)
    if self.__starUpCoroutine ~= nil then
      (GR.StopCoroutine)(self.__starUpCoroutine)
      self.__starUpCoroutine = nil
    end
    self.__starUpCoroutine = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self._ShowHeroStarWindows, starupDataDiff, heroData, itemIds, itemCounts)))
  end
end

HeroNetworkCtrl._GetHeroStarDiffData = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, CheckerTypeId
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
  local starupDataDiff, heroData, rewardDiff = nil, nil, nil
  for heroId,heroMsg in pairs(heroUpdateDic) do
    heroData = PlayerDataCenter:GetHeroData(heroId)
    local skillLevelDic = {}
    for skillId,skillData in pairs(heroData.skillDic) do
      skillLevelDic[skillId] = skillData.level
    end
    starupDataDiff = {heroId = heroId, oldRank = heroData.rank, oldpower = heroData:GetFightingPower(), oldAthslotList = heroData:GetAthSlotList(), oldSkillLevelDic = skillLevelDic}
  end
  local updatesMsg = (((msg.syncUpdateDiff).resource).backpack).updates
  if updatesMsg ~= nil then
    rewardDiff = 
    for itemId,count in ({})(updatesMsg) do
      rewardDiff[itemId] = PlayerDataCenter:GetItemCount(itemId)
    end
  end
  do
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
    local itemIds, itemCounts = nil, nil
    if rewardDiff ~= nil then
      itemIds = {}
      itemCounts = {}
      for itemId,data in pairs(updatesMsg) do
        local count = data.count - rewardDiff[itemId]
        if count > 0 then
          (table.insert)(itemIds, itemId)
          ;
          (table.insert)(itemCounts, count)
        end
      end
    end
    do
      return starupDataDiff, heroData, itemIds, itemCounts
    end
  end
end

HeroNetworkCtrl._ShowHeroStarWindows = function(self, starupDataDiff, heroData, itemIds, itemCounts)
  -- function num : 0_10 , upvalues : _ENV
  local getHeroComplete = false
  UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    -- function num : 0_10_0 , upvalues : heroData, _ENV, starupDataDiff, self, getHeroComplete
    if window == nil then
      return 
    end
    local skinId = heroData.skinId or 0
    local preRankCfg = ((ConfigData.hero_star)[starupDataDiff.heroId])[starupDataDiff.curRank]
    if preRankCfg ~= nil then
      for index,itemId in ipairs(preRankCfg.rank_itemIds) do
        local itemConfig = (ConfigData.item)[itemId]
        if itemConfig ~= nil and itemConfig.type == eItemType.Skin and (PlayerDataCenter.skinData):IsUseful(itemId) then
          skinId = itemId
          self:CS_HERO_SkinChange(starupDataDiff.heroId, skinId or 0)
          break
        end
      end
    end
    do
      window:InitGetHeroList({starupDataDiff.heroId}, true, nil, nil, nil, nil, {[starupDataDiff.heroId] = skinId})
      window:SetCloseFunction(function()
      -- function num : 0_10_0_0 , upvalues : getHeroComplete
      getHeroComplete = true
    end
)
      AudioManager:PlayAudioById(1024)
      if self.heroAddStarCallbacl ~= nil then
        (self.heroAddStarCallbacl)()
        self.heroAddStarCallbacl = nil
      end
    end
  end
)
  while not getHeroComplete do
    (coroutine.yield)()
  end
  local starUpSuccess = false
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUpSuccess, function(win)
    -- function num : 0_10_1 , upvalues : starupDataDiff, starUpSuccess
    win:InitStarUpSuccess(starupDataDiff)
    win:SetStarUpSuccessCloseCallBack(function()
      -- function num : 0_10_1_0 , upvalues : starUpSuccess
      starUpSuccess = true
    end
)
  end
)
  while not starUpSuccess do
    (coroutine.yield)()
  end
  local PowerUpSuccess = false
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
    -- function num : 0_10_2 , upvalues : starupDataDiff, PowerUpSuccess
    if win ~= nil then
      win:InitHeroPowerUpSuccess(starupDataDiff.oldpower, starupDataDiff.curPower)
      win:SetBackClickAction(function()
      -- function num : 0_10_2_0 , upvalues : PowerUpSuccess
      PowerUpSuccess = true
    end
)
    end
  end
)
  while not PowerUpSuccess do
    (coroutine.yield)()
  end
  if #itemIds <= 0 then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(win)
    -- function num : 0_10_3 , upvalues : itemIds, itemCounts
    win:InitRewardsItem(itemIds, itemCounts)
  end
)
end

HeroNetworkCtrl.SendHeroSkillUp = function(self, heroId, skillId, callback)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
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
  -- function num : 0_12 , upvalues : _ENV, LastSendType, HeroEnterDataUtil
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
          self:__ShowHeroPowerUpSuccess(lastData.fightingPower, heroData:GetFightingPower())
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
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
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
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None or msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
    local formationUI = UIManager:GetWindow(UIWindowTypeID.Formation)
    if formationUI ~= nil then
      formationUI:OnEditFormationNameError()
    end
  else
    do
      local errorMsg = "HeroNetworkCtrl:SC_HERO_FormationNameFresh error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_FormationNameFresh)
      do
        local formationUI = UIManager:GetWindow(UIWindowTypeID.Formation)
        if formationUI ~= nil then
          formationUI:OnEditFormationNameError()
        end
        NetworkManager:HandleDiff(msg.syncUpdateDiff)
      end
    end
  end
end

HeroNetworkCtrl.__ShowHeroPowerUpSuccess = function(self, lastHeroPower, curHeroPower, callback)
  -- function num : 0_16
end

HeroNetworkCtrl._OnShowbackpackUpdates = function(self, msgUpdates)
  -- function num : 0_17 , upvalues : _ENV
  if msgUpdates == nil then
    return 
  end
  local itemIds = {}
  local itemCounts = {}
  for itemId,count in pairs(msgUpdates) do
    if count > 0 then
      (table.insert)(itemIds, itemId)
      ;
      (table.insert)(itemCounts, count)
    end
  end
  if #itemIds <= 0 then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(win)
    -- function num : 0_17_0 , upvalues : itemIds, itemCounts
    win:InitRewardsItem(itemIds, itemCounts)
  end
)
end

HeroNetworkCtrl.CS_RECOMMANDFORMATION_Detail = function(self, stageId)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitNetworkResponse
  local sendData = {Id = stageId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg.CS_RECOMMANDFORMATION_Detail, sendData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail)
end

HeroNetworkCtrl.SC_RECOMMANDFORMATION_Detail = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_RECOMMANDFORMATION_Detail error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      return 
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
    local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
    recommeCtr:ReceiveRecommeFormation(msg)
  end
end

HeroNetworkCtrl.CS_HERO_PotentialUpgrade = function(self, heroId, callBack)
  -- function num : 0_20 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
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
  -- function num : 0_21 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_PotentialUpgrade error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade)
      return 
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, (self.lastSendDataList)[#self.lastSendDataList])
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.CS_HERO_SkinChange = function(self, heroId, skinId, callback)
  -- function num : 0_22 , upvalues : _ENV, cs_WaitNetworkResponse
  if not (PlayerDataCenter.skinData):IsUseful(skinId) then
    error("skin is locked")
    return 
  end
  self.heroSkinChange = {hero = heroId, skin = skinId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_SkinChange, proto_csmsg.CS_HERO_SkinChange, self.heroSkinChange)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_PotentialUpgrade, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_SkinChange)
end

HeroNetworkCtrl.SC_HERO_SkinChange = function(self, msg)
  -- function num : 0_23 , upvalues : _ENV, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_SkinChange error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
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
  -- function num : 0_24 , upvalues : _ENV, cs_WaitNetworkResponse
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
  -- function num : 0_25 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_Record error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      return 
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.CS_HERO_QuestFinish = function(self, heroId, idx, callBack)
  -- function num : 0_26 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.heroQuestMsg).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.heroQuestMsg).idx = idx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_QuestFinish, proto_csmsg.CS_HERO_QuestFinish, self.heroQuestMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_QuestFinish, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_QuestFinish)
end

HeroNetworkCtrl.SC_HERO_QuestFinish = function(self, msg)
  -- function num : 0_27 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_QuestFinish error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      return 
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.CS_QUEST_HeroOneKeyPick = function(self, heroId, idxs, backAction)
  -- function num : 0_28 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.heroId = heroId
  msg.idx = idxs
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_HeroOneKeyPick, proto_csmsg.CS_QUEST_HeroOneKeyPick, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_HeroOneKeyPick, backAction, proto_csmsg_MSG_ID.MSG_SC_QUEST_HeroOneKeyPick)
end

HeroNetworkCtrl.SC_QUEST_HeroOneKeyPick = function(self, msg)
  -- function num : 0_29 , upvalues : _ENV
  local items = {}
  for itemId,num in pairs(msg.rewards) do
    local itemCfg = (ConfigData.item)[itemId]
    if not itemCfg.is_shielded then
      (table.insert)(items, {id = itemId, warehouse_order = itemCfg.warehouse_order, count = num})
    end
  end
  ;
  (table.sort)(items, function(a, b)
    -- function num : 0_29_0
    if a.id >= b.id then
      do return a.warehouse_order ~= b.warehouse_order end
      do return a.warehouse_order < b.warehouse_order end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local rewardIds = {}
  local rewardNums = {}
  for k,v in pairs(items) do
    (table.insert)(rewardIds, v.id)
    ;
    (table.insert)(rewardNums, v.count)
  end
  if #rewardIds > 0 then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_29_1 , upvalues : rewardIds, rewardNums, self
    if window == nil then
      return 
    end
    window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot, false, true)
  end
)
  end
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_QUEST_HeroOneKeyPick error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      return 
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.CS_HERO_MERGE = function(self, frageItemId, callBack)
  -- function num : 0_30 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.mergeMsg).itemId = frageItemId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_MERGE, proto_csmsg.CS_HERO_MERGE, self.mergeMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_MERGE, callBack, proto_csmsg_MSG_ID.MSG_SC_HERO_MERGE)
end

HeroNetworkCtrl.SC_HERO_MERGE = function(self, msg)
  -- function num : 0_31 , upvalues : _ENV
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_HERO_MERGE error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      return 
    end
    ;
    (NetworkManager.networkDiffDeliver):HandleDiff(msg.syncUpdateDiff)
  end
end

HeroNetworkCtrl.Reset = function(self)
  -- function num : 0_32 , upvalues : _ENV
  self.lastSendDataList = {}
  self.lastSendFormation = {}
  if self.__starUpCoroutine ~= nil then
    (GR.StopCoroutine)(self.__starUpCoroutine)
    self.__starUpCoroutine = nil
  end
end

return HeroNetworkCtrl

