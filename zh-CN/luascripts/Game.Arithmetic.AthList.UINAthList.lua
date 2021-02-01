-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthList = class("UINAthList", UIBaseNode)
local base = UIBaseNode
local UINAthListArea = require("Game.Arithmetic.AthList.Area.UINAthListArea")
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
local UINAthListSort = require("Game.Arithmetic.AthList.Sort.UINAthListSort")
local CS_DoTween = ((CS.DG).Tweening).DOTween
local CS_ResLoader = CS.ResLoader
local spaceIdDic = {[1] = 1, [2] = 2, [4] = 3, [8] = 4}
UINAthList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthListArea, UINAthListSort
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sort, self, self.OnClickSort)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Decompose, self, self._OnClickDecompose)
  self.__OnClickAthItem = BindCallback(self, self.OnClickAthItem)
  self.__onAthDataUpdate = BindCallback(self, self.OnAthDataUpdate)
  self.athListArea = (UINAthListArea.New)()
  ;
  (self.athListArea):Init((self.ui).areaNode)
  self.athListSortNode = (UINAthListSort.New)()
  ;
  (self.athListSortNode):Init((self.ui).sortDropdown)
  ;
  (self.athListSortNode):InitAthListSort(self)
  ;
  (self.athListSortNode):Hide()
  local fecomposeUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Decompose)
  self:ShowAthListDecomposeBtn(fecomposeUnlock)
end

UINAthList.InitAthListNode = function(self, heroData, resLoader, withMat, clickItemFunc, areaId, quality, changeAreaFunc, ignoreInstalled)
  -- function num : 0_1
  self.heroData = heroData
  self.clickItemFunc = clickItemFunc
  self.resLoader = resLoader
  self.withMat = withMat
  ;
  ((self.athListArea).athScrollList):SetAthScrollListSortFunc(self._sortFunc)
  ;
  (self.athListArea):InitAthListArea(heroData, areaId, quality, self.__OnClickAthItem, self.__itemStartDragFunc, resLoader, withMat, changeAreaFunc, ignoreInstalled)
end

UINAthList.ShowAthListDecomposeBtn = function(self, show)
  -- function num : 0_2
  (((self.ui).btn_Decompose).gameObject):SetActive(show)
end

UINAthList.SetAthItemStartDragFunc = function(self, itemStartDragFunc)
  -- function num : 0_3
  self.__itemStartDragFunc = itemStartDragFunc
end

UINAthList.OnAthDataUpdate = function(self)
  -- function num : 0_4
  ((self.athListArea).athScrollList):RefreshAthScrollListData()
  self:RefillCurAthSortList(true)
end

UINAthList.RefillCurAthSortList = function(self, useLastPos)
  -- function num : 0_5
  ((self.athListArea).athScrollList):RefillAthScrollList(self.__SiftFunction, self._sortFunc, useLastPos)
end

UINAthList.OnClickAthItem = function(self, athItem)
  -- function num : 0_6
  if self.clickItemFunc ~= nil then
    (self.clickItemFunc)(athItem)
  end
end

UINAthList.GetAthItemGo = function(self, space)
  -- function num : 0_7 , upvalues : spaceIdDic, _ENV
  local index = spaceIdDic[space]
  if index == nil then
    error("Can\'t get athItemGo, space = " .. tostring(space))
    return 
  end
  return ((((self.athListArea).athScrollList).ui).athSpaceItemList)[index]
end

UINAthList._OnClickDecompose = function(self)
  -- function num : 0_8 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AthDecompose, function(window)
    -- function num : 0_8_0 , upvalues : self
    if window == nil then
      return 
    end
    self:Hide()
    window:InitAthDecompose(self.resLoader, function()
      -- function num : 0_8_0_0 , upvalues : self
      self:Show()
    end
)
  end
)
end

UINAthList.OnClickSort = function(self)
  -- function num : 0_9
  (self.athListSortNode):ShowAthListSort()
end

UINAthList.DragInAthSortList = function(self, worldPos)
  -- function num : 0_10 , upvalues : _ENV
  local anchordPos = UIManager:World2UIPosition(worldPos, self.transform, nil, UIManager.UICamera)
  if anchordPos.x <= ((self.transform).rect).xMax then
    return true
  end
  return false
end

UINAthList.OnShow = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self:SetAthSortListTween()
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthList.OnHide = function(self)
  -- function num : 0_12 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

UINAthList.SetAthSortListTween = function(self)
  -- function num : 0_13 , upvalues : _ENV, CS_DoTween
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
  -- function num : 0_14
  return ((self.athListArea).athScrollList):GetAthItemFromListAll(uid)
end

UINAthList.ChangeAthListSort = function(self, kindType, kindValue, name, isInit)
  -- function num : 0_15 , upvalues : AthSortEnum
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).tex_Sort).text = name
  self._sortFunc = (AthSortEnum.GetSortFunc)(kindType, kindValue)
  if not isInit then
    self:RefillCurAthSortList()
  end
end

UINAthList.OnDelete = function(self)
  -- function num : 0_16 , upvalues : base
  (self.athListArea):Delete()
  ;
  (self.athListSortNode):Delete()
  if self.sequence ~= nil then
    (self.sequence):Kill()
    self.sequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthList

