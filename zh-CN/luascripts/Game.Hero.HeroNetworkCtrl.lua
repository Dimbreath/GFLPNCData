-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroNetworkCtrl = class("HeroNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
local LastSendType = {HeroLevelUp = 1, HeroSkillUp = 3, HeroPotential = 4}
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
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail, self, proto_csmsg.SC_RECOMMANDFORMATION_Detail, self.SC_RECOMMANDFORMATION_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_HERO_PotentialUpgrade, self, proto_csmsg.SC_HERO_PotentialUpgrade, self.SC_HERO_PotentialUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_BatterHero, self, proto_csmsg.SC_DAILYCHALLENGE_BatterHero, self.SC_DAILYCHALLENGE_BatterHero)
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
  end
  do
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
  -- function num : 0_4 , upvalues : _ENV, cs_MessageCommon
  do
    if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "hero formation fresh error:" .. tostring(msg.ret)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      error(err)
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

HeroNetworkCtrl.SendHeroAddExp = function(self, heroId, itemTab)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
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

HeroNetworkCtrl.SendHeroAddStar = function(self, heroId, callback)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  local msgTab = {hero = heroId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, proto_csmsg.CS_HERO_AddStar, msgTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar, callback, proto_csmsg_MSG_ID.MSG_SC_HERO_AddStar)
end

HeroNetworkCtrl.On_SC_HERO_AddStar = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret and msg.ret ~= proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "add hero star error:" .. tostring(msg.ret)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_HERO_AddStar)
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
    -- function num : 0_9_0 , upvalues : starupDataDiff, _ENV, self
    if window == nil then
      return 
    end
    window:InitGetHeroList({starupDataDiff.heroId}, true)
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
  -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

  if lastData.type == LastSendType.HeroLevelUp and lastData.level < (lastData.heroData).level then
    HeroEnterDataUtil:OnHeroLevelChange(lastData.level, (lastData.heroData).level, lastData.heroId)
    local win = UIManager:ShowWindow(UIWindowTypeID.HeroLevelUpSuccess)
    win:InitHeroLevelData(lastData, lastData.heroData)
    win:SetLevelUpBackClickAction(function()
    -- function num : 0_11_0 , upvalues : _ENV, lastData
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
      -- function num : 0_11_0_0 , upvalues : lastData
      if win ~= nil then
        win:InitHeroPowerUpSuccess(lastData.fightingPower, (lastData.heroData):GetFightingPower())
      end
    end
)
  end
)
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
          UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    -- function num : 0_11_1 , upvalues : _ENV
    if window == nil then
      return 
    end
    window:ShowTips(ConfigData:GetTipContent(TipContent.hero_Skill_upgradeSuccess))
  end
)
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
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
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

HeroNetworkCtrl.CS_DAILYCHALLENGE_BatterHero = function(self, callBack)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_BatterHero, proto_csmsg.CS_DAILYCHALLENGE_BatterHero, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_BatterHero, callBack, proto_csmsg_MSG_ID.MSG_SC_DAILYCHALLENGE_BatterHero)
end

HeroNetworkCtrl.SC_DAILYCHALLENGE_BatterHero = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "HeroNetworkCtrl:SC_DAILYCHALLENGE_BatterHero error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_BatterHero)
      return 
    end
    msg.battle = msg.hero
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DAILYCHALLENGE_BatterHero, msg)
  end
end

HeroNetworkCtrl.CS_BATTLE_ReqPlayerDetail = function(self, callBack)
  -- function num : 0_20 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqPlayerDetail, proto_csmsg.CS_BATTLE_ReqPlayerDetail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BATTLE_ReqPlayerDetail, callBack, proto_csmsg_MSG_ID.MSG_SC_BATTLE_ReqPlayerDetail)
end

HeroNetworkCtrl.SC_BATTLE_ReqPlayerDetail = function(self, msg)
  -- function num : 0_21 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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

HeroNetworkCtrl.__ShowHeroPowerUpSuccess = function(self, lastHeroPower, curHeroPower, window, callback)
  -- function num : 0_22 , upvalues : _ENV
  if window ~= nil then
    window:Delete()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPowerUpSuccess, function(win)
    -- function num : 0_22_0 , upvalues : lastHeroPower, curHeroPower, callback
    if win ~= nil then
      win:InitHeroPowerUpSuccess(lastHeroPower, curHeroPower)
      win:SetBackClickAction(callback)
    end
  end
)
end

HeroNetworkCtrl.CS_RECOMMANDFORMATION_Detail = function(self, stageId)
  -- function num : 0_23 , upvalues : _ENV, cs_WaitNetworkResponse
  local sendData = {Id = stageId}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg.CS_RECOMMANDFORMATION_Detail, sendData)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_RECOMMANDFORMATION_Detail, proto_csmsg_MSG_ID.MSG_SC_RECOMMANDFORMATION_Detail)
end

HeroNetworkCtrl.SC_RECOMMANDFORMATION_Detail = function(self, msg)
  -- function num : 0_24 , upvalues : _ENV, cs_MessageCommon
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
    local formationCtr = ControllerManager:GetController(ControllerTypeId.Formation, true)
    formationCtr:ReceiveRecommeFormation(msg)
  end
end

HeroNetworkCtrl.CS_HERO_PotentialUpgrade = function(self, heroId, callBack)
  -- function num : 0_25 , upvalues : _ENV, cs_WaitNetworkResponse, LastSendType
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
  -- function num : 0_26 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
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

HeroNetworkCtrl.Reset = function(self)
  -- function num : 0_27
  self.lastSendDataList = {}
  self.lastSendFormation = {}
end

return HeroNetworkCtrl

