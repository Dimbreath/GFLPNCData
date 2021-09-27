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
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Jump, self, self._OnClickJump)
  self._defaltJumpBtnPos = (((self.ui).btn_Jump).transform).anchoredPosition
end

UINOasisBuildSelect.InitOasisBuildSelect = function(self, buildingData, buildingItem, dontShowBtn, isInfo)
  -- function num : 0_2 , upvalues : _ENV
  self.buildingData = buildingData
  self.buildingItem = buildingItem
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(((buildingData.dynData).stcData).small_icon)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).name)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_EnName).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).name_en)
  self:RefreshOasisSelectState()
  if dontShowBtn then
    (((self.ui).select).gameObject):SetActive(false)
    ;
    (((self.ui).editor).gameObject):SetActive(false)
  else
    ;
    (((self.ui).select).gameObject):SetActive(isInfo)
    ;
    (((self.ui).editor).gameObject):SetActive(not isInfo)
  end
  self:Show()
  self:RefreshOasisSelectPos()
  ;
  ((self.ui).showTween):DORestart()
end

UINOasisBuildSelect.SetOasisBuildSelectFunc = function(self, confirmFunc, cancelFunc)
  -- function num : 0_3
  self._confirmFunc = confirmFunc
  self._cancelFunc = cancelFunc
end

UINOasisBuildSelect.RefreshOasisSelectState = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local buildingData = self.buildingData
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = tostring(buildingData.level or 1)
  if buildingData.isBuild then
    local isMaxLv = buildingData:IsMaxLevel()
    ;
    (((self.ui).btn_LevelUp).gameObject):SetActive(not isMaxLv)
    local showJump = false
    if buildingData.id == eBuildingId.OasisFactory and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory) then
      showJump = true
    else
      if buildingData.id == eBuildingId.SkyBuilding then
        showJump = true
      end
    end
    ;
    (((self.ui).btn_Jump).gameObject):SetActive(showJump)
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

    if showJump then
      ((self.ui).layout_btn_Jump).ignoreLayout = not isMaxLv
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R4 in 'UnsetPending'

      if not isMaxLv then
        (((self.ui).btn_Jump).transform).anchoredPosition = self._defaltJumpBtnPos
      end
    end
  end
end

UINOasisBuildSelect.RefreshOasisSelectPos = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.active and not IsNull(self.buildingItem) then
    local anchorPos = UIManager:World2UIPosition((self.buildingItem):GetBuildSelectUIPos())
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.transform).anchoredPosition = anchorPos
  end
end

UINOasisBuildSelect._OnClickInfo = function(self)
  -- function num : 0_6
  ((self.oasisMain).buildDetailNode):InitOasisBuildDetail(self.buildingData, true)
end

UINOasisBuildSelect._OnClickLevelUp = function(self)
  -- function num : 0_7
  ((self.oasisMain).buildDetailNode):InitOasisBuildDetail(self.buildingData, false)
end

UINOasisBuildSelect._OnClickCancel = function(self)
  -- function num : 0_8
  if self._cancelFunc ~= nil then
    (self._cancelFunc)()
  end
end

UINOasisBuildSelect._OnClickJump = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (self.buildingData).id == eBuildingId.OasisFactory then
    (ControllerManager:GetController(ControllerTypeId.Factory, true)):OpenFactory()
  else
    if (self.buildingData).id == eBuildingId.SkyBuilding then
      ((self.oasisMain).oasisCtrl):EnterOasisSkyMode()
    end
  end
end

UINOasisBuildSelect._OnClickConfirm = function(self)
  -- function num : 0_10
  if self._confirmFunc ~= nil then
    (self._confirmFunc)()
  end
end

UINOasisBuildSelect.EnableBuildConfirmBtn = function(self, enable)
  -- function num : 0_11
  ;
  ((self.ui).img_Confirm):SetIndex(enable and 1 or 0)
end

UINOasisBuildSelect.OnHide = function(self)
  -- function num : 0_12
  self.buildingItem = nil
end

UINOasisBuildSelect.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (base.OnDelete)(self)
end

return UINOasisBuildSelect

