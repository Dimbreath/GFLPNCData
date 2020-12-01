-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTroopItem = class("UINTroopItem", UIBaseNode)
local base = UIBaseNode
UINTroopItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_root, self, self.OnClickSeleteTroop)
end

UINTroopItem.InitTroopItem = function(self, fmtId, selectEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.id = fmtId
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
    ((self.ui).tex_TeamName):SetIndex(0, tostring(self.id))
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

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

UINTroopItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINTroopItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTroopItem = class("UINTroopItem", UIBaseNode)
local base = UIBaseNode
UINTroopItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_root, self, self.OnClickSeleteTroop)
end

UINTroopItem.InitTroopItem = function(self, fmtId, selectEvent)
    -- function num : 0_1 , upvalues : _ENV
    self.id = fmtId
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
        ((self.ui).tex_TeamName):SetIndex(0, tostring(self.id))
    else
        -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'


        (((self.ui).tex_TeamName).text).text = name
    end
end

UINTroopItem.OnClickSeleteTroop = function(self)
    -- function num : 0_3
    if self.selectEvent ~= nil then (self.selectEvent)(self.id) end
end

UINTroopItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINTroopItem

