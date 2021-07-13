-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipLevel = class("UINChipLevel", UIBaseNode)
local base = UIBaseNode
local cs_DoTweenLoopType = ((CS.DG).Tweening).LoopType
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

UINChipLevel.RefreshLevelUI = function(self, currLevel, nextLevel, maxLevel, dynPlayer, isHideNxtLvlInfo, isFirstGet)
  -- function num : 0_2 , upvalues : _ENV, cs_DoTweenLoopType
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
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

  if maxLevel <= currLevel then
    (((self.ui).img_Curr).transform).sizeDelta = (Vector2.New)(self.unitWith * maxLevel, self.unitHeight)
    ;
    ((self.ui).img_Curr):SetIndex(1)
    if (self.ui).obj_isMaxLevel ~= nil then
      ((self.ui).obj_isMaxLevel):SetActive(true)
    end
    return 
  end
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R7 in 'UnsetPending'

  if currLevel >= 0 and currLevel < nextLevel and not isHideNxtLvlInfo and dynPlayer ~= nil and not isFirstGet then
    (((self.ui).img_Curr).transform).sizeDelta = (Vector2.New)(self.unitWith * currLevel, self.unitHeight)
    local nextCount = (math.clamp)(nextLevel - currLevel, 1, maxLevel - currLevel)
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (((self.ui).img_Next).transform).sizeDelta = (Vector2.New)(self.unitWith * nextCount, self.unitHeight)
    local nextCol = ConfigData:GetChipQuality(nextLevel)
    ;
    ((self.ui).img_Next):DOKill()
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).img_Next).color = Color.white
    ;
    (((((self.ui).img_Next):DOFade(0, 0.7)):From()):SetLoops(-1, cs_DoTweenLoopType.Yoyo)):SetLink(((self.ui).img_Next).gameObject)
    self.hasFlashTween = true
    return 
  end
  do
    -- DECOMPILER ERROR at PC139: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((self.ui).img_Curr).transform).sizeDelta = (Vector2.New)(self.unitWith * currLevel, self.unitHeight)
  end
end

UINChipLevel.RefreshFlashTween = function(self)
  -- function num : 0_3 , upvalues : _ENV, cs_DoTweenLoopType
  if not self.hasFlashTween then
    return 
  end
  ;
  ((self.ui).img_Next):DOKill(true)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Next).color = Color.white
  ;
  (((((self.ui).img_Next):DOFade(0, 0.7)):From()):SetLoops(-1, cs_DoTweenLoopType.Yoyo)):SetLink(((self.ui).img_Next).gameObject)
end

UINChipLevel.GetNextLevel = function(self)
  -- function num : 0_4
  return self.nextLevel
end

UINChipLevel.HasFlashTween = function(self)
  -- function num : 0_5
  return self.hasFlashTween
end

UINChipLevel.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  ((self.ui).img_Next):DOKill()
  ;
  (base.OnDelete)(self)
end

return UINChipLevel

