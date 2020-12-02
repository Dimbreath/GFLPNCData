-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthStrengthen = class("UIAthStrengthen", UIBaseWindow)
local base = UIBaseWindow
local UINAthOptimal = require("Game.Arithmetic.Strengthen.UINAthOptimal")
local UINAthSortList = require("Game.Arithmetic.AthSortList.UINAthSortList")
local UINAthStrItem = require("Game.Arithmetic.Strengthen.UINAthStrItem")
local UINAthOptAffixItem = require("Game.Arithmetic.Strengthen.UINAthOptAffixItem")
local UINAthDecompose = require("Game.Arithmetic.Strengthen.Decompose.UINAthDecompose")
local UINAthRefactor = require("Game.Arithmetic.Strengthen.Refactor.UINAthRefactor")
local cs_MessageCommon = CS.MessageCommon
local CS_Resloader = CS.ResLoader
local StrengthenQuality = eItemQualityType.Orange
UIAthStrengthen.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthSortList, CS_Resloader, UINAthStrItem, UINAthOptAffixItem, UINAthDecompose, UINAthRefactor, UINAthOptimal
  (UIUtil.AddValueChangedListener)((self.ui).tog_opt, self, self.OnClickOptimalNode)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_inherit, self, self.OnClickRefactor)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Dismantle, self, self.OnClickDeco)
  ;
  (UIUtil.AddButtonListener)((self.ui).lockOpt, self, self.OnClickLockOpt)
  ;
  (UIUtil.AddButtonListener)((self.ui).lockFefactor, self, self.OnClickLockRefactor)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickReturn)
  self.sortListNode = (UINAthSortList.New)()
  ;
  (self.sortListNode):Init((self.ui).aTHListNode)
  self.__OnClickAthItem = BindCallback(self, self.__OnClickBtnAthItem)
  self.__onAthDataUpdate = BindCallback(self, self.__OnAthDataUpdate)
  self.resLoader = (CS_Resloader.Create)()
  self.mainAthStrItem = (UINAthStrItem.New)()
  ;
  (self.mainAthStrItem):Init((self.ui).aTHItem)
  ;
  ((self.ui).affixItem):SetActive(false)
  self.affixItemPool = (UIItemPool.New)(UINAthOptAffixItem, (self.ui).affixItem)
  ;
  ((self.ui).decompose):SetActive(true)
  self.decoNode = (UINAthDecompose.New)()
  ;
  (self.decoNode):Init((self.ui).decompose)
  ;
  (self.decoNode):Hide()
  ;
  ((self.ui).refactorPage):SetActive(false)
  self.refactorNode = (UINAthRefactor.New)()
  ;
  (self.refactorNode):Init((self.ui).refactorPage)
  ;
  (self.refactorNode):Hide()
  self.optimalNode = (UINAthOptimal.New)((self.ui).affixList_togGroup)
  ;
  (self.optimalNode):Init((self.ui).optimizPage)
  self.toggleList = {
[(self.ui).tog_opt] = {icon = (((self.ui).tog_opt).transform):FindComponent("Img_Icon", eUnityComponentID.Image), name = (((self.ui).tog_opt).transform):FindComponent("Tex_Name", eUnityComponentID.Text)}
, 
[(self.ui).tog_inherit] = {icon = (((self.ui).tog_inherit).transform):FindComponent("Img_Icon", eUnityComponentID.Image), name = (((self.ui).tog_inherit).transform):FindComponent("Tex_Name", eUnityComponentID.Text)}
, 
[(self.ui).tog_Dismantle] = {icon = (((self.ui).tog_Dismantle).transform):FindComponent("Img_Icon", eUnityComponentID.Image), name = (((self.ui).tog_Dismantle).transform):FindComponent("Tex_Name", eUnityComponentID.Text)}
}
end

UIAthStrengthen.InitAthStrengthen = function(self, athData, heroData)
  -- function num : 0_1 , upvalues : _ENV
  self.athData = athData
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local unlockOpt = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_optimize)
  ;
  (((self.ui).lockOpt).gameObject):SetActive(not unlockOpt)
  local unlockRefact = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_reconsitution)
  ;
  (((self.ui).lockFefactor).gameObject):SetActive(not unlockRefact)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

  if unlockOpt then
    if (PlayerDataCenter.allAthData).athReconsitutionData ~= nil then
      if unlockRefact then
        ((self.ui).tog_inherit).isOn = true
      else
        if unlockOpt then
          self:ShowOptimal(athData)
        else
          -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

          ;
          ((self.ui).tog_Dismantle).isOn = true
        end
      end
    else
      self:ShowOptimal(athData)
    end
  else
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

    if unlockRefact then
      ((self.ui).tog_inherit).isOn = true
    else
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tog_Dismantle).isOn = true
    end
  end
  GuideManager:TryTriggerGuide(eGuideCondition.InATHStrengthen)
end

UIAthStrengthen.ShowOptimal = function(self, athData)
  -- function num : 0_2 , upvalues : StrengthenQuality
  (self.optimalNode):Show()
  ;
  (self.optimalNode):InitAthOptimal(athData, self.affixItemPool)
  ;
  (self.sortListNode):SetAthListOptSortFunc()
  ;
  (self.sortListNode):SetCustomSiftFunc(function(athData)
    -- function num : 0_2_0
    do return athData:GetAthSize() > 1 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.sortListNode):InitAthSortListNode(self.heroData, false, self.__OnClickAthItem, nil, StrengthenQuality)
  self:__SelectAth(athData)
  ;
  ((self.ui).tex_Title):SetIndex(0)
end

UIAthStrengthen.OnClickOptimalNode = function(self, isOn)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if isOn then
    if self.athData == nil then
      ((self.ui).tog_Dismantle).isOn = true
      ;
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4000))
      return 
    end
    self:ShowOptimal(self.athData)
  else
    ;
    (self.optimalNode):Hide()
  end
  if not isOn or not (Color.New)(0.113, 0.113, 0.113, 1) then
    local togColor = (Color.New)(0.647, 0.647, 0.647, 1)
  end
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.toggleList)[(self.ui).tog_opt]).icon).color = togColor
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.toggleList)[(self.ui).tog_opt]).name).color = togColor
end

UIAthStrengthen.OnClickRefactor = function(self, isOn)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if isOn then
    if self.athData == nil then
      ((self.ui).tog_Dismantle).isOn = true
      ;
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4000))
      return 
    end
    ;
    ((self.ui).tex_Title):SetIndex(1)
    ;
    (self.refactorNode):Show()
    ;
    (self.refactorNode):InitAthRefactor(self.sortListNode, self.athData, self.resLoader)
  else
    ;
    (self.refactorNode):Hide()
  end
  if not isOn or not (Color.New)(0.113, 0.113, 0.113, 1) then
    local togColor = (Color.New)(0.647, 0.647, 0.647, 1)
  end
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.toggleList)[(self.ui).tog_inherit]).icon).color = togColor
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.toggleList)[(self.ui).tog_inherit]).name).color = togColor
end

UIAthStrengthen.OnClickDeco = function(self, isOn)
  -- function num : 0_5 , upvalues : _ENV
  if isOn then
    ((self.ui).tex_Title):SetIndex(2)
    ;
    (self.decoNode):Show()
    ;
    (self.decoNode):InitAthDeco(self.sortListNode)
  else
    ;
    (self.decoNode):Hide()
  end
  if not isOn or not (Color.New)(0.113, 0.113, 0.113, 1) then
    local togColor = (Color.New)(0.647, 0.647, 0.647, 1)
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.toggleList)[(self.ui).tog_Dismantle]).icon).color = togColor
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.toggleList)[(self.ui).tog_Dismantle]).name).color = togColor
end

UIAthStrengthen.OnClickLockOpt = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  if not funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_optimize) then
    local msg = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_optimize)
    ;
    (cs_MessageCommon.ShowMessageTips)(msg)
  end
end

UIAthStrengthen.OnClickLockRefactor = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  if not funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_reconsitution) then
    local msg = funcUnLockCrtl:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_reconsitution)
    ;
    (cs_MessageCommon.ShowMessageTips)(msg)
  end
end

UIAthStrengthen.__OnClickBtnAthItem = function(self, athItem)
  -- function num : 0_8
  local athData = athItem:GetAthItemData()
  self:__SelectAth(athData, true)
end

UIAthStrengthen.__SelectAth = function(self, athData, useLastPos)
  -- function num : 0_9
  if (self.optimalNode).active then
    (self.mainAthStrItem):InitAthStrItem(athData, self.resLoader)
    self.athData = athData
    ;
    (self.optimalNode):InitAthOptimal(athData, self.affixItemPool)
  end
  local dic = {}
  dic[athData.uid] = true
  ;
  (self.sortListNode):SetAthListMultSeletedUidDic(dic)
  ;
  (self.sortListNode):RefillCurAthSortList(useLastPos)
end

UIAthStrengthen.OnClickReturn = function(self)
  -- function num : 0_10
  self:Delete()
end

UIAthStrengthen.__OnAthDataUpdate = function(self, updateAthDic, heroSlot, deleteAth)
  -- function num : 0_11
  if self.athData ~= nil and deleteAth[(self.athData).uid] ~= nil then
    self.athData = nil
  end
end

UIAthStrengthen.OnShow = function(self)
  -- function num : 0_12 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UIAthStrengthen.OnHide = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  ;
  (base.OnHide)(self)
end

UIAthStrengthen.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  (self.optimalNode):Delete()
  ;
  (self.decoNode):Delete()
  ;
  (self.refactorNode):Delete()
  ;
  (self.sortListNode):Delete()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (self.affixItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIAthStrengthen

