local UINAthMatUpItem = class("UINAthMatUpItem", UIBaseNode)
local base = UIBaseNode
UINAthMatUpItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.selectedNum = 0
  self.itemNum = nil
  self.exp = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Minus, self, self.MinusOne)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.AddOne)
  ;
  (((self.ui).btn_Add).onPress):AddListener(BindCallback(self, self.PressAdd))
  ;
  (((self.ui).btn_Minus).onPress):AddListener(BindCallback(self, self.PressMinus))
end

UINAthMatUpItem.InitExpItem = function(self, itemData, numChangeFunc, checkItemUseFunc)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = itemData.itemCfg
  self.id = itemCfg.id
  self.itemNum = itemData:GetCount()
  self.numChangeFunc = numChangeFunc
  self.itemCfg = itemCfg
  self.checkItemUseFunc = checkItemUseFunc
  self.exp = itemData:GetActionArg(1)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).CanvasGroup).alpha = 1
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, tostring(self.itemNum))
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_ItemPic).sprite = CRH:GetSpriteByItemConfig(itemCfg)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).hasCount).color = itemData:GetColor()
  self:UpdateSelectedNum()
end

UINAthMatUpItem.InitEmptyExpItem = function(self, itemId)
  -- function num : 0_2 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  self.itemCfg = itemCfg
  self.id = itemId
  self.itemNum = nil
  self.exp = nil
  ;
  (((self.ui).obj_UseCount).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).CanvasGroup).alpha = 0.5
  ;
  (((self.ui).btn_Minus).gameObject):SetActive(false)
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, "0")
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_ItemPic).sprite = CRH:GetSpriteByItemConfig(itemCfg)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).hasCount).color = ItemQualityColor[itemCfg.quality]
end

UINAthMatUpItem.UpdateSelectedNum = function(self, num)
  -- function num : 0_3 , upvalues : _ENV
  if not num then
    num = self.selectedNum
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_UseCount).text = tostring(num)
  if num == 0 then
    (((self.ui).btn_Minus).gameObject):SetActive(false)
    ;
    (((self.ui).obj_UseCount).gameObject):SetActive(false)
  else
    ;
    (((self.ui).btn_Minus).gameObject):SetActive(true)
    ;
    (((self.ui).obj_UseCount).gameObject):SetActive(true)
  end
  if self.numChangeFunc ~= nil then
    (self.numChangeFunc)(num)
  end
end

UINAthMatUpItem.SetAddExpLimt = function(self, maxAddExp, addExp, expLimitFunc)
  -- function num : 0_4
  self.addableExp = maxAddExp - addExp
  self.expLimitFunc = expLimitFunc
end

UINAthMatUpItem.AddOne = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local complete = self:TryAddOne()
  if complete then
    AudioManager:PlayAudioById(1064)
  end
end

UINAthMatUpItem.TryAddOne = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.itemNum == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    -- function num : 0_6_0 , upvalues : self
    if win ~= nil then
      win:InitCommonItemDetail(self.itemCfg)
    end
  end
)
    return false
  end
  do
    if self.checkItemUseFunc ~= nil then
      local canUse = (self.checkItemUseFunc)(true)
      if not canUse then
        return false
      end
    end
    if self.addableExp <= 0 then
      if self.expLimitFunc ~= nil then
        (self.expLimitFunc)()
      end
      return false
    end
    if self.itemNum < self.selectedNum + 1 then
      return false
    end
    self.selectedNum = self.selectedNum + 1
    self:UpdateSelectedNum()
    return true
  end
end

UINAthMatUpItem.PressAdd = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.itemNum == nil then
    return 
  end
  do
    if self.checkItemUseFunc ~= nil then
      local canUse = (self.checkItemUseFunc)(true)
      if not canUse then
        return 
      end
    end
    local pressedTime = ((self.ui).btn_Add):GetPressedTime()
    local addNum = (math.ceil)(pressedTime * pressedTime / 5)
    do
      if self.itemNum <= self.selectedNum + addNum or self.addableExp < addNum * self.exp then
        local newAddNum = (math.min)(self.itemNum - self.selectedNum, (math.ceil)(self.addableExp / self.exp))
        if newAddNum > 0 then
          addNum = newAddNum
        else
          return 
        end
      end
      AudioManager:PlayAudioById(1064)
      self.selectedNum = self.selectedNum + addNum
      self:UpdateSelectedNum()
    end
  end
end

UINAthMatUpItem.MinusOne = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.selectedNum - 1 < 0 then
    return 
  end
  self.selectedNum = self.selectedNum - 1
  AudioManager:PlayAudioById(1065)
  self:UpdateSelectedNum()
end

UINAthMatUpItem.PressMinus = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_Minus):GetPressedTime()
  local minusNum = (math.ceil)(pressedTime * pressedTime / 10)
  if self.selectedNum - minusNum <= 0 then
    self.selectedNum = 0
  else
    self.selectedNum = self.selectedNum - minusNum
  end
  AudioManager:PlayAudioById(1065)
  self:UpdateSelectedNum()
end

UINAthMatUpItem.CleanAll = function(self)
  -- function num : 0_10
  self.selectedNum = 0
  self:UpdateSelectedNum()
end

UINAthMatUpItem.GetHeroLvUpItemId = function(self)
  -- function num : 0_11
  return self.id
end

UINAthMatUpItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  if self.fillTween ~= nil then
    (self.fillTween):Kill(true)
    self.fillTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINAthMatUpItem

