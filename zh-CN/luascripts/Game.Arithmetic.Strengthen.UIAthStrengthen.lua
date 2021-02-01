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
  (UIUtil.SetTopStatus)(self, self.OnClickReturn)
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
end

UIAthStrengthen.InitAthStrengthen = function(self, athData, heroData)
  -- function num : 0_1
  if athData ~= nil then
    self.athData = athData
  end
  ;
  (self.decoNode):Hide()
  ;
  (self.refactorNode):Hide()
  ;
  (self.optimalNode):Hide()
end

UIAthStrengthen._ShowOptimal = function(self, athData)
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
  ((self.ui).tex_Title):SetIndex(1)
  ;
  ((self.ui).tex_Name):SetIndex(1)
  ;
  ((self.ui).img_Icon):SetIndex(1)
end

UIAthStrengthen.ShowAthOptimal = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  if self.athData == nil then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4000))
    return 
  end
  self:_ShowOptimal(self.athData)
end

UIAthStrengthen.ShowAthRefactor = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  if self.athData == nil then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(4000))
    return 
  end
  ;
  ((self.ui).tex_Title):SetIndex(0)
  ;
  ((self.ui).tex_Name):SetIndex(0)
  ;
  ((self.ui).img_Icon):SetIndex(0)
  ;
  (self.decoNode):Hide()
  ;
  (self.refactorNode):Show()
  ;
  (self.refactorNode):InitAthRefactor(self.sortListNode, self.athData, self.resLoader)
  self._isRefactor = true
end

UIAthStrengthen.ShowAthDeco = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._isRefactor then
    (UIUtil.SetTopStatus)(self, self.ShowAthRefactor)
  end
  ;
  ((self.ui).tex_Title):SetIndex(2)
  ;
  ((self.ui).tex_Name):SetIndex(2)
  ;
  ((self.ui).img_Icon):SetIndex(2)
  ;
  (self.decoNode):Show()
  ;
  (self.decoNode):InitAthDeco(self.sortListNode)
end

UIAthStrengthen.OnClickLockOpt = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_optimize) then
    local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_optimize)
    ;
    (cs_MessageCommon.ShowMessageTips)(msg)
  end
end

UIAthStrengthen.OnClickLockRefactor = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_reconsitution) then
    local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_reconsitution)
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

