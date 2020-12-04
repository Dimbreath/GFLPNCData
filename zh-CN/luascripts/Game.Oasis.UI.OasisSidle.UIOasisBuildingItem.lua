-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingItem = class("UIOasisBuildingItem", UIBaseNode)
local base = UIBaseNode
local InfoItem = require("Game.Oasis.UI.OasisSidle.UIOasisBuffInfoItem")
local cs_MessageCommon = CS.MessageCommon
UIOasisBuildingItem.itemState = {disnormal = 1, normal = 2, constructing = 3, upgrading = 4}
local buffDispLimit = 2
UIOasisBuildingItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIOasisBuildingItem, InfoItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn, self, self.OnClickButton)
  self.state = (UIOasisBuildingItem.itemState).normal
  self.waitForConfirm = false
  self.alreadySendConfirm = false
  self.buffInfoPool = (UIItemPool.New)(InfoItem, (self.ui).obj_Buff)
end

UIOasisBuildingItem.InitItem = function(self, rowIns, buildingData, resLoader, OnClickEvent, sidle)
  -- function num : 0_1
  self.rowIns = rowIns
  self.resLoader = resLoader
  self.onClickEvent = OnClickEvent
  self.UISidle = sidle
  self:UpdateWithData(buildingData)
end

UIOasisBuildingItem.UpdateWithData = function(self, buildingData)
  -- function num : 0_2 , upvalues : _ENV
  self.buildingData = buildingData
  self.id = buildingData.id
  self.isBuild = buildingData.isBuild
  do
    if self.uiIcon == nil then
      local path = PathConsts:GetOasisBuildingIconPath(((self.buildingData).dynData).icon_res)
      ;
      (self.resLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_2_0 , upvalues : self
    self.uiIcon = texture
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    if self.ui ~= nil and (self.ui).img_Pic ~= nil then
      ((self.ui).img_Pic).texture = self.uiIcon
    end
  end
)
    end
    self:UpdateUI()
  end
end

UIOasisBuildingItem.OnClickButton = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon
  if (self.UISidle).openedDetail then
    return 
  end
  do
    if self.locked and ((self.buildingData).dynData).lockReason ~= nil then
      local msg = ((self.buildingData).dynData).lockReason
      ;
      (cs_MessageCommon.ShowMessageTips)(msg)
      return 
    end
    if self.onClickEvent ~= nil then
      (self.onClickEvent)()
    end
  end
end

UIOasisBuildingItem.Update = function(self, timestamp, isSecond)
  -- function num : 0_4
  if self.__forceUpdateProcess then
    self.__forceUpdateProcess = false
    self:__ForceUpdateProcess(timestamp)
  end
end

UIOasisBuildingItem.__ForceUpdateProcess = function(self, timestamp)
  -- function num : 0_5 , upvalues : _ENV
  local progress, remainSecond = (self.buildingData):GetProcess(timestamp)
  local remainTimeText = TimestampToTime(remainSecond)
  self:UpdateProcess(progress, remainTimeText)
end

