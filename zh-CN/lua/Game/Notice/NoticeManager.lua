local NoticeManager = {}
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
NoticeManager.eNoticeType = {None = 0, Mail = 1, ResourceGenerateOverflow = 5, HasOasisBuildingOperate = 6, HasSectorBuildingOperate = 7, FragDungeonRefresh = 8, ResDungeonRefresh = 9, ATHDungeonRefresh = 10, FactoryEnergyFull = 13, dailyChallenge = 14, FunctionUnlock = 15, FactoryUnlockNewFactory = 16, FactoryUnlockNewOrder = 17, OasisAreaUnlock = 18, OasisBuildingUnlock = 19, AchievementAchieved = 20, SectorTask = 21, StrategyOverviewSkillUnlcok = 22, GrowBagLevelup = 23, weeklyChallenge = 24, dungeonMultReward = 25}
NoticeManager.eNoticeShowType = {defualt = 0, down = 1, mid = 2, left = 3}
NoticeManager.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.sideNoticeList = {}
  self.redDotCount = 0
  self.preConditionDick = {}
  self.__IsPauseNotice = true
  self.__pauseLocksDic = {}
  self.__BC_Listern2PreConditona = BindCallback(self, self.__Listern2PreConditon)
  self.__PuaseShowNotice = BindCallback(self, self.PuaseShowNotice, "exp")
  self.__ContinueShowNotice = BindCallback(self, self.ContinueShowNotice, "exp")
  MsgCenter:AddListener(eMsgEventId.PreCondition, self.__BC_Listern2PreConditona)
  MsgCenter:AddListener(eMsgEventId.ExplorationEnterComplete, self.__PuaseShowNotice)
  MsgCenter:AddListener(eMsgEventId.ExplorationExit, self.__ContinueShowNotice)
end

NoticeManager.Add2PreConditionDic = function(self, pre_conditionId, pre_para1, pre_para2, function4unlock)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  if (self.preConditionDick)[pre_conditionId] == nil then
    (self.preConditionDick)[pre_conditionId] = {}
  end
  ;
  (table.insert)((self.preConditionDick)[pre_conditionId], {pre_para1 = pre_para1, pre_para2 = pre_para2, function4unlock = function4unlock})
end

NoticeManager.__Listern2PreConditon = function(self, conditionId)
  -- function num : 0_2 , upvalues : _ENV
  if (self.preConditionDick)[conditionId] ~= nil then
    for index = #(self.preConditionDick)[conditionId], 1, -1 do
      local data = ((self.preConditionDick)[conditionId])[index]
      if (data.function4unlock)() then
        (table.remove)((self.preConditionDick)[conditionId], index)
      end
    end
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    if #(self.preConditionDick)[conditionId] == 0 then
      (self.preConditionDick)[conditionId] = nil
    end
  end
end

local noticeFuncTable = {[(NoticeManager.eNoticeType).AchievementAchieved] = function(self, noticeData)
  -- function num : 0_3 , upvalues : _ENV
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement) then
    self:DeleteNoticeByType(noticeData.type)
    self:__AddNotice2List(noticeData)
    self:ShowNotice(noticeData)
  end
end
, [(NoticeManager.eNoticeType).FactoryEnergyFull] = function(self, noticeData)
  -- function num : 0_4 , upvalues : _ENV
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory) then
    if self:GetIsHaveThisTypeNotice(noticeData.type) then
      return true
    end
    self:__AddNotice2List(noticeData)
    self:ShowNotice(noticeData)
  end
end
, default = function(self, noticeData)
  -- function num : 0_5
  if noticeData:GetIsMerge() then
    self:DeleteNoticeByType(noticeData.type)
  end
  self:__AddNotice2List(noticeData)
  self:ShowNotice(noticeData)
end
}
NoticeManager.AddNotice = function(self, noticeData)
  -- function num : 0_6 , upvalues : _ENV, noticeFuncTable
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Message_Push) then
    return 
  end
  local homeSideInfoCfg = (ConfigData.homeside_info)[noticeData.type]
  local isOFF = ((PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetNoticeSwitchOff())[noticeData.type]
  if isOFF and homeSideInfoCfg.switch_type ~= nil and homeSideInfoCfg.switch_type ~= 0 then
    return 
  end
  local donnotAddReddot = false
  local isThisTypeUnlock = homeSideInfoCfg.info_type ~= 0
  if isThisTypeUnlock then
    if noticeFuncTable[noticeData.type] ~= nil then
      donnotAddReddot = (noticeFuncTable[noticeData.type])(self, noticeData)
    else
      donnotAddReddot = (noticeFuncTable.default)(self, noticeData)
    end
  else
    return 
  end
  do
    if not donnotAddReddot and self.sideNoticeList ~= nil then
      local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
      self.redDotCount = self.redDotCount + (noticeData:IsNeedRedDot() and 1 or 0)
      noticeNode:SetRedDotCount(self.redDotCount)
    end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end
end

NoticeManager.GetIsHaveThisTypeNotice = function(self, type)
  -- function num : 0_7 , upvalues : _ENV
  for _,sideNoticeData in pairs(self.sideNoticeList) do
    if sideNoticeData.type == type then
      return true
    end
  end
  return false
end

NoticeManager.DeleteNotice = function(self, noticeData)
  -- function num : 0_8 , upvalues : _ENV
  (table.removebyvalue)(self.sideNoticeList, noticeData)
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  self.redDotCount = self.redDotCount - (noticeData:IsNeedRedDot() and 1 or 0)
  noticeNode:SetRedDotCount(self.redDotCount)
end

NoticeManager.DeleteNoticeByType = function(self, type)
  -- function num : 0_9 , upvalues : _ENV
  for i = #self.sideNoticeList, 1, -1 do
    if not ((self.sideNoticeList)[i]):IsNeedRedDot() or not 1 then
      do
        self.redDotCount = self.redDotCount - (((self.sideNoticeList)[i]).type ~= type or 0)
        ;
        (table.remove)(self.sideNoticeList, i)
        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  noticeNode:SetRedDotCount(self.redDotCount)
end

NoticeManager.DeleteNoticeByFunc = function(self, func)
  -- function num : 0_10 , upvalues : _ENV
  for i = #self.sideNoticeList, 1, -1 do
    if not ((self.sideNoticeList)[i]):IsNeedRedDot() or not 1 then
      do
        self.redDotCount = self.redDotCount - (not func((self.sideNoticeList)[i]) or 0)
        ;
        (table.remove)(self.sideNoticeList, i)
        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  noticeNode:SetRedDotCount(self.redDotCount)
end

NoticeManager.__AddNotice2List = function(self, noticeData)
  -- function num : 0_11 , upvalues : _ENV
  if not noticeData:GetIsPutInHomeside() then
    return 
  end
  local left = 1
  local right = #self.sideNoticeList
  local mid = nil
  while 1 do
    while 1 do
      if left <= right then
        mid = (left + right) // 2
        if noticeData.timeStamp <= ((self.sideNoticeList)[mid]).timeStamp then
          left = mid + 1
          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    right = mid - 1
  end
  ;
  (table.insert)(self.sideNoticeList, left, noticeData)
end

NoticeManager.ShowNotice = function(self, noticeData)
  -- function num : 0_12 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.NoticeMessagePush, function(window)
    -- function num : 0_12_0 , upvalues : noticeData, self
    if window == nil then
      return 
    end
    window:AddNotice(noticeData, self.__IsPauseNotice)
  end
)
end

NoticeManager.PuaseShowNotice = function(self, way)
  -- function num : 0_13 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__pauseLocksDic)[way] = true
  if self.__IsPauseNotice then
    return 
  end
  self.__IsPauseNotice = true
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:PuaseShowNotice()
    return 
  end
end

NoticeManager.ContinueShowNotice = function(self, way)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__pauseLocksDic)[way] = nil
  if self.__pauseLocksDic ~= nil and (table.count)(self.__pauseLocksDic) > 0 then
    return 
  end
  if GuideManager.inGuide then
    return 
  end
  if self.__IsPauseNotice == false then
    return 
  end
  self.__IsPauseNotice = false
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:ContinueShowNotice()
    return 
  end
end

NoticeManager.ForceContinueShowNotice = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if GuideManager.inGuide then
    return 
  end
  if self.__IsPauseNotice == false then
    return 
  end
  self.__IsPauseNotice = false
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:ContinueShowNotice()
    return 
  end
end

NoticeManager.GetSideNoticeList = function(self)
  -- function num : 0_16
  return self.sideNoticeList
end

NoticeManager.CleanAllNotice = function(self)
  -- function num : 0_17 , upvalues : _ENV
  self.sideNoticeList = {}
  self.redDotCount = 0
  local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
  noticeNode:SetRedDotCount(self.redDotCount)
end

NoticeManager.OnLogOut = function(self)
  -- function num : 0_18 , upvalues : _ENV
  self.preConditionDick = {}
  self.sideNoticeList = {}
  self.redDotCount = 0
  self.__IsPauseNotice = true
  self.__pauseLocksDic = {}
  local win = UIManager:GetWindow(UIWindowTypeID.NoticeMessagePush)
  if win ~= nil then
    win:Delete()
  end
end

NoticeManager.RefreshDungeonRewardRateNotice = function(self, isPassDay, isLogIn)
  -- function num : 0_19 , upvalues : _ENV, eDungeonEnum, JumpManager, NoticeData
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local weekNum = timepassCtrl:GetLogicWeekNum()
  if isLogIn then
    local lastLogoutWeekTs = (PlayerDataCenter.inforData):GetLastOffLinTem()
    if PlayerDataCenter.timestamp - lastLogoutWeekTs < 86400 then
      local lastLogoutWeekNum = timepassCtrl:GetLogicWeekNum(lastLogoutWeekTs)
      if lastLogoutWeekNum == weekNum then
        return 
      end
    end
  end
  do
    local logics = (PlayerDataCenter.serverLogic)[eLogicType.DungeonRewardRate]
    if logics == nil then
      return 
    end
    for _,logic in pairs(logics) do
      if logic[2] == weekNum or logic[2] == 0 then
        local dungeonTypeList = ((ConfigData.material_dungeon).dungeonTypeDic)[logic[1]]
        local theDungeonSystemId = nil
        for _,dungeonSystemId in pairs(dungeonTypeList) do
          if FunctionUnlockMgr:ValidateUnlock(dungeonSystemId) and (theDungeonSystemId == nil or theDungeonSystemId < dungeonSystemId) then
            theDungeonSystemId = dungeonSystemId
          end
        end
        if theDungeonSystemId ~= nil then
          local dungeonCfg = (ConfigData.material_dungeon)[theDungeonSystemId]
          local jumpType = nil
          if dungeonCfg.ui_type == (eDungeonEnum.eDungeonType).matDungeon then
            jumpType = (JumpManager.eJumpTarget).resourceDungeon
          else
            if dungeonCfg.ui_type == (eDungeonEnum.eDungeonType).ATHDungeon then
              jumpType = (JumpManager.eJumpTarget).ATHDungeon
            else
              if dungeonCfg.ui_type == (eDungeonEnum.eDungeonType).fragDungeon then
                jumpType = (JumpManager.eJumpTarget).fragDungeon
                theDungeonSystemId = nil
              end
            end
          end
          local dungeonName = (LanguageUtil.GetLocaleText)(dungeonCfg.name)
          self:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (self.eNoticeType).dungeonMultReward, {jumpType = jumpType, 
argList = {theDungeonSystemId}
}, {dungeonName}, nil))
        end
      end
    end
  end
end

NoticeManager:Init()
return NoticeManager

