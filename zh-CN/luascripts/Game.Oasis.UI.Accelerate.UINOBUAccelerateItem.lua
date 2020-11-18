-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOBUAccelerateItem = class("UINOBUAccelerateItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINOBUAccelerateItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  self.selectedNum = 0
  self.itemNum = 0
  self.time = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_BaseItem)
  if ((self.baseItem).ui).btn_Root ~= nil then
    (UIUtil.AddButtonListener)(((self.baseItem).ui).btn_Root, self, self.AddOne)
    ;
    ((((self.baseItem).ui).btn_Root).onPress):AddListener(BindCallback(self, self.PressAdd))
  end
  if (self.ui).btn_Reduce ~= nil then
    (UIUtil.AddButtonListener)((self.ui).btn_Reduce, self, self.MinusOne)
    ;
    (((self.ui).btn_Reduce).onPress):AddListener(BindCallback(self, self.PressMinus))
  end
  self.ringPlayback = BindCallback(self, self.PlayRingBack)
end

UINOBUAccelerateItem.InitItem = function(self, itemData, numChangeFunc)
  -- function num : 0_1 , upvalues : _ENV
  local itemCfg = itemData.itemCfg
  self.itemNum = itemData:GetCount()
  self.numChangeFunc = numChangeFunc
  self.time = itemData:GetActionArg(1)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  if (self.ui).CanvasGroup ~= nil then
    ((self.ui).CanvasGroup).alpha = 1
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, tostring(self.itemNum))
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

  if (self.ui).img_Icon ~= nil then
    ((self.ui).img_Icon).sprite = CRH:GetSprite(itemData:GetIcon())
  end
  ;
  (self.baseItem):InitBaseItem(itemCfg, nil)
  self:UpdateSelectedNum()
end

UINOBUAccelerateItem.InitEmptyItem = function(self, itemId)
  -- function num : 0_2 , upvalues : _ENV
  local itemCfg = (ConfigData.item)[itemId]
  self.time = (itemCfg.arg)[1] or 0
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  if (self.ui).CanvasGroup ~= nil then
    ((self.ui).CanvasGroup).alpha = 0.5
  end
  if (self.ui).btn_Reduce ~= nil then
    (((self.ui).btn_Reduce).gameObject):SetActive(false)
  end
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  ;
  ((self.ui).tex_TotalCount):SetIndex(0, "0")
  ;
  (self.baseItem):InitBaseItem(itemCfg)
end

UINOBUAccelerateItem.UpdateSelectedNum = function(self, num, notCal, needNum)
  -- function num : 0_3 , upvalues : _ENV
  if not num then
    num = self.selectedNum
  end
  if not needNum then
    needNum = 0
  end
  if (self.ui).tex_TotalCount ~= nil then
    if needNum == 0 then
      ((self.ui).tex_TotalCount):SetIndex(0, tostring(num))
    else
      if num < needNum then
        ((self.ui).tex_TotalCount):SetIndex(2, tostring(num), tostring(needNum))
      else
        ;
        ((self.ui).tex_TotalCount):SetIndex(1, tostring(num), tostring(needNum))
      end
    end
  end
  if (self.ui).btnReduce ~= nil then
    if num == 0 then
      (((self.ui).btn_Reduce).gameObject):SetActive(false)
    else
      ;
      (((self.ui).btn_Reduce).gameObject):SetActive(true)
    end
  end
  if self.numChangeFunc ~= nil then
    (self.numChangeFunc)(num, notCal)
  end
end

UINOBUAccelerateItem.SetAddTimeLimt = function(self, addableTime)
  -- function num : 0_4
  self.addableTime = addableTime
end

UINOBUAccelerateItem.PlayRing = function(self)
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

UINOBUAccelerateItem.PlayRingBack = function(self)
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

UINOBUAccelerateItem.SetSelectNum = function(self, num, needNum)
  -- function num : 0_7
  self.selectedNum = num
  self:UpdateSelectedNum(num, nil, needNum)
end

UINOBUAccelerateItem.AddOne = function(self)
  -- function num : 0_8
  if self.itemNum < self.selectedNum + 1 or self.addableTime <= 0 then
    return 
  end
  self.selectedNum = self.selectedNum + 1
  self:UpdateSelectedNum()
  self:PlayRing()
end

UINOBUAccelerateItem.PressAdd = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local pressedTime = (((self.baseItem).ui).btn_Root):GetPressedTime()
  local addNum = (math.ceil)(pressedTime * pressedTime / 10)
  do
    if self.itemNum <= self.selectedNum + addNum or self.addableTime < addNum * self.time then
      local newAddNum = (math.min)(self.itemNum - self.selectedNum, (math.ceil)(self.addableTime / self.time))
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

UINOBUAccelerateItem.MinusOne = function(self)
  -- function num : 0_10
  if self.selectedNum - 1 < 0 then
    return 
  end
  self.selectedNum = self.selectedNum - 1
  self:UpdateSelectedNum()
end

UINOBUAccelerateItem.PressMinus = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local pressedTime = ((self.ui).btn_Reduce):GetPressedTime()
  local minusNum = (math.ceil)(pressedTime * pressedTime / 10)
  if self.selectedNum - minusNum <= 0 then
    self.selectedNum = 0
  else
    self.selectedNum = self.selectedNum - minusNum
  end
  self:UpdateSelectedNum()
end

UINOBUAccelerateItem.CleanAll = function(self, notCal)
  -- function num : 0_12
  self.selectedNum = 0
  self:UpdateSelectedNum(nil, notCal)
end

UINOBUAccelerateItem.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  if self.fillTween ~= nil then
    (self.fillTween):Kill(true)
    self.fillTween = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINOBUAccelerateItem

