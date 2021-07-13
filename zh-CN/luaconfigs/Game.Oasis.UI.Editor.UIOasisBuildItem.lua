-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildItem = class("UIOasisBuildItem", UIBaseNode)
local base = UIBaseNode
local BuildingEnum = require("Game.Oasis.Data.BuildingEnum")
UIOasisBuildItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Preview, self, self._OnClickPreview)
end

UIOasisBuildItem.InitOasisBuildItem = function(self, buildTypeData, resLoader, newBuildingFunc, previewBuildFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.newBuildingFunc = newBuildingFunc
  self.previewBuildFunc = previewBuildFunc
  self.buildTypeData = buildTypeData
  local buildingData = buildTypeData:GetNextUnlockBuildData()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).name)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).intro)
  local path = PathConsts:GetOasisBuildingIconPath((buildingData.dynData).icon_res)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).enabled = false
  resLoader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_1_0 , upvalues : self
    if texture == nil then
      return 
    end
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).texture = texture
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = true
  end
)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(((buildingData.dynData).stcData).small_icon)
  self:RefreshUIOasisBuildData(buildingData)
end

UIOasisBuildItem.RefreshUIOasisBuildData = function(self, buildingData)
  -- function num : 0_2
  self.buildingData = buildingData
  self:RefreshUIOasisBuildItemState()
end

UIOasisBuildItem.RefreshUIOasisBuildItemState = function(self)
  -- function num : 0_3 , upvalues : _ENV, BuildingEnum
  local curNum, maxNum = (self.buildTypeData):GetBuildTypeNum()
  ;
  ((self.ui).tex_Count):SetIndex(0, tostring(curNum), tostring(maxNum))
  local buildingData = self.buildingData
  ;
  ((self.ui).isLock):SetActive(false)
  ;
  ((self.ui).tips):SetActive(false)
  ;
  ((self.ui).hasBuildCount):SetActive(true)
  local typeState = (self.buildTypeData):GetBuildTypeState()
  if typeState == (BuildingEnum.BuildingTypeState).Lock then
    ((self.ui).hasBuildCount):SetActive(false)
    ;
    ((self.ui).isLock):SetActive(true)
    ;
    ((self.ui).tips):SetActive(true)
    self:_RefreshUnlockTips(buildingData)
  else
    if typeState == (BuildingEnum.BuildingTypeState).MaxNum then
      ((self.ui).tips):SetActive(true)
      ;
      ((self.ui).tex_Tips):SetIndex(0)
    else
      if typeState == (BuildingEnum.BuildingTypeState).MoreNumLock then
        ((self.ui).tips):SetActive(true)
        self:_RefreshUnlockTips(buildingData)
      else
        if typeState == (BuildingEnum.BuildingTypeState).CanBuild and not (buildingData.dynData):CanBuild() then
          local levelCfg = ((buildingData.dynData).levelConfig)[1]
          if #levelCfg.consumeIds > 0 then
            error((string.format)("Building [%s] level 1 cost is not null", buildingData.id))
          end
        end
      end
    end
  end
end

UIOasisBuildItem._RefreshUnlockTips = function(self, buildingData)
  -- function num : 0_4 , upvalues : _ENV
  local lockMsg = nil
  local unlockTab = (buildingData.dynData):GetPreBuildingLvlInfo(1)
  for k,condition in ipairs(unlockTab) do
    if not condition.unlock then
      if (string.IsNullOrEmpty)(lockMsg) then
        lockMsg = condition.lockReason
      else
        lockMsg = lockMsg .. "\n" .. condition.lockReason
      end
    end
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).tex_Tips).text).text = lockMsg
end

UIOasisBuildItem._OnClickRoot = function(self)
  -- function num : 0_5 , upvalues : BuildingEnum
  if (self.buildTypeData):GetBuildTypeState() == (BuildingEnum.BuildingTypeState).CanBuild and self.newBuildingFunc ~= nil then
    (self.newBuildingFunc)(self)
  end
end

UIOasisBuildItem._OnClickPreview = function(self)
  -- function num : 0_6
  if self.previewBuildFunc ~= nil then
    (self.previewBuildFunc)(self.buildingData)
  end
end

UIOasisBuildItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIOasisBuildItem

