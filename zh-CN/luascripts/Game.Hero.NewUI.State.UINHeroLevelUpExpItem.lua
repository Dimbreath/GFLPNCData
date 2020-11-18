-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroLevelUpExpItem = class("UINHeroLevelUpExpItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINHeroLevelUpExpItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  self.selectedNum = 0
  self.itemNum = nil
  self.exp = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reduce, self, self.MinusOne)
  ;
  ((((self.baseItem).ui).btn_Root).onPress):AddListener(BindCallback(self, self.PressAdd))
  ;
  (((self.ui).btn_Reduce).onPress):AddListener(BindCallback(self, self.PressMinus))
  self.ringPlayback = BindCallback(self, self.PlayRingBack)
end

UINHeroLevelUpExpItem.InitExpItem = function(self, itemData, numChangeFunc)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = itemData.itemCfg
  self.itemNum = itemData:GetCount()
  self.numChangeFunc = numChangeFunc
  self.exp = itemData:GetActionArg(1)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).CanvasGroup).alpha = 1
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, tostring(self.itemNum))
  ;
  (self.baseItem):InitBaseItem(itemCfg, BindCallback(self, self.AddOne))
  self:UpdateSelectedNum()
end

UINHeroLevelUpExpItem.InitEmptyExpItem = function(self, itemId)
  -- function num : 0_2 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).CanvasGroup).alpha = 0.5
  ;
  (((self.ui).btn_Reduce).gameObject):SetActive(false)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, "0")
  ;
  (self.baseItem):InitBaseItem(itemCfg)
end

UINHeroLevelUpExpItem.UpdateSelectedNum = function(self, num)
  -- function num : 0_3 , upvalues : _ENV
  if not num then
    num = self.selectedNum
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_UseCount).text = tostring(num)
  if num == 0 then
    (((self.ui).btn_Reduce).gameObject):SetActive(false)
  else
    ;
    (((self.ui).btn_Reduce).gameObject):SetActive(true)
  end
  if self.numChangeFunc ~= nil then
    (self.numChangeFunc)(num)
  end
end

UINHeroLevelUpExpItem.SetAddExpLimt = function(self, maxAddExp, addExp)
  -- function num : 0_4
  self.addableExp = maxAddExp - addExp
end

UINHeroLevelUpExpItem.PlayRing = function(self)
  -- function num : 0_5
  (((self.ui).img_RingAnima).gameObject):SetActive(true)
  local time = (self.ui).float_ringTime
  if self.fillTween ~= nil then
    (self.fillTween):Kill(true)
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_RingAnima).fillAmount = 0
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_RingAnima).fillClockwise = true
  self.fillTween = ((self.ui).img_RingAnima):DOFillAmount(1, time)
  ;
  (self.fillTween):OnComplete(self.ringPlayback)
end

UINHeroLevelUpExpItem.PlayRingBack = function(self)
  -- function num : 0_6
  local time = (self.ui).float_ringTime
  if self.fillTween ~= nil then
    (self.fillTween):Kill(true)
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_RingAnima).fillAmount = 1
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_RingAnima).fillClockwise = false
  self.fillTween = ((self.ui).img_RingAnima):DOFillAmount(0, time)
end

UINHeroLevelUpExpItem.AddOne = function(self)
  -- function num : 0_7
  if self.itemNum < self.selectedNum + 1 or self.addableExp <= 0 then
    return 
  end
  self.selectedNum = self.selectedNum + 1
  self:UpdateSelectedNum()
  self:PlayRing()
end

UINHeroLevelUpExpItem.PressAdd = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local pressedTime = (((self.baseItem).ui).btn_Root):GetPressedTime()
  local addNum = (math.ceil)(pressedTime * pressedTime / 10)
  do
    if self.itemNum <= self.selectedNum + addNum or self.addableExp < addNum * self.exp then
      local newAddNum = (math.min)(self.itemNum - self.selectedNum, (math.ceil)(self.addableExp / self.exp))
      if newAddNum > 0 then
        addNum = newAddNum
      else
        return 
      end
    end
    self.selectedNum = self.selectedNum + addNum
    self:UpdateSelectedNum()
    self:PlayRing()
  end
end

UINHeroLevelUpExpItem.MinusOne = function(self)
  -- function num : 0_9
  if self.selectedNum - 1 < 0 then
    return 
  end
  self.selectedNum = self.selectedNum - 1
  self:UpdateSelectedNum()
end

UINHeroLevelUpExpItem.PressMinus = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_Reduce):GetPressedTime()
  local minusNum = (math.ceil)(pressedTime * pressedTime / 10)
  if self.selectedNum - minusNum <= 0 then
    self.selectedNum = 0
  else
    self.selectedNum = self.selectedNum - minusNum
  end
  self:UpdateSelectedNum()
end

UINHeroLevelUpExpItem.CleanAll = function(self)
  -- function num : 0_11
  self.selectedNum = 0
  self:UpdateSelectedNum()
end

UINHeroLevelUpExpItem.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  if self.fillTween ~= nil then
    (self.fillTween):Kill(true)
    self.fillTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINHeroLevelUpExpItem

