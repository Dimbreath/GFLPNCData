local UIOasisBuildingCanvasNameItem = class("UIOasisBuildingCanvasNameItem", UIBaseNode)
local base = UIBaseNode
local cs_tweening = (CS.DG).Tweening
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
  self:UpdateBuildingLevel(UIbulidData.level)
  self:ShowBuildName3dTop(isTop)
  self:BuildName3dCanLevelUp(UIbulidData.canLvUp)
end

UIOasisBuildingCanvasNameItem.Split = function(self, flowRoot, bg1Root, bg2Root, arrowBgRoot, text1Root, text2Root)
  -- function num : 0_2
  (((self.ui).bg).transform):SetParent(bg1Root)
  ;
  (((self.ui).canLevelUp).transform):SetParent(bg1Root)
  ;
  ((self.ui).bgEditor):SetParent(bg2Root)
  ;
  ((self.ui).arrowBg):SetParent(arrowBgRoot)
  ;
  ((self.ui).Flow):SetParent(flowRoot)
  ;
  (((self.ui).img_BLN).transform):SetParent(bg1Root)
  ;
  (((self.ui).tex_Name).transform):SetParent(text1Root)
  ;
  (((self.ui).tex_NameEditor).transform):SetParent(text1Root)
  ;
  ((self.ui).texLevelUp):SetParent(text1Root)
  ;
  (((self.ui).tex_Level).transform):SetParent(text2Root)
end

UIOasisBuildingCanvasNameItem.ShowBuildName3dTop = function(self, isTop)
  -- function num : 0_3
  self.isTop = isTop
  ;
  (((self.ui).bg).gameObject):SetActive(not isTop)
  ;
  (((self.ui).canLevelUp).gameObject):SetActive(not isTop)
  ;
  (((self.ui).tex_Name).gameObject):SetActive(not isTop)
  ;
  (((self.ui).texLevelUp).gameObject):SetActive(not isTop)
  ;
  (((self.ui).Flow).gameObject):SetActive(not isTop)
  ;
  (((self.ui).img_BLN).gameObject):SetActive(not isTop)
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
  -- function num : 0_5 , upvalues : _ENV, cs_tweening
  local show = self.canLvUp and ((not self.isTop and self.active))
  ;
  (((self.ui).arrowBg).gameObject):SetActive(show)
  if show then
    if self._arrowTween == nil then
      self._arrowTween = (((self.ui).arrow):DOPunchPosition((Vector3.New)(0, 6, 0), 1, 1)):SetLoops(-1)
    end
    if self._blnTween == nil then
      self._blnTween = (((self.ui).img_BLN):DOFade(0, 1.5)):SetLoops(-1, (cs_tweening.LoopType).Yoyo)
    end
  else
    self:_ClearArrowTween()
    self:_ClearBLNTween()
  end
  ;
  (((self.ui).texLevelUp).gameObject):SetActive(show)
  ;
  (((self.ui).canLevelUp).gameObject):SetActive(show)
  ;
  (((self.ui).Flow).gameObject):SetActive(show)
  ;
  (((self.ui).img_BLN).gameObject):SetActive(show)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
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

UIOasisBuildingCanvasNameItem._ClearBLNTween = function(self)
  -- function num : 0_7
  if self._blnTween ~= nil then
    (self._blnTween):Rewind()
    ;
    (self._blnTween):Kill()
    self._blnTween = nil
  end
end

UIOasisBuildingCanvasNameItem.UpdateNamePos = function(self, position)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).position = position
end

UIOasisBuildingCanvasNameItem.UpdateBuildingLevel = function(self, level)
  -- function num : 0_9 , upvalues : _ENV
  local isUnits = level <= 9
  local strLevel = tostring(level)
  if isUnits then
    strLevel = "0" .. strLevel
  end
  ;
  ((self.ui).tex_Level):SetIndex(0, strLevel)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIOasisBuildingCanvasNameItem.OnRecycle = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.id = nil
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.zero
  self:_ClearArrowTween()
  self:_ClearBLNTween()
end

UIOasisBuildingCanvasNameItem.OnShow = function(self)
  -- function num : 0_11
  self:ShowBuildName3dTop(self.isTop)
end

UIOasisBuildingCanvasNameItem.OnHide = function(self)
  -- function num : 0_12
  (((self.ui).bg).gameObject):SetActive(false)
  ;
  (((self.ui).canLevelUp).gameObject):SetActive(false)
  ;
  (((self.ui).arrowBg).gameObject):SetActive(false)
  ;
  (((self.ui).tex_Name).gameObject):SetActive(false)
  ;
  (((self.ui).texLevelUp).gameObject):SetActive(false)
  ;
  (((self.ui).Flow).gameObject):SetActive(false)
  ;
  (((self.ui).img_BLN).gameObject):SetActive(false)
  ;
  (((self.ui).tex_Level).gameObject):SetActive(false)
  ;
  (((self.ui).bgEditor).gameObject):SetActive(false)
  ;
  (((self.ui).tex_NameEditor).gameObject):SetActive(false)
end

UIOasisBuildingCanvasNameItem.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (((self.ui).bg).transform):SetParent(((self.ui).normal).transform)
  ;
  ((self.ui).arrowBg):SetParent(((self.ui).normal).transform)
  ;
  (((self.ui).tex_Name).transform):SetParent(((self.ui).normal).transform)
  ;
  ((self.ui).Flow):SetParent(((self.ui).normal).transform)
  ;
  (((self.ui).img_BLN).transform):SetParent(((self.ui).normal).transform)
  ;
  (((self.ui).tex_Level).transform):SetParent(((self.ui).normal).transform)
  ;
  ((self.ui).texLevelUp):SetParent(((self.ui).normal).transform)
  ;
  ((self.ui).bgEditor):SetParent(((self.ui).editor).transform)
  ;
  (((self.ui).tex_NameEditor).transform):SetParent(((self.ui).editor).transform)
  self:_ClearArrowTween()
  self:_ClearBLNTween()
  ;
  (base.OnDelete)(self)
end

return UIOasisBuildingCanvasNameItem

