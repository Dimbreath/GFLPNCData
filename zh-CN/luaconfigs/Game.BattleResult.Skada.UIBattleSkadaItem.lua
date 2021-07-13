-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattleSkadaItem = class("UIBattleSkadaItem", UIBaseNode)
local base = UIBaseNode
local UIBattleSkadaValueItem = require("Game.BattleResult.Skada.UIBattleSkadaValueItem")
local BattleSkadaEnum = require("Game.BattleResult.Skada.BattleSkadaEnum")
UIBattleSkadaItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HeroPic, self, self.OnClickHeroPic)
  ;
  ((self.ui).valueItem):SetActive(false)
end

UIBattleSkadaItem.InitSkadaItem = function(self, resLoader, clickCallback)
  -- function num : 0_1 , upvalues : _ENV, BattleSkadaEnum, UIBattleSkadaValueItem
  if self.__init then
    return 
  end
  self.__init = true
  self.resLoader = resLoader
  self.OnClickHeroPicEvent = clickCallback
  self.valueItems = {}
  for k,id in pairs(BattleSkadaEnum.eBattleSkadaType) do
    local go = ((self.ui).valueItem):Instantiate()
    go:SetActive(true)
    local valueItem = (UIBattleSkadaValueItem.New)()
    valueItem:Init(go)
    valueItem:InitSkadaValueItem(self:__GetValueItemColor(id))
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.valueItems)[id] = valueItem
  end
end

UIBattleSkadaItem.RefreshSkadaItem = function(self, roleIndex, roleSkada, sortType, belongPlayer)
  -- function num : 0_2 , upvalues : _ENV
  self.roleIndex = roleIndex
  self.roleSkada = roleSkada
  if not belongPlayer or not PathConsts:GetCharacterPicPath(((roleSkada.role).character):GetResPicName()) then
    local path = PathConsts:GetCharacterSmallPicPath(((roleSkada.role).character):GetResPicName())
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_HeroPic).texture = (self.resLoader):LoadABAsset(path)
  local uvRect = ((self.ui).img_HeroPic).uvRect
  if belongPlayer then
    uvRect:Set(0, 0.5, 0.5, 0.5)
  else
    uvRect:Set(0, 0, 1, 1)
  end
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_HeroPic).uvRect = uvRect
  for k,v in ipairs(self.valueItems) do
    local detail = (roleSkada.detail)[k]
    v:SetSkadaValue(detail.proportion, detail.value)
    if sortType ~= k then
      (v.transform):SetAsLastSibling()
    end
  end
end

UIBattleSkadaItem.__GetValueItemColor = function(self, skadaType)
  -- function num : 0_3 , upvalues : BattleSkadaEnum
  if skadaType == (BattleSkadaEnum.eBattleSkadaType).Damage then
    return (self.ui).damageColor
  else
    if skadaType == (BattleSkadaEnum.eBattleSkadaType).TakeDamage then
      return (self.ui).takeDamageColor
    else
      if skadaType == (BattleSkadaEnum.eBattleSkadaType).Heal then
        return (self.ui).healColor
      end
    end
  end
end

UIBattleSkadaItem.OnClickHeroPic = function(self)
  -- function num : 0_4
  if self.OnClickHeroPicEvent ~= nil then
    (self.OnClickHeroPicEvent)(self.roleSkada, self.roleIndex)
  end
end

UIBattleSkadaItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  for k,v in pairs(self.valueItems) do
    v:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIBattleSkadaItem

