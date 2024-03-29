local UINHeroLevelUpItem = class("UINHeroLevelUpItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINHeroLevelUpItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  self.selectedNum = 0
  self.itemNum = nil
  self.exp = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Minus, self, self.MinusOne)
  ;
  ((((self.baseItem).ui).btn_Root).onPress):AddListener(BindCallback(self, self.PressAdd))
  ;
  (((self.ui).btn_Minus).onPress):AddListener(BindCallback(self, self.PressMinus))
end

UINHeroLevelUpItem.InitExpItem = function(self, itemData, numChangeFunc, checkItemUseFunc)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = itemData.itemCfg
  self.id = itemCfg.id
  self.itemNum = itemData:GetCount()
  self.numChangeFunc = numChangeFunc
  self.checkItemUseFunc = checkItemUseFunc
  self.exp = itemData:GetActionArg(1)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).CanvasGroup).alpha = 1
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, tostring(self.itemNum))
  ;
  (self.baseItem):InitBaseItem(itemCfg, BindCallback(self, self.AddOne))
  self:UpdateSelectedNum()
end

UINHeroLevelUpItem.InitEmptyExpItem = function(self, itemId)
  -- function num : 0_2 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  self.id = itemId
  self.itemNum = nil
  self.exp = nil
  ;
  (((self.ui).obj_UseCount).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).CanvasGroup).alpha = 0.5
  ;
  (((self.ui).btn_Minus).gameObject):SetActive(false)
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, "0")
  ;
  (self.baseItem):InitBaseItem(itemCfg)
end

UINHeroLevelUpItem.UpdateSelectedNum = function(self, num, isForbidCall)
  -- function num : 0_3 , upvalues : _ENV
  if not num then
    num = self.selectedNum
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

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
  if self.numChangeFunc ~= nil and not isForbidCall then
    (self.numChangeFunc)(num)
  end
end

UINHeroLevelUpItem.SetAddExpLimt = function(self, maxAddExp, addExp)
  -- function num : 0_4
  self.addableExp = maxAddExp - addExp
  self.addedExp = addExp
end

UINHeroLevelUpItem.AddOne = function(self)
  -- function num : 0_5 , upvalues : _ENV
  do
    if self.checkItemUseFunc ~= nil then
      local canUse = (self.checkItemUseFunc)(true)
      if not canUse then
        return 
      end
    end
    if self.itemNum < self.selectedNum + 1 or self.addableExp <= 0 and self.addedExp > 0 then
      return 
    end
    AudioManager:PlayAudioById(1064)
    self.selectedNum = self.selectedNum + 1
    self:UpdateSelectedNum()
  end
end

UINHeroLevelUpItem.PressAdd = function(self)
  -- function num : 0_6 , upvalues : _ENV
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
    local pressedTime = (((self.baseItem).ui).btn_Root):GetPressedTime()
    local addNum = (math.ceil)(pressedTime * pressedTime / 5)
    if self.itemNum <= self.selectedNum + addNum or self.addableExp < addNum * self.exp then
      local remainNum = self.itemNum - self.selectedNum
      local newAddNum = (math.min)(remainNum, (math.ceil)(self.addableExp / self.exp))
      if newAddNum > 0 then
        addNum = newAddNum
      else
        if self.addedExp == 0 and remainNum > 0 then
          addNum = 1
        else
          return 
        end
      end
    end
    do
      AudioManager:PlayAudioById(1064)
      self.selectedNum = self.selectedNum + addNum
      self:UpdateSelectedNum()
    end
  end
end

UINHeroLevelUpItem.MinusOne = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.selectedNum - 1 < 0 then
    return 
  end
  AudioManager:PlayAudioById(1065)
  self.selectedNum = self.selectedNum - 1
  self:UpdateSelectedNum()
end

UINHeroLevelUpItem.PressMinus = function(self)
  -- function num : 0_8 , upvalues : _ENV
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

UINHeroLevelUpItem.CleanAll = function(self, isForbidCall)
  -- function num : 0_9
  self.selectedNum = 0
  self:UpdateSelectedNum(0, isForbidCall)
end

UINHeroLevelUpItem.GetHeroLvUpItemId = function(self)
  -- function num : 0_10
  return self.id
end

UINHeroLevelUpItem.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  if self.fillTween ~= nil then
    (self.fillTween):Kill(true)
    self.fillTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINHeroLevelUpItem

