local UINBattleDungeonAutoStart = class("UINBattleDungeonAutoStart", UIBaseNode)
local base = UIBaseNode
UINBattleDungeonAutoStart.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Battle, self, self.OnClickConfirm)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).slider, self, self.OnValueTimesChange)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickTimesAdd)
  ;
  (((self.ui).btn_Add).onPress):AddListener(BindCallback(self, self.OnClickTimesAdd))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sub, self, self.OnClickTimesReduce)
  ;
  (((self.ui).btn_Sub).onPress):AddListener(BindCallback(self, self.OnClickTimesReduce))
  self.__OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
end

UINBattleDungeonAutoStart.InitAutoStart = function(self, dungeonStageCfg, callback)
  -- function num : 0_1
  self.dungeonStageCfg = dungeonStageCfg
  self.callback = callback
  self:RefreshData()
  self:RefreshSlider()
end

UINBattleDungeonAutoStart.RefreshData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.sKeyCount = PlayerDataCenter:GetItemCount(ConstGlobalItem.SKey)
  local index = (table.indexof)((self.dungeonStageCfg).cost_itemIds, ConstGlobalItem.SKey)
  self.singleCost = index > 0 and ((self.dungeonStageCfg).cost_itemNums)[index] or 0
  if self.singleCost > 0 then
    self.maxTimes = (math.floor)(self.sKeyCount / self.singleCost)
    if not self.curTimes then
      self.curTimes = self.maxTimes
      if self.curTimes > self.maxTimes or not self.curTimes then
        self.curTimes = self.maxTimes
      end
    end
  end
end

UINBattleDungeonAutoStart.RefreshSlider = function(self)
  -- function num : 0_3
  if self.maxTimes or 0 < 1 then
    ((self.ui).silderNode):SetActive(false)
    self:RefreshAutoStartUI()
    return 
  end
  local valueChange = false
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.ui).slider).maxValue ~= self.maxTimes then
    ((self.ui).slider).maxValue = self.maxTimes
  end
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.ui).slider).minValue ~= 1 then
    ((self.ui).slider).minValue = 1
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  if ((self.ui).slider).value ~= self.curTimes then
    ((self.ui).slider).value = self.curTimes
    valueChange = true
  end
  if not valueChange then
    self:RefreshAutoStartUI()
  end
end

UINBattleDungeonAutoStart.RefreshAutoStartUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_BattleTimes).text = tostring((math.floor)(self.curTimes))
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Before).text = tostring(self.sKeyCount)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_After).text = tostring((math.floor)(self.sKeyCount - self.curTimes * self.singleCost))
end

UINBattleDungeonAutoStart.OnItemRefresh = function(self, itemUpdate)
  -- function num : 0_5 , upvalues : _ENV
  if itemUpdate[ConstGlobalItem.SKey] == nil then
    return 
  end
  self:RefreshData()
  self:RefreshSlider()
end

UINBattleDungeonAutoStart.OnClickTimesAdd = function(self)
  -- function num : 0_6
  if self.maxTimes <= self.curTimes then
    return 
  end
  self.curTimes = self.curTimes + 1
  self:RefreshSlider()
end

UINBattleDungeonAutoStart.OnClickTimesReduce = function(self)
  -- function num : 0_7
  if self.curTimes <= 1 then
    return 
  end
  self.curTimes = self.curTimes - 1
  self:RefreshSlider()
end

UINBattleDungeonAutoStart.OnValueTimesChange = function(self, value)
  -- function num : 0_8 , upvalues : _ENV
  self.curTimes = (math.floor)(value)
  self:RefreshAutoStartUI()
end

UINBattleDungeonAutoStart.OnClickConfirm = function(self)
  -- function num : 0_9
  if self.callback == nil then
    return 
  end
  ;
  (self.callback)(self.curTimes)
end

UINBattleDungeonAutoStart.Hide = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemRefresh)
  ;
  (base.Hide)(self)
end

return UINBattleDungeonAutoStart

