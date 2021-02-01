-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonBase = class("UIDungeonBase", UIBaseWindow)
local base = UIBaseWindow
local UIDungeonChapterList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")
UIDungeonBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV
  self.resLoader = (cs_ResLoader.Create)()
  self.battleDungeonNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  ;
  (UIUtil.SetTopStatus)(self, self.OnBack, table.emptytable)
  self.__onBattleStart = BindCallback(self, self.OnBattleStart)
  self.__onItemClick = BindCallback(self, self.OnSelectItemEvent)
  self.__onDailyLimitUpdate = BindCallback(self, self.OnDailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  self.dungeonItemDic = {}
  self.selectDungeonData = nil
  self.selectDungeonItem = nil
  self.dungeonTypeUIEnum = nil
end

UIDungeonBase.InitDungeonType = function(self, dungeonTypeData, selectdungeonId, onBackCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.dungeonTypeData = dungeonTypeData
  self.dungeonDataList = dungeonTypeData:GetDungeonDataList()
  if onBackCallback ~= nil then
    self.onBackCallback = onBackCallback
  end
  self:InitDungeonList()
  if selectdungeonId == nil then
    for _,dungeonData in ipairs(self.dungeonDataList) do
      if dungeonData:GetIsUnlock() then
        self.selectDungeonData = dungeonData
        break
      end
    end
  else
    do
      for _,dungeonData in ipairs(self.dungeonDataList) do
        if dungeonData:GetIsUnlock() and dungeonData:GetDungeonId() == selectdungeonId then
          self.selectDungeonData = dungeonData
          break
        end
      end
      do
        self.selectDungeonItem = (self.dungeonItemDic)[self.selectDungeonData]
        self:ShowDungeonDetail(self.selectDungeonItem)
      end
    end
  end
end

UIDungeonBase.OnDailyLimitUpdate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for dungeonData,dungeonItem in pairs(self.dungeonItemDic) do
    if dungeonItem ~= nil then
      dungeonData:CleanCacheData()
      dungeonItem:UpdateDailyLimit()
    end
  end
  self:ShowDungeonDetail(self.selectDungeonItem)
  ;
  (self.chaptersUI):UpdateIsDouble()
end

UIDungeonBase.InitDungeonList = function(self, UIDungeonItemClass)
  -- function num : 0_3 , upvalues : _ENV
  self.dungeonItemPool = (UIItemPool.New)(UIDungeonItemClass, (self.ui).tog_DungeonItem)
  ;
  ((self.ui).tog_DungeonItem):SetActive(false)
  for _,dungeonData in ipairs(self.dungeonDataList) do
    if dungeonData ~= nil then
      local item = (self.dungeonItemPool):GetOne()
      item:InitDungeonItem(dungeonData, self.resLoader, self.__onItemClick)
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.dungeonItemDic)[dungeonData] = item
    end
  end
end

UIDungeonBase.OnSelectItemEvent = function(self, item)
  -- function num : 0_4
  (self.selectDungeonItem):OnSelectDisplay(false)
  self.selectDungeonData = item.dungeonData
  self.selectDungeonItem = (self.dungeonItemDic)[self.selectDungeonData]
  self:ShowDungeonDetail(item)
end

UIDungeonBase.ShowDungeonDetail = function(self, item)
  -- function num : 0_5
  self:InitDungeonStages(item.dungeonData)
  item:OnSelectDisplay(true)
end

UIDungeonBase.InitDungeonStages = function(self, dungeonData, UIDungeonStageClass)
  -- function num : 0_6 , upvalues : _ENV, UIDungeonChapterList, UINBaseItem
  local resource_top = {}
  for k,v in pairs((dungeonData:GetDungeonCfg()).resource_top) do
    resource_top[k] = v
  end
  ;
  (table.insert)(resource_top, ConstGlobalItem.SKey)
  ;
  (UIUtil.RefreshTopResId)(resource_top)
  if self.chaptersUI == nil then
    self.chaptersUI = (UIDungeonChapterList.New)()
    ;
    (self.chaptersUI):Init((self.ui).levelRewardNode)
  end
  if self.dungeonStageItemPool == nil or self.fstRewardItemPool == nil or self.mbRewardItemPool == nil then
    self.dungeonStageItemPool = (self.chaptersUI):CreatePool(UIDungeonStageClass, UINBaseItem, UINBaseItem)
  end
  ;
  (self.dungeonStageItemPool):HideAll()
  ;
  (self.fstRewardItemPool):HideAll()
  ;
  (self.mbRewardItemPool):HideAll()
  for index,dungeonStageData in ipairs(dungeonData:GetDungeonStageList()) do
    local item = (self.dungeonStageItemPool):GetOne()
    item:InitWithStageData(dungeonStageData, index, self.fstRewardItemPool, self.mbRewardItemPool)
  end
  self:RegularDungeonStageSpace(#(self.dungeonStageItemPool).listItem)
  ;
  (self.chaptersUI):UpdateWithChapterList((self.dungeonStageItemPool).listItem, dungeonData, self.__onBattleStart)
end

local spacingDic = {[6] = 84.5, [8] = 15.5}
UIDungeonBase.RegularDungeonStageSpace = function(self, num)
  -- function num : 0_7 , upvalues : spacingDic
  local space = spacingDic[num]
  if space == nil then
    local a = spacingDic[8] - spacingDic[6] / 2
    local b = spacingDic[6] - a * 6
    space = a * num + b
  end
  do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.chaptersUI).ui).layout_Level).spacing = space
  end