UIOasisBuildingItem.UpdateUI = function(self)
  -- function num : 0_6 , upvalues : UIOasisBuildingItem, _ENV
  ((self.buildingData).dynData):UpdateLockAndBuild()
  ;
  (self.buildingData):CanUpgrade()
  local isWorking = false
  local isCompleted = false
  self.locked = false
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).texture = self.uiIcon
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).name_text).text = (self.buildingData).name
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_EnName).text = (self.buildingData).nameEn
  ;
  ((self.ui).upgradeTag):SetActive(false)
  ;
  ((self.ui).bgTip):SetActive(false)
  ;
  (((self.ui).unbuiltText).gameObject):SetActive(false)
  if not self.isBuild then
    (((self.ui).unbuiltText).gameObject):SetActive(true)
    self.isShowLevel = false
    if ((self.buildingData).dynData).unlock then
      ((self.ui).unbuilt):SetActive(true)
      ;
      ((self.ui).img_Lock):SetActive(false)
      if ((self.buildingData).dynData).canbuild then
        ((self.ui).bgTip):SetActive(true)
        ;
        ((self.ui).unbuiltText):SetIndex(1)
      else
        ;
        ((self.ui).bgTip):SetActive(false)
        ;
        ((self.ui).unbuiltText):SetIndex(0)
      end
      self.state = (UIOasisBuildingItem.itemState).normal
    else
      ;
      ((self.ui).img_Lock):SetActive(true)
      -- DECOMPILER ERROR at PC105: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).tex_Condition).text = ((self.buildingData).dynData).lockReason
      self.locked = true
      self.state = (UIOasisBuildingItem.itemState).disnormal
    end
  else
    ;
    ((self.ui).unbuilt):SetActive(false)
    ;
    ((self.ui).img_Lock):SetActive(false)
    self.isShowLevel = true
    ;
    ((self.ui).tex_BulidLevel):SetIndex(0, tostring((self.buildingData).level))
    if (self.buildingData).state == proto_object_BuildingState.BuildingStateNormal then
      self.state = (UIOasisBuildingItem.itemState).normal
      if (self.buildingData):CanUpgrade() then
        ((self.ui).upgradeTag):SetActive(true)
      end
    else
      if (self.buildingData).waitConfirmOver then
        self.state = (UIOasisBuildingItem.itemState).normal
        isCompleted = true
        isWorking = true
        self.waitForConfirm = true
      else
        if (self.buildingData).state == proto_object_BuildingState.BuildingStateCreate then
          isWorking = true
          self.state = (UIOasisBuildingItem.itemState).constructing
        else
          if (self.buildingData).state == proto_object_BuildingState.BuildingStateUpgrade then
            isWorking = true
            self.state = (UIOasisBuildingItem.itemState).upgrading
          end
        end
      end
    end
  end
  ;
  ((self.ui).timerItem):SetActive(isWorking)
  ;
  ((self.ui).stateUnfinished):SetActive(isWorking)
  ;
  (((self.ui).fillImage).gameObject):SetActive(isWorking)
  ;
  (((self.ui).tex_RemainTime).gameObject):SetActive(isWorking)
  if isWorking then
    ((self.ui).unfinished):SetActive(not isCompleted)
    ;
    ((self.ui).completed):SetActive(isCompleted)
    ;
    ((self.ui).stateCompleted):SetActive(isCompleted)
    ;
    (((self.ui).tex_BulidLevel).gameObject):SetActive(self.isShowLevel)
    if isWorking then
      self.__forceUpdateProcess = true
    end
    self:UpdateBuffs()
  end
end

UIOasisBuildingItem.ResetConfirmState = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self.waitForConfirm = false
  self.alreadySendConfirm = false
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).fillImage).fillAmount = 1
  self.currentProgress = 1
  self.currentRemainSecond = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_RemainTime).text = TimestampToTime(self.currentRemainSecond)
  self:UpdateUI()
end

UIOasisBuildingItem.UpdateBuffs = function(self)
  -- function num : 0_8
  if self.buffInfoPool == nil then
    return 
  end
  ;
  (self.buffInfoPool):HideAll()
  self:UpdateLogicItems(self.buffInfoPool)
end

UIOasisBuildingItem.UpdateLogicItems = function(self, itemPool)
  -- function num : 0_9 , upvalues : _ENV, buffDispLimit
  self.buffDict = (self.buildingData):GetNextLevelBuffItem()
  do
    if self.buffDict ~= nil then
      local buffIndex = 1
      for k,v in pairs(self.buffDict) do
        do
          do
            if v ~= nil then
              local item = itemPool:GetOne()
              item:SetInfoItemText(v.currentInfo)
            end
            buffIndex = buffIndex + 1
            -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
    if buffDispLimit >= buffIndex then
    end
  end
end

UIOasisBuildingItem.UpdateProcess = function(self, progress, remainTimeText, waitConfirmOver, second)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R5 in 'UnsetPending'

  if waitConfirmOver then
    ((self.ui).fillImage).fillAmount = 1
    self.currentProgress = 1
    self.currentRemainSecond = 0
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_RemainTime).text = TimestampToTime(self.currentRemainSecond)
    self:UpdateUI()
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).fillImage).fillAmount = progress
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_RemainTime).text = remainTimeText
  self.currentRemainSecond = second
  self.currentProgress = progress
end

UIOasisBuildingItem.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnDelete)(self)
end

return UIOasisBuildingItem

