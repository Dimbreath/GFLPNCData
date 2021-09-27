local UINChipLevel = class("UINChipLevel", UIBaseNode)
local base = UIBaseNode
local cs_DoTweenLoopType = ((CS.DG).Tweening).LoopType
local cs_DoTween = ((CS.DG).Tweening).DOTween
UINChipLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  local buttonRect = (((self.ui).img_Count).sprite).rect
  self.buttonWith = buttonRect.width
  self.buttonHeight = buttonRect.height
  local unitRect = ((((self.ui).img_Curr).image).sprite).rect
  self.unitWith = unitRect.width
  self.unitHeight = unitRect.height
end

UINChipLevel.InitChipLevel = function(self, chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
  -- function num : 0_1 , upvalues : _ENV
  self.hasFlashTween = false
  local isFirstGet = false
  local currLevel = 0
  if not isHideNxtLvlInfo and dynPlayer ~= nil then
    local playerChipDic = dynPlayer:GetNormalChipDic()
    if playerChipDic[chipData.dataId] ~= nil then
      currLevel = (playerChipDic[chipData.dataId]):GetCount()
    else
      currLevel = chipData:GetCount()
      isFirstGet = true
    end
  else
    do
      currLevel = chipData:GetCount()
      self.currLevel = currLevel
      local maxLevel = chipData:GetChipMaxLevel()
      if not isOwnData or not currLevel + 1 then
        local nextLevel = (math.min)(currLevel + chipData:GetCount(), chipData:GetChipMaxLevel())
        self.nextLevel = nextLevel
        self:RefreshLevelUI(currLevel, nextLevel, maxLevel, dynPlayer, isHideNxtLvlInfo, isFirstGet)
      end
    end
  end
end

UINChipLevel.InitChipLevelSimple = function(self, currLevel, maxlevel)
  -- function num : 0_2 , upvalues : _ENV
  self.currLevel = currLevel
  local maxLevel = maxlevel
  local nextLevel = (math.min)(currLevel + 1, maxLevel)
  self.nextLevel = nextLevel
  self:RefreshLevelUI(currLevel, nextLevel, maxLevel)
end

UINChipLevel.RefreshLevelUI = function(self, currLevel, nextLevel, maxLevel, dynPlayer, isHideNxtLvlInfo, isFirstGet)
  -- function num : 0_3 , upvalues : _ENV, cs_DoTweenLoopType
  if (self.ui).obj_isMaxLevel ~= nil then
    ((self.ui).obj_isMaxLevel):SetActive(false)
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).img_Curr).transform).sizeDelta = Vector2.zero
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).img_Next).transform).sizeDelta = Vector2.zero
  ;
  ((self.ui).img_Curr):SetIndex(0)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tran_Count).sizeDelta = (Vector2.New)(self.buttonWith * maxLevel, self.buttonHeight)
  if not IsNull((self.ui).fx_lvUpBg) then
    ((self.ui).fx_lvUpBg):SetActive(false)
  end
  if not IsNull((self.ui).obj_countFx) then
    ((self.ui).obj_countFx):SetActive(false)
    if self._seq_obj_countFx ~= nil then
      (self._seq_obj_countFx):Pause()
    end
  end
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

  if maxLevel <= currLevel then
    (((self.ui).img_Curr).transform).sizeDelta = (Vector2.New)(self.unitWith * maxLevel, self.unitHeight)
    ;
    ((self.ui).img_Curr):SetIndex(1)
    if (self.ui).obj_isMaxLevel ~= nil then
      ((self.ui).obj_isMaxLevel):SetActive(true)
    end
    return 
  end
  -- DECOMPILER ERROR at PC109: Confused about usage of register: R7 in 'UnsetPending'

  if currLevel >= 0 and currLevel < nextLevel and not isHideNxtLvlInfo and dynPlayer ~= nil and not isFirstGet then
    (((self.ui).img_Curr).transform).sizeDelta = (Vector2.New)(self.unitWith * currLevel, self.unitHeight)
    local nextCount = (math.clamp)(nextLevel - currLevel, 1, maxLevel - currLevel)
    if self:_UseNewLevelTween() then
      self:_NewLevelTween(currLevel, nextCount)
    else
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (((self.ui).img_Next).transform).sizeDelta = (Vector2.New)(self.unitWith * nextCount, self.unitHeight)
      local nextCol = ConfigData:GetChipQuality(nextLevel)
      -- DECOMPILER ERROR at PC143: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self.ui).img_Next).color = ItemQualityColor[nextCol]
      ;
      ((self.ui).img_Next):DOKill()
      -- DECOMPILER ERROR at PC152: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self.ui).img_Next).color = Color.white
      local t = Time.time % 1.4
      ;
      ((((((self.ui).img_Next):DOFade(0, 0.7)):From()):SetLoops(-1, cs_DoTweenLoopType.Yoyo)):SetLink(((self.ui).img_Next).gameObject)):Goto(t, true)
    end
    do
      do
        self.hasFlashTween = true
        do return  end
        -- DECOMPILER ERROR at PC188: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (((self.ui).img_Curr).transform).sizeDelta = (Vector2.New)(self.unitWith * currLevel, self.unitHeight)
      end
    end
  end
end

UINChipLevel._UseNewLevelTween = function(self)
  -- function num : 0_4 , upvalues : _ENV
  do return not IsNull((self.ui).obj_countFx) and (self.ui).fxList_newLvPoint ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINChipLevel._NewLevelTween = function(self, curLevel, newLevelNum)
  -- function num : 0_5 , upvalues : _ENV, cs_DoTween
  if IsNull((self.ui).obj_countFx) or (self.ui).fxList_newLvPoint == nil then
    return 
  end
  local activeNum = 0
  for k,go in ipairs((self.ui).fxList_newLvPoint) do
    local show = curLevel <= k and activeNum < newLevelNum
    if show then
      activeNum = activeNum + 1
    end
    go:SetActive(show)
  end
  if self._seq_obj_countFx == nil then
    ((self.ui).fx_lvUpBg):SetActive(true)
    local seq = (cs_DoTween.Sequence)()
    ;
    (((seq:InsertCallback(0.75, function()
    -- function num : 0_5_0 , upvalues : self
    ((self.ui).obj_countFx):SetActive(true)
  end
)):InsertCallback(2.5, function()
    -- function num : 0_5_1 , upvalues : self
    ((self.ui).obj_countFx):SetActive(false)
  end
)):SetLoops(-1)):SetLink((self.ui).obj_countFx)
    self._seq_obj_countFx = seq
  else
    ((self.ui).fx_lvUpBg):SetActive(true)
    ;
    (self._seq_obj_countFx):Restart()
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINChipLevel.RefreshFlashTween = function(self)
  -- function num : 0_6 , upvalues : _ENV, cs_DoTweenLoopType
  if not self.hasFlashTween then
    return 
  end
  if self:_UseNewLevelTween() then
    ((self.ui).obj_countFx):SetActive(false)
    ;
    ((self.ui).fx_lvUpBg):SetActive(true)
    if self._seq_obj_countFx ~= nil then
      (self._seq_obj_countFx):Restart()
    end
  else
    ;
    ((self.ui).img_Next):DOKill(true)
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Next).color = Color.white
    local t = Time.time % 1.4
    ;
    ((((((self.ui).img_Next):DOFade(0, 0.7)):From()):SetLoops(-1, cs_DoTweenLoopType.Yoyo)):SetLink(((self.ui).img_Next).gameObject)):Goto(t, true)
  end
end

UINChipLevel.GetNextLevel = function(self)
  -- function num : 0_7
  return self.nextLevel
end

UINChipLevel.GetCurrLevel = function(self)
  -- function num : 0_8
  return self.currLevel
end

UINChipLevel.HasFlashTween = function(self)
  -- function num : 0_9
  return self.hasFlashTween
end

UINChipLevel.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  ((self.ui).img_Next):DOKill()
  ;
  (base.OnDelete)(self)
end

return UINChipLevel