end

UIDungeonBase.OnBattleStart = function(self, ATHRewardInfo)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, JumpManager, util, CS_GSceneManager_Ins
  self.dungeonStageItem = (self.chaptersUI).selectChapterItem
  local dungeonData = self.selectDungeonData
  local dungeonStageData = (self.dungeonStageItem).dungeonStageData
  if dungeonStageData:IsHaveATHReward() and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return 
  end
  if dungeonData:GetDungeonPlayLeftLimitNum() == 0 then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  if dungeonStageData:GetIsReach2Limit() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  if (PlayerDataCenter.stamina):GetCurrentStamina() < dungeonStageData:GetStaminaCost() then
    JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
    return 
  end
  for id,count in pairs(dungeonStageData:GetNormalCostItemDic()) do
    if count ~= nil and count > 0 then
      local itemNum = PlayerDataCenter:GetItemCount(id)
      if itemNum < count then
        (cs_MessageCommon.ShowMessageTips)("消耗道具数量不足")
        return 
      end
    end
  end
  local enterFormationFunc = function()
    -- function num : 0_8_0 , upvalues : _ENV, self
    (ControllerManager:GetController(ControllerTypeId.SectorController)):EnbleSectorUI3D(false)
    UIManager:HideWindow(self.dungeonTypeUIEnum)
    UIManager:HideWindow(UIWindowTypeID.Sector)
  end

  local exitFormationFunc = function()
    -- function num : 0_8_1 , upvalues : _ENV, self
    (ControllerManager:GetController(ControllerTypeId.SectorController)):EnbleSectorUI3D(true)
    UIManager:ShowWindowOnly(self.dungeonTypeUIEnum)
    UIManager:ShowWindowOnly(UIWindowTypeID.Sector)
  end

  local startBattleFunc = nil
  startBattleFunc = function(curSelectFormationId, callBack)
    -- function num : 0_8_2 , upvalues : _ENV, dungeonStageData, JumpManager, ATHRewardInfo, dungeonData, self, startBattleFunc, util, CS_GSceneManager_Ins
    if (PlayerDataCenter.stamina):GetCurrentStamina() < dungeonStageData:GetStaminaCost() then
      JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
      return 
    end
    local formationData = (PlayerDataCenter.formationDic)[curSelectFormationId]
    if formationData == nil then
      return 
    end
    BattleDungeonManager:SaveFormation(formationData)
    BattleDungeonManager:SaveBattleWinRewardInfo(ATHRewardInfo, dungeonData:GetIsDungeonDouble())
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    saveUserData:SetLastFormationId(dungeonData:GetDungeonId(), curSelectFormationId)
    saveUserData:SetLastDungeonStageId(dungeonData:GetDungeonId(), dungeonStageData:GetDungeonStageId())
    local afterBattleWinEvent = BindCallback(self, self.AfterBattleWin, self.dungeonStageItem, self.selectDungeonItem)
    BattleDungeonManager:InjectBattleWinEvent(afterBattleWinEvent)
    BattleDungeonManager:SetBattleRestartDatas(startBattleFunc, dungeonStageData)
    BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, function()
      -- function num : 0_8_2_0 , upvalues : _ENV, self, dungeonData, util, CS_GSceneManager_Ins
      local loadMatUIFunc = BindCallback(self, function()
        -- function num : 0_8_2_0_0 , upvalues : _ENV, self, dungeonData, util
        local loadFunc = function()
          -- function num : 0_8_2_0_0_0 , upvalues : _ENV, self, dungeonData
          (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
          self.StartLoadDungeon = true
          while 1 do
            if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
              (coroutine.yield)(nil)
              -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
          UIManager:ShowWindowAsync(self.dungeonTypeUIEnum, function(window)
            -- function num : 0_8_2_0_0_0_0 , upvalues : self, dungeonData, _ENV
            if window == nil then
              return 
            end
            window:InitDungeonType(self.dungeonTypeData, dungeonData:GetDungeonId(), function(tohome)
              -- function num : 0_8_2_0_0_0_0_0 , upvalues : _ENV
              local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
              sectorCtrl:ResetToNormalState(tohome)
            end
)
            UIManager:HideWindow(UIWindowTypeID.ClickContinue)
          end
)
          self.StartLoadDungeon = false
        end

        if not self.StartLoadDungeon then
          self.__loadDungeonCoroutine = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
        end
      end
)
      CS_GSceneManager_Ins:LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
        -- function num : 0_8_2_0_1 , upvalues : _ENV, loadMatUIFunc
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
        local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
        sectorCtrl:SetFrom(AreaConst.DungeonBattle, loadMatUIFunc)
        sectorCtrl:OnEnterPlotOrMateralDungeon()
      end
)
    end
, self.selectItemId))
    ;
    (self.battleDungeonNetworkCtrl):CS_BATTLE_DungeonEnter(((self.dungeonStageItem).cfg).id, formationData, function()
      -- function num : 0_8_2_1 , upvalues : _ENV, callBack
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      UIManager:DeleteAllWindow()
      if callBack ~= nil then
        callBack()
      end
    end
)
  end

  self:EnterFormation(dungeonData, enterFormationFunc, exitFormationFunc, startBattleFunc)
end

UIDungeonBase.EnterFormation = function(self, dungeonData, enterFormationFunc, exitFormationFunc, startBattleFunc)
  -- function num : 0_9 , upvalues : _ENV, eFmtFromModule
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local lastFmtId = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastFormationId(dungeonData:GetDungeonId())
  fmtCtrl:InitFromationCtrl(eFmtFromModule.MaterialDungeon, ((self.dungeonStageItem).cfg).id, enterFormationFunc, exitFormationFunc, startBattleFunc, (self.dungeonStageItem).costStrengthNum, lastFmtId)
end

UIDungeonBase.AfterBattleWin = function(self, dungeonStageItem, selectDungeonItem)
  -- function num : 0_10 , upvalues : _ENV
  PlayerDataCenter:LocallyAddDungeonLimit((selectDungeonItem.dungeonData):GetDungeonId(), dungeonStageItem.chapterId)
  ;
  (self.dungeonTypeData):UpdateDungeonAndStageUnlock()
end

UIDungeonBase.OnTopInfoClick = function(self)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonDropInfo, function(window)
    -- function num : 0_11_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitDungeonDropInfo((self.dungeonTypeData):GetDungeonType())
  end
)
end

UIDungeonBase.OnBack = function(self, toHome)
  -- function num : 0_12 , upvalues : base
  if self.onBackCallback ~= nil then
    (self.onBackCallback)(toHome)
  end
  ;
  (base.Delete)(self)
end

UIDungeonBase.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  if self.__loadDungeonCoroutine ~= nil and self.StartLoadDungeon then
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    ;
    (GR.StopCoroutine)(self.__loadDungeonCoroutine)
    self.StartLoadDungeon = false
    self.__loadDungeonCoroutine = nil
  end
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
  end
  ;
  (base.OnDelete)(self)
end

return UIDungeonBase

