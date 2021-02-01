-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingCanvasNameItem = class("UIOasisBuildingCanvasNameItem", UIBaseNode)
local base = UIBaseNode
UIOasisBuildingCanvasNameItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIOasisBuildingCanvasNameItem.InitCanvasNameItem = function(self, id, UIbulidData, isTop)
  -- function num : 0_1
  self.id = id
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = UIbulidData.name
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEditor).text = UIbulidData.name
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEN).text = UIbulidData.nameEn
  self:UpdateBuildingLevel(UIbulidData.level)
  self:ShowBuildName3dTop(isTop)
  self:BuildName3dCanLevelUp(UIbulidData.canLvUp)
end

UIOasisBuildingCanvasNameItem.Split = function(self, bg1Root, bg2Root, arrowBgRoot, text1Root, text2Root)
  -- function num : 0_2
  ((self.ui).bg):SetParent(bg1Root)
  ;
  ((self.ui).bgEditor):SetParent(bg2Root)
  ;
  ((self.ui).arrowBg):SetParent(arrowBgRoot)
  ;
  (((self.ui).tex_Name).transform):SetParent(text1Root)
  ;
  (((self.ui).tex_NameEditor).transform):SetParent(text1Root)
  ;
  (((self.ui).tex_NameEN).transform):SetParent(text2Root)
  ;
  (((self.ui).tex_Level).transform):SetParent(text2Root)
end

UIOasisBuildingCanvasNameItem.ShowBuildName3dTop = function(self, isTop)
  -- function num : 0_3
  self.isTop = isTop
  ;
  (((self.ui).bg).gameObject):SetActive(not isTop)
  ;
  (((self.ui).tex_Name).gameObject):SetActive(not isTop)
  ;
  (((self.ui).tex_NameEN).gameObject):SetActive(not isTop)
  ;
  (((self.ui).tex_Level).gameObject):SetActive(not isTop)
  self:__RefreshLvUpState()
  ;
  (((self.ui).bgEditor).gameObject):SetActive(isTop)
  ;
  (((self.ui).tex_NameEditor).gameObject):SetActive(isTop)
end

UIOasisBuildingCanvasNameItem.BuildName3dCanLevelUp = function(self, canLvUp)
  -- function num : 0_4
  self.canLvUp = canLvUp
  self:__RefreshLvUpState()
end

UIOasisBuildingCanvasNameItem.__RefreshLvUpState = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local show = self.canLvUp and ((not self.isTop and self.active))
  ;
  (((self.ui).arrowBg).gameObject):SetActive(show)
  -- DECOMPILER ERROR at PC36: Unhandled construct in 'MakeBoolean' P1

  if show and self._arrowTween == nil then
    self._arrowTween = (((self.ui).arrow):DOPunchPosition((Vector3.New)(0, 6, 0), 1, 1)):SetLoops(-1)
  end
  self:_ClearArrowTween()
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIOasisBuildingCanvasNameItem._ClearArrowTween = function(self)
  -- function num : 0_6
  if self._arrowTween ~= nil then
    (self._arrowTween):Rewind()
    ;
    (self._arrowTween):Kill()
    self._arrowTween = nil
  end
end

UIOasisBuildingCanvasNameItem.UpdateNamePos = function(self, position)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = position
end

UIOasisBuildingCanvasNameItem.UpdateBuildingLevel = function(self, level)
  -- function num : 0_8 , upvalues : _ENV
  local index = level >= 9 and 1 or 0
  ;
  ((self.ui).tex_Level):SetIndex(index, tostring(level))
end

UIOasisBuildingCanvasNameItem.OnRecycle = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self.id = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.zero
  self:_ClearArrowTween()
end

UIOasisBuildingCanvasNameItem.OnShow = function(self)
  -- function num : 0_10
  self:ShowBuildName3dTop(self.isTop)
end

UIOasisBuildingCanvasNameItem.OnHide = function(self)
  -- function num : 0_11
  (((self.ui).bg).gameObject):SetActive(false)
  ;
  (((self.ui).arrowBg).gameObject):SetActive(false)
  ;
  (((self.ui).tex_Name).gameObject):SetActive(false)
  ;
  (((self.ui).tex_NameEN).gameObject):SetActive(false)
  ;
  (((self.ui).tex_Level).gameObject):SetActive(false)
  ;
  (((self.ui).bgEditor).gameObject):SetActive(false)
  ;
  (((self.ui).tex_NameEditor).gameObject):SetActive(false)
end

UIOasisBuildingCanvasNameItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  ((self.ui).bg):SetParent(((self.ui).normal).transform)
  ;
  ((self.ui).arrowBg):SetParent(((self.ui).normal).transform)
  ;
  (((self.ui).tex_Name).transform):SetParent(((self.ui).normal).transform)
  ;
  (((self.ui).tex_NameEN).transform):SetParent(((self.ui).normal).transform)
  ;
  (((self.ui).tex_Level).transform):SetParent(((self.ui).normal).transform)
  ;
  ((self.ui).bgEditor):SetParent(((self.ui).editor).transform)
  ;
  (((self.ui).tex_NameEditor).transform):SetParent(((self.ui).editor).transform)
  self:_ClearArrowTween()
  ;
  (base.OnDelete)(self)
end

return UIOasisBuildingCanvasNameItem

