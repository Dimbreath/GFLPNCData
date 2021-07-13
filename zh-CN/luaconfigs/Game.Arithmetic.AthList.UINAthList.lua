-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthList = class("UINAthList", UIBaseNode)
local base = UIBaseNode
local UINAthListArea = require("Game.Arithmetic.AthList.Area.UINAthListArea")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
local UINAthListSort = require("Game.Arithmetic.AthList.Sort.UINAthListSort")
local UINAthListToggle = require("Game.Arithmetic.AthList.UINAthListToggle")
local UINAthListSuit = require("Game.Arithmetic.AthList.Suit.UINAthListSuit")
local UINAthListAreaTog = require("Game.Arithmetic.AthList.Area.UINAthListAreaTog")
local CS_DoTween = ((CS.DG).Tweening).DOTween
local CS_ResLoader = CS.ResLoader
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
UINAthList.ctor = function(self, isConsumeAth)
  -- function num : 0_0
  self.isConsumeAth = isConsumeAth
end

UINAthList.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINAthListArea, UINAthListSort, UINAthListSuit, UINAthListToggle, UINAthListAreaTog
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClickSort)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Decompose, self, self._OnClickDecompose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Dteail, self, self._OnClickDetail)
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  self.__OnAthItemDetailShow = BindCallback(self, self._OnAthItemDetailShow)
  self.athListArea = (UINAthListArea.New)()
  ;
  (self.athListArea):Init((self.ui).areaNode)
  self.athListSortNode = (UINAthListSort.New)()
  ;
  (self.athListSortNode):Init((self.ui).sortDropdown)
  ;
  (self.athListSortNode):InitAthListSort(self, self.isConsumeAth)
  ;
  (self.athListSortNode):Hide()
  self.athListSuit = (UINAthListSuit.New)()
  ;
  (self.athListSuit):Init((self.ui).suitNode)
  ;
  (self.athListSuit):Hide()
  self.togArea = (UINAthListToggle.New)()
  ;
  (self.togArea):Init((self.ui).tog_Area)
  ;
  (self.togArea):InitAthListToggle(BindCallback(self, self._OnSelectAreaTog))
  self.togSuit = (UINAthListToggle.New)()
  ;
  (self.togSuit):Init((self.ui).tog_Suit)
  ;
  (self.togSuit):InitAthListToggle(BindCallback(self, self._OnSelectSuitTog))
  self.__onAthListAreaSelect = BindCallback(self, self.__OnAreaSelect)
  ;
  ((self.ui).tog_AreaItem):SetActive(false)
  self.areaTogList = (UIItemPool.New)(UINAthListAreaTog, (self.ui).tog_AreaItem)
  for i = 0, (ConfigData.game_config).athSlotCount do
    local togItem = (self.areaTogList):GetOne()
    togItem:InitAthListAreaTog(R8_PC135, self.__onAthListAreaSelect)
  end
  local fecomposeUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Decompose)
  self:ShowAthListDecomposeBtn(fecomposeUnlock)
end

UINAthList.InitAthListNode = function(self, heroData, resLoader, withMat, clickItemFunc, areaId, quality, changeAreaFunc, ignoreInstalled, withSuitNode)
  -- function num : 0_2 , upvalues : _ENV
  self.heroData = heroData
  self.clickItemFunc = clickItemFunc
  self.resLoader = resLoader
  self.changeAreaFunc = changeAreaFunc
  if withSuitNode then
    (self.togSuit):Show()
  else
    ;
    (self.togSuit):Hide()
  end
  self:SetAthListArea(areaId)
  if self.suitNodeIsShow then
    self:_ShowAreaTog(areaId)
    return 
  end
  ;
  ((self.ui).img_Select):SetIndex((PlayerDataCenter.allAthData):IsAthItemAttrShow() and 1 or 0)
  self.withMat = withMat
  ;
  ((self.athListArea).athScrollList):SetAthScrollListSortFunc(self._sortFunc)
  ;
  (self.athListArea):InitAthListArea(heroData, areaId, quality, self.__OnClickAthItem, self.__itemStartDragFunc, resLoader, withMat, changeAreaFunc, ignoreInstalled)
  self:_ShowAreaTog(areaId)
end

UINAthList.SetAthListArea = function(self, areaId)
  -- function num : 0_3
  self.areaId = areaId
end

UINAthList._ShowAreaTog = function(self, areaId)
  -- function num : 0_4
  local selecteTogItem = ((self.areaTogList).listItem)[(areaId or 0) + 1]
  ;
  ((self.ui).areaTogGroup):SetAllTogglesOff()
  selecteTogItem:SetAthListAreaTogIsOn()
end

UINAthList.ShowAthListDecomposeBtn = function(self, show)
  -- function num : 0_5
  (((self.ui).btn_Decompose).gameObject):SetActive(show)
end

UINAthList.SetAthItemStartDragFunc = function(self, itemStartDragFunc)
  -- function num : 0_6
  self.__itemStartDragFunc = itemStartDragFunc
end

UINAthList.OnAthDataUpdate = function(self)
  -- function num : 0_7
  if not self.active then
    return 
  end
  if (self.athListArea).active then
    ((self.athListArea).athScrollList):RefreshAthScrollListData()
    self:RefillCurAthSortList(true)
  end
  if (self.athListSuit).active then
    (self.athListSuit):RefreshAthListSuit()
  end
end

UINAthList.RefillCurAthSortList = function(self, useLastPos)
  -- function num : 0_8
  ((self.athListArea).athScrollList):RefillAthScrollList(self.__SiftFunction, self._sortFunc, useLastPos)
end

UINAthList.OnClickAthItem = function(self, athItem)
  -- function num : 0_9
  if self.clickItemFunc ~= nil then
    (self.clickItemFunc)(athItem)
  end
end

UINAthList.GetAthItemGo = function(self, space)
  -- function num : 0_10 , upvalues : spaceIdDic, _ENV
  local index = spaceIdDic[space]
  if index == nil then
    error("Can\'t get athItemGo, space = " .. tostring(space))
    return 
  end
  return ((((self.athListArea).athScrollList).ui).athSpaceItemList)[index]
end

UINAthList._OnClickDecompose = function(self)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthDecompose, function(window)
    -- function num : 0_11_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    self:Hide()
    window:InitAthDecompose(self.resLoader, function()
      -- function num : 0_11_0_0 , upvalues : self, _ENV
      self:Show()
      self:OnAthDataUpdate()
      ;
      ((self.ui).img_Select):SetIndex((PlayerDataCenter.allAthData):IsAthItemAttrShow() and 1 or 0)
    end
)
  end
)
end

UINAthList.OnClickSort = function(self)
  -- function num : 0_12 , upvalues : _ENV
  AudioManager:PlayAudioById(1069)
  ;
  (self.athListSortNode):ShowAthListSort()
end

UINAthList.DragInAthSortList = function(self, worldPos)
  -- function num : 0_13 , upvalues : _ENV
  local anchordPos = UIManager:World2UIPosition(worldPos, self.transform, nil, UIManager.UICamera)
  if anchordPos.x <= ((self.transform).rect).xMax then
    return true
  end
  return false
end

UINAthList.OnShow = function(self)
  -- function num : 0_14 , upvalues : _ENV
  self:SetAthSortListTween()
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthItemDetailShow, self.__OnAthItemDetailShow)
end

UINAthList.OnHide = function(self)
  -- function num : 0_15 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnAthItemDetailShow, self.__OnAthItemDetailShow)
end

UINAthList.SetAthSortListTween = function(self)
  -- function num : 0_16 , upvalues : _ENV, CS_DoTween
  local moveX = 100
  local pageLocalPos = (self.transform).localPosition
  pageLocalPos = (Vector3.New)(pageLocalPos.x - moveX, pageLocalPos.y, pageLocalPos.z)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localPosition = pageLocalPos
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).fade).alpha = 0.4
  if self.sequence == nil then
    local sequence = (CS_DoTween.Sequence)()
    sequence:Append(((self.transform):DOLocalMoveX(moveX, 0.3)):SetRelative(true))
    sequence:Join(((self.ui).fade):DOFade(1, 0.3))
    sequence:SetAutoKill(false)
    self.sequence = sequence
  else
    do
      ;
      (self.sequence):Restart()
    end
  end
end

UINAthList.GetAthItemFromList = function(self, uid)
  -- function num : 0_17
  return ((self.athListArea).athScrollList):GetAthItemFromListAll(uid)
end

UINAthList.ChangeAthListSort = function(self, kindType, kindValue, name, isInit)
  -- function num : 0_18 , upvalues : AthSortEnum
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).tex_Sort).text = name
  self._sortFunc = (AthSortEnum.GetSortFunc)(kindType, kindValue, self.isConsumeAth)
  if not isInit then
    self:RefillCurAthSortList()
  end
end

UINAthList._OnSelectAreaTog = function(self, isOn)
  -- function num : 0_19
  (((self.ui).btn_Sort).gameObject):SetActive(isOn)
  if isOn then
    if self.showSuitAth then
      self:_Return2SuitNode(true, true)
    end
    ;
    (self.athListArea):Show()
    self:_ShowAreaTog(self.areaId)
  else
    ;
    (self.athListArea):Hide()
  end
end

UINAthList._OnSelectSuitTog = function(self, isOn)
  -- function num : 0_20
  self.suitNodeIsShow = isOn
  if isOn then
    if self.showSuitAth then
      self:_Return2SuitNode(true)
      return 
    end
    ;
    (self.athListSuit):Show()
    ;
    (self.athListSuit):InitAthListSuit(self, self.resLoader)
    self:_ShowAreaTog(self.areaId)
  else
    ;
    (self.athListSuit):Hide()
  end
end

UINAthList.ShowAthListSuitAth = function(self, suitId)
  -- function num : 0_21 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self._Return2SuitNode)
  ;
  (self.athListSuit):Hide()
  ;
  (self.athListArea):Show()
  self:ShowAthListAreaTogs(false)
  ;
  (self.athListArea):ShowAthListAreaSuitPartTog(true, suitId)
  self.showSuitAth = true
end

UINAthList._Return2SuitNode = function(self, popFunc, withoutSuit)
  -- function num : 0_22 , upvalues : _ENV
  if popFunc then
    (UIUtil.PopFromBackStack)()
  end
  if not withoutSuit then
    (self.athListSuit):Show()
    ;
    (self.athListSuit):RefreshAthListSuit()
  end
  ;
  (self.athListArea):Hide()
  ;
  ((self.athListArea).athScrollList):SetAthScrollListSuitId(nil)
  self:ShowAthListAreaTogs(true)
  ;
  (self.athListArea):ShowAthListAreaSuitPartTog(false)
  self.showSuitAth = false
end

UINAthList.__OnAreaSelect = function(self, areaId)
  -- function num : 0_23
  if areaId == 0 then
    areaId = nil
  end
  self:ChangeAthListArea(areaId)
  if self.changeAreaFunc ~= nil then
    (self.changeAreaFunc)(areaId)
  end
end

UINAthList.ShowAthListAreaTogs = function(self, show)
  -- function num : 0_24
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).cg_areaTogGroup).alpha = show and 1 or 0
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).cg_areaTogGroup).interactable = show
end

UINAthList.ChangeAthListArea = function(self, areaId)
  -- function num : 0_25
  if self.suitNodeIsShow then
    (self.athListSuit):SetAthListSuitArea(areaId)
  else
    ;
    ((self.athListArea).athScrollList):SetAthScrollListArea(areaId)
    ;
    ((self.athListArea).athScrollList):RefreshAthScrollListData()
    ;
    ((self.athListArea).athScrollList):RefillAthScrollList()
  end
end

UINAthList._OnClickDetail = function(self, isOn)
  -- function num : 0_26 , upvalues : _ENV
  (PlayerDataCenter.allAthData):SetAthItemAttrShow(not (PlayerDataCenter.allAthData):IsAthItemAttrShow())
end

UINAthList._OnAthItemDetailShow = function(self)
  -- function num : 0_27 , upvalues : _ENV
  if not self.active then
    return 
  end
  local show = (PlayerDataCenter.allAthData):IsAthItemAttrShow()
  ;
  ((self.ui).img_Select):SetIndex(show and 1 or 0)
  if (self.athListArea).active then
    self:RefillCurAthSortList(true)
  end
end

UINAthList.OnDelete = function(self)
  -- function num : 0_28 , upvalues : base
  (self.athListArea):Delete()
  ;
  (self.athListSortNode):Delete()
  ;
  (self.athListSuit):Delete()
  ;
  (self.togArea):Delete()
  ;
  (self.togSuit):Delete()
  if self.sequence ~= nil then
    (self.sequence):Kill()
    self.sequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthList

