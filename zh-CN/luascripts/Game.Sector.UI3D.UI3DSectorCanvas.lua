-- params : ...
-- function num : 0 , upvalues : _ENV
local UI3DSectorCanvas = class("UI3DSectorCanvas", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local UINSctItemInfo = require("Game.Sector.UI3D.UINSctItemInfo")
local UINSctItemProgress = require("Game.Sector.UI3D.UINSctItemProgress")
local SectorEnum = require("Game.Sector.SectorEnum")
local util = require("XLua.Common.xlua_util")
local UINChallengeInfoItem = require("Game.PeriodicChallenge.UI.UINChallengeInfoItem")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local DungeonTypeData = require("Game.Dungeon.DungeonTypeData")
UI3DSectorCanvas.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSctItemInfo, UINSctItemProgress, cs_ResLoader, DungeonTypeData
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).uI_STInfo):SetActive(false)
  ;
  ((self.ui).uI_STProgress):SetActive(false)
  self.sctInfoPool = (UIItemPool.New)(UINSctItemInfo, (self.ui).uI_STInfo)
  self.sctInfoDic = {}
  self.sctProgressPool = (UIItemPool.New)(UINSctItemProgress, (self.ui).uI_STProgress)
  self.sctProgressStageDic = {}
  self.sctProgressBuildDic = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btnFriendshipDungeon, self, self.EnterFriendshipDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnItemDungeon, self, self.EnterMatDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnATHDungeon, self, self.EnterATHDungeon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_dailyChallengeButton, self, self.OnClickDailyChallenge)
  self.__onDailyLimitUpdate = BindCallback(self, self.__dailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  self.localModelData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  self.resloader = (cs_ResLoader.Create)()
  self.dungeonUIElementDic = {
[(DungeonTypeData.eDungeonType).fragDungeon] = {lockUI = (self.ui).obj_FriendshipLock, limitText = (self.ui).friendLimitedText, doubleObj = (self.ui).obj_double_frage}
, 
[(DungeonTypeData.eDungeonType).matDungeon] = {lockUI = (self.ui).obj_ItemLock, limitText = (self.ui).matLimitedText, doubleObj = (self.ui).obj_double_mat}
, 
[(DungeonTypeData.eDungeonType).ATHDungeon] = {lockUI = (self.ui).obj_ATHLock, limitText = (self.ui).athLimitedText, doubleObj = (self.ui).obj_double_ath}
}
  self.sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  self.__periodicChangeRedDot = function(rednote)
    -- function num : 0_0_0 , upvalues : self
    self:RefreshPeriodicRedDot()
  end

  RedDotController:AddListener(RedDotDynPath.PeriodicChallenge, self.__periodicChangeRedDot)
end

UI3DSectorCanvas.SetDungeonUnlock = function(self, dungeonTypeData)
  -- function num : 0_1
  local UIElement = (self.dungeonUIElementDic)[dungeonTypeData:GetDungeonType()]
  local isUnlock = dungeonTypeData:GetDungeonTypeIsUnlock()
  ;
  (UIElement.lockUI):SetActive(not isUnlock)
  self:SetDungeonDailyLimit(dungeonTypeData)
end

UI3DSectorCanvas.SetDungeonDailyLimit = function(self, dungeonTypeData)
  -- function num : 0_2 , upvalues : _ENV
  local UIElement = (self.dungeonUIElementDic)[dungeonTypeData:GetDungeonType()]
  local isUnlock = dungeonTypeData:GetDungeonTypeIsUnlock()
  ;
  ((((UIElement.limitText).transform).parent).gameObject):SetActive(isUnlock)
  do
    if isUnlock then
      local leftNum, totaleLimit, playedNums = dungeonTypeData:GetDungeonTypePlayLeftLimitNum()
      if leftNum == -1 then
        ((((UIElement.limitText).transform).parent).gameObject):SetActive(false)
      else
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (UIElement.limitText).text = tostring(leftNum) .. "/" .. tostring(totaleLimit)
      end
    end
    local isHaveDouble = dungeonTypeData:GetIsHaveDouble()
    ;
    (UIElement.doubleObj):SetActive(isHaveDouble)
  end
end

UI3DSectorCanvas.__dailyLimitUpdate = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  for dungeonType,dungeonTypeData in pairs(sectorCtrl.dungeonTypeDataDic) do
    self:SetDungeonDailyLimit(dungeonTypeData)
  end
end

UI3DSectorCanvas.EnterFriendshipDungeon = function(self, jumpTargetHeroId, isForce)
  -- function num : 0_4 , upvalues : DungeonTypeData, cs_MessageCommon, _ENV, SectorEnum, util
  if not isForce and self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  local fragDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(DungeonTypeData.eDungeonType).fragDungeon]
  if fragDungeonTypeData == nil then
    (self.sectorCtrl):CheckAndSetDungeonUnlock()
    fragDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(DungeonTypeData.eDungeonType).fragDungeon]
  end
  if not fragDungeonTypeData:GetDungeonTypeIsUnlock() then
    (cs_MessageCommon.ShowMessageTips)(fragDungeonTypeData:GetDungeonTypeUnlockDes())
    return 
  end
  local loadFunc = function()
    -- function num : 0_4_0 , upvalues : self, _ENV, fragDungeonTypeData, jumpTargetHeroId, SectorEnum
    self.StartLoadFriendShipDungeon = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadFriendShipDungeon = false
    UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon, function(window)
      -- function num : 0_4_0_0 , upvalues : self, fragDungeonTypeData, jumpTargetHeroId, SectorEnum, _ENV
      if window == nil then
        return 
      end
      ;
      (self.sectorCtrl):OnEnterPlotOrMateralDungeon()
      window:InitPlotDungeon(fragDungeonTypeData, jumpTargetHeroId, function(tohome)
        -- function num : 0_4_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).FriendshipDungeonId)
      end
      UIManager:HideWindow(UIWindowTypeID.Sector)
      local HomeEnum = require("Game.Home.HomeEnum")
      MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).FragDungeonRefresh)
    end
)
  end

  if not self.StartLoadFriendShipDungeon then
    self.__loadFriendShipDungeon = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.EnterMatDungeon = function(self, jumpTargetTypeId, isForce)
  -- function num : 0_5 , upvalues : DungeonTypeData, cs_MessageCommon, _ENV, SectorEnum, util
  if not isForce and self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  local matDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(DungeonTypeData.eDungeonType).matDungeon]
  if matDungeonTypeData == nil then
    (self.sectorCtrl):CheckAndSetDungeonUnlock()
    matDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(DungeonTypeData.eDungeonType).matDungeon]
  end
  if not matDungeonTypeData:GetDungeonTypeIsUnlock() then
    (cs_MessageCommon.ShowMessageTips)(matDungeonTypeData:GetDungeonTypeUnlockDes())
    return 
  end
  local loadFunc = function()
    -- function num : 0_5_0 , upvalues : self, _ENV, matDungeonTypeData, jumpTargetTypeId, SectorEnum
    self.StartLoadMatDungeon = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadMatDungeon = false
    UIManager:ShowWindowAsync(UIWindowTypeID.MaterialDungeon, function(window)
      -- function num : 0_5_0_0 , upvalues : self, matDungeonTypeData, jumpTargetTypeId, SectorEnum, _ENV
      if window == nil then
        return 
      end
      ;
      (self.sectorCtrl):OnEnterPlotOrMateralDungeon()
      window:InitDungeonType(matDungeonTypeData, jumpTargetTypeId, function(tohome)
        -- function num : 0_5_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).MaterialDungeonId)
      end
      UIManager:HideWindow(UIWindowTypeID.Sector)
      local HomeEnum = require("Game.Home.HomeEnum")
      MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).ResDungeonRefresh)
    end
)
  end

  if not self.StartLoadMatDungeon then
    self.__loadMatDungeon = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.EnterATHDungeon = function(self, jumpTargetTypeId, isForce)
  -- function num : 0_6 , upvalues : DungeonTypeData, cs_MessageCommon, _ENV, SectorEnum, util
  if not isForce and self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  local ATHDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(DungeonTypeData.eDungeonType).ATHDungeon]
  if ATHDungeonTypeData == nil then
    (self.sectorCtrl):CheckAndSetDungeonUnlock()
    ATHDungeonTypeData = ((self.sectorCtrl).dungeonTypeDataDic)[(DungeonTypeData.eDungeonType).ATHDungeon]
  end
  if not ATHDungeonTypeData:GetDungeonTypeIsUnlock() then
    (cs_MessageCommon.ShowMessageTips)(ATHDungeonTypeData:GetDungeonTypeUnlockDes())
    return 
  end
  local loadFunc = function()
    -- function num : 0_6_0 , upvalues : self, _ENV, ATHDungeonTypeData, jumpTargetTypeId, SectorEnum
    self.StartLoadAthDungeon = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadAthDungeon = false
    UIManager:ShowWindowAsync(UIWindowTypeID.ATHDungeon, function(window)
      -- function num : 0_6_0_0 , upvalues : self, ATHDungeonTypeData, jumpTargetTypeId, SectorEnum, _ENV
      if window == nil then
        return 
      end
      ;
      (self.sectorCtrl):OnEnterPlotOrMateralDungeon()
      window:InitDungeonType(ATHDungeonTypeData, jumpTargetTypeId, function(tohome)
        -- function num : 0_6_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).ATHDungeonId)
      end
      UIManager:HideWindow(UIWindowTypeID.Sector)
      local HomeEnum = require("Game.Home.HomeEnum")
      MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).ATHDungeonRefresh)
    end
)
  end

  if not self.StartLoadAthDungeon then
    self.__loadAthDungeon = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.SetDailyChallengeInfo = function(self, coouldShow)
  -- function num : 0_7 , upvalues : UINChallengeInfoItem, PeridicChallengeEnum
  if coouldShow then
    self.dailyChallengeBtn = (UINChallengeInfoItem.New)()
    ;
    (self.dailyChallengeBtn):Init(((self.ui).btn_dailyChallengeButton).gameObject)
    ;
    (self.dailyChallengeBtn):InitChallengeInfoItem((PeridicChallengeEnum.eChallengeType).daliy)
  else
    ;
    (((self.ui).btn_dailyChallengeButton).gameObject):SetActive(false)
  end
  self:RefreshPeriodicRedDot()
end

UI3DSectorCanvas.OnClickDailyChallenge = function(self)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, SectorEnum, util
  if self.sectorCtrl ~= nil and (self.sectorCtrl):IsDisableClick() then
    return 
  end
  if (ControllerManager:GetController(ControllerTypeId.SectorController)):HasUnfinishEp() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_HasExpNotFinished))
    return 
  end
  local loadFunc = function()
    -- function num : 0_8_0 , upvalues : self, _ENV, SectorEnum
    self.StartLoadDailyChallenge = true
    while 1 do
      if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self.StartLoadDailyChallenge = false
    UIManager:ShowWindowAsync(UIWindowTypeID.DailyChallenge, function(window)
      -- function num : 0_8_0_0 , upvalues : self, SectorEnum, _ENV
      if self.localModelData ~= nil then
        (self.localModelData):RecordLastSectorSelected((SectorEnum.eSectorMentionId).DailyChallenge)
      end
      ;
      (self.sectorCtrl):OnEnterDailyChallenge()
      window:InitPeriodicChallenge(function(tohome)
        -- function num : 0_8_0_0_0 , upvalues : self
        (self.sectorCtrl):ResetToNormalState(tohome)
      end
)
      local HomeEnum = require("Game.Home.HomeEnum")
      MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).dailyChallenge)
    end
)
  end

  if not self.StartLoadDailyChallenge then
    self.__loadDailyChallenge = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
  end
end

UI3DSectorCanvas.InitSctUI3DCanvas = function(self)
  -- function num : 0_9
end

UI3DSectorCanvas.AddSctInfoItem = function(self, sectorId, clickFunc)
  -- function num : 0_10 , upvalues : _ENV
  local infoItem = (self.sctInfoPool):GetOne()
  infoItem:InitSctItemInfo(sectorId, clickFunc, self.resloader)
  infoItem:SetText2TextNode((self.ui).tran_infoTextParent)
  infoItem:SetTextEn2TextEnNode((self.ui).tran_infoTextEnParent)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (infoItem.gameObject).name = tostring(sectorId)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctInfoDic)[sectorId] = infoItem
  return infoItem
end

UI3DSectorCanvas.AddSctProgressStage = function(self, sectorId, clickFunc)
  -- function num : 0_11
  local item = (self.sctProgressPool):GetOne()
  item:InitSctProgress(sectorId, true, clickFunc)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctProgressStageDic)[sectorId] = item
  return item
end

UI3DSectorCanvas.AddSctProgressBuild = function(self, sectorId, clickFunc)
  -- function num : 0_12
  local item = (self.sctProgressPool):GetOne()
  item:InitSctProgress(sectorId, false, clickFunc)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.sctProgressBuildDic)[sectorId] = item
  return item
end

UI3DSectorCanvas.SetUISctSelect = function(self, position, size)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if self.ui ~= nil then
    ((self.ui).uI_STSelect).position = position
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).uI_STSelect).sizeDelta = size
  end
end

UI3DSectorCanvas.RefreshPeriodicRedDot = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local isFinish, num, max = (PlayerDataCenter.periodicChallengeData):GetDailyChallengeStage()
  if isFinish then
    ((self.ui).redDot_dailyChallenge):SetActive(false)
    if (self.ui).blueDot_dailyChallenge ~= nil then
      ((self.ui).blueDot_dailyChallenge):SetActive(false)
    end
  else
    if num < max then
      ((self.ui).redDot_dailyChallenge):SetActive(true)
      if (self.ui).blueDot_dailyChallenge ~= nil then
        ((self.ui).blueDot_dailyChallenge):SetActive(false)
      end
    else
      ;
      ((self.ui).redDot_dailyChallenge):SetActive(false)
      if (self.ui).blueDot_dailyChallenge == nil then
        local resLoader = ((CS.ResLoader).Create)()
        local gobj = resLoader:LoadABAsset(PathConsts:GetUIPrefabPath("BlueDot"))
        -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.ui).blueDot_dailyChallenge = gobj:Instantiate(((((self.ui).redDot_dailyChallenge).transform).parent).gameObject)
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (((self.ui).blueDot_dailyChallenge).transform).localPosition = Vector3(-374.2, 96.5, 0)
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (((self.ui).blueDot_dailyChallenge).transform).localScale = Vector3(1, 1, 1)
        local rectTr = ((self.ui).blueDot_dailyChallenge):GetComponent("RectTransform")
        local vec = rectTr.sizeDelta
        vec.x = 27
        vec.y = 27
        rectTr.sizeDelta = vec
        resLoader:Put2Pool()
      end
      do
        ;
        ((self.ui).blueDot_dailyChallenge):SetActive(true)
      end
    end
  end
end

UI3DSectorCanvas.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  RedDotController:RemoveListener(RedDotDynPath.PeriodicChallenge, self.__periodicChangeRedDot)
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  ;
  (self.sctInfoPool):DeleteAll()
  ;
  (self.sctProgressPool):DeleteAll()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.__loadFriendShipDungeon ~= nil and self.StartLoadFriendShipDungeon then
    (GR.StopCoroutine)(self.__loadFriendShipDungeon)
    self.StartLoadFriendShipDungeon = false
    self.__loadFriendShipDungeon = nil
  end
  if self.__loadMatDungeon ~= nil and self.StartLoadMatDungeon then
    (GR.StopCoroutine)(self.__loadMatDungeon)
    self.StartLoadMatDungeon = false
    self.__loadMatDungeon = nil
  end
  if self.__loadAthDungeon ~= nil and self.StartLoadAthDungeon then
    (GR.StopCoroutine)(self.__loadAthDungeon)
    self.StartLoadAthDungeon = false
    self.__loadAthDungeon = nil
  end
  if self.__loadDailyChallenge ~= nil and self.StartLoadDailyChallenge then
    (GR.StopCoroutine)(self.__loadDailyChallenge)
    self.StartLoadDailyChallenge = false
    self.__loadDailyChallenge = nil
  end
  if self.dailyChallengeBtn ~= nil then
    (self.dailyChallengeBtn):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UI3DSectorCanvas

