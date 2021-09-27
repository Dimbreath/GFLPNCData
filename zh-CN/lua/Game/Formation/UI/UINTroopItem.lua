local UINTroopItem = class("UINTroopItem", UIBaseNode)
local base = UIBaseNode
UINTroopItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_root, self, self.OnClickSeleteTroop)
  self._isCalcutedPower = false
end

UINTroopItem.InitTroopItem = function(self, fmtId, selectEvent, idOffset)
  -- function num : 0_1 , upvalues : _ENV
  self.id = fmtId
  self.idOffset = idOffset
  self.selectEvent = selectEvent
  local formationData = (PlayerDataCenter.formationDic)[self.id]
  if formationData == nil then
    self:RefreshTroopName()
  else
    self:RefreshTroopName(formationData.name)
  end
end

UINTroopItem.RefreshTroopName = function(self, name)
  -- function num : 0_2 , upvalues : _ENV
  if (string.IsNullOrEmpty)(name) then
    ((self.ui).tex_TeamName):SetIndex(0, tostring(self.id - self.idOffset))
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_TeamName).text).text = name
  end
end

UINTroopItem.OnClickSeleteTroop = function(self)
  -- function num : 0_3
  if self.selectEvent ~= nil then
    (self.selectEvent)(self.id)
  end
end

UINTroopItem.RefreshPower = function(self, ftpower, benchPower)
  -- function num : 0_4 , upvalues : _ENV
  local benchPow = benchPower == nil and 0 or benchPower
  self._isCalcutedPower = true
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_MainTP).text = tostring(ftpower)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_BenchTP).text = tostring(benchPow)
end

UINTroopItem.IsCalcutedPower = function(self)
  -- function num : 0_5
  return self._isCalcutedPower
end

UINTroopItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINTroopItem

