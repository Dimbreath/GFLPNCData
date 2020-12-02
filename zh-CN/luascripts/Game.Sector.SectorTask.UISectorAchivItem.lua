-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorAchivItem = class("UISectorAchivItem", UIBaseNode)
local base = UIBaseNode
local SectorEnum = require("Game.Sector.SectorEnum")
UISectorAchivItem.Create = function(gameObject)
  -- function num : 0_0 , upvalues : UISectorAchivItem
  local node = (UISectorAchivItem.New)()
  node:Init(gameObject)
  return node
end

UISectorAchivItem.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.OnClickEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.__OnClickRoot)
end

UISectorAchivItem.InitSectorAchivItem = function(self, achivCfg)
  -- function num : 0_2 , upvalues : _ENV
  self.achivCfg = achivCfg
  self.id = achivCfg.id
  local starCount = (achivCfg.conditionNums)[1]
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).count).text = tostring(starCount)
end

UISectorAchivItem.UpdateSectorAchivItem = function(self, state)
  -- function num : 0_3 , upvalues : SectorEnum
  self.state = state
  if state == (SectorEnum.eSectorAchivState).Normal then
    ((self.ui).state):SetIndex(0)
    ;
    ((self.ui).icon):SetIndex(0)
  else
    if state == (SectorEnum.eSectorAchivState).Completed then
      ((self.ui).state):SetIndex(1)
      ;
      ((self.ui).icon):SetIndex(1)
    else
      if state == (SectorEnum.eSectorAchivState).Picked then
        ((self.ui).state):SetIndex(2)
        ;
        ((self.ui).icon):SetIndex(2)
      end
    end
  end
end

UISectorAchivItem.__OnClickRoot = function(self)
  -- function num : 0_4
  if self.OnClickEvent ~= nil then
    (self.OnClickEvent)(self.id)
  end
end

UISectorAchivItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UISectorAchivItem

