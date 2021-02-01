-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOasisBuildSelect = class("UINOasisBuildSelect", UIBaseNode)
local base = UIBaseNode
UINOasisBuildSelect.ctor = function(self, oasisMain)
  -- function num : 0_0
  self.oasisMain = oasisMain
end

UINOasisBuildSelect.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Information, self, self._OnClickInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LevelUp, self, self._OnClickLevelUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self._OnClickCancel)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
end

UINOasisBuildSelect.InitOasisBuildSelect = function(self, buildingData, buildingItem, oasisCtrl)
  -- function num : 0_2 , upvalues : _ENV
  self.oasisCtrl = oasisCtrl
  self.buildingData = buildingData
  self.buildingItem = buildingItem
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(((buildingData.dynData).stcData).small_icon)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).name)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_EnName).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).name_en)
  self:RefreshOasisSelectState()
  ;
  (((self.ui).select).gameObject):SetActive(buildingData.isBuild)
  ;
  (((self.ui).editor).gameObject):SetActive(not buildingData.isBuild)
  self:Show()
  ;
  ((self.ui).showTween):DORestart()
end

UINOasisBuildSelect.RefreshOasisSelectState = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local buildingData = self.buildingData
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = tostring(buildingData.level or 1)
  if buildingData.isBuild then
    (((self.ui).btn_LevelUp).gameObject):SetActive(not buildingData:IsMaxLevel())
  end
end

UINOasisBuildSelect.RefreshOasisSelectPos = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.active and not IsNull(self.buildingItem) and not (self.buildingItem):BuildGoIsInLoading() then
    local anchorPos = UIManager:World2UIPosition((self.buildingItem):GetBuildSelectUIPos())
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.transform).anchoredPosition = anchorPos
  end
end

UINOasisBuildSelect._OnClickInfo = function(self)
  -- function num : 0_5
  ((self.oasisMain).buildDetailNode):InitOasisBuildDetail(self.buildingData, true)
end

UINOasisBuildSelect._OnClickLevelUp = function(self)
  -- function num : 0_6
  ((self.oasisMain).buildDetailNode):InitOasisBuildDetail(self.buildingData, false)
end

UINOasisBuildSelect._OnClickCancel = function(self)
  -- function num : 0_7
  (self.oasisCtrl):CancelNewBuilding()
end

UINOasisBuildSelect._OnClickConfirm = function(self)
  -- function num : 0_8
  (self.oasisCtrl):StartConstruct()
  self:Hide()
end

UINOasisBuildSelect.EnableBuildConfirmBtn = function(self, enable)
  -- function num : 0_9
  ;
  ((self.ui).img_Confirm):SetIndex(enable and 1 or 0)
end

UINOasisBuildSelect.OnHide = function(self)
  -- function num : 0_10
  self.buildingItem = nil
end

UINOasisBuildSelect.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnDelete)(self)
end

return UINOasisBuildSelect

