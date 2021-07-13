-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSkadaTeamItem = class("UINSkadaTeamItem", UIBaseNode)
local base = UIBaseNode
local SkadaEnum = require("Game.BattleResult.SkadaSystem.SkadaEnum")
local UINRoleHeadItem = require("Game.CommonUI.Hero.UINRoleHeadItem")
local UINSkadaValueItem = require("Game.BattleResult.SkadaSystem.UINSkadaValueItem")
UINSkadaTeamItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__OnClickRoleHead = BindCallback(self, self.OnClickRoleHead)
  ;
  ((self.ui).skadaValueItem):SetActive(false)
end

UINSkadaTeamItem.InitSkadaItem = function(self, resLoader, clickCallback)
  -- function num : 0_1 , upvalues : UINRoleHeadItem, SkadaEnum, UINSkadaValueItem
  if self.__init then
    return 
  end
  self.__init = true
  self.resLoader = resLoader
  self.OnClickRoleHeadEvent = clickCallback
  self.roleHeadItem = (UINRoleHeadItem.New)()
  ;
  (self.roleHeadItem):Init((self.ui).roleHeadItem)
  self.valueItems = {}
  for id = 1, SkadaEnum.MaxSkadaTypeNum do
    local go = ((self.ui).skadaValueItem):Instantiate()
    go:SetActive(true)
    local valueItem = (UINSkadaValueItem.New)()
    valueItem:Init(go)
    valueItem:InitSkadaValueItem(self:__GetValueItemColor(id))
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.valueItems)[id] = valueItem
  end
end

UINSkadaTeamItem.RefreshSkadaItem = function(self, roleIndex, roleSkada, skadaType, belongPlayer)
  -- function num : 0_2 , upvalues : _ENV
  self.roleIndex = roleIndex
  self.roleSkada = roleSkada
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  if roleSkada.isCommander then
    ((self.ui).tex_HeroName).text = ConfigData:GetTipContent(TipContent.CommanderDPSName)
    ;
    (self.roleHeadItem):InitCommanderHeadItem(self.resLoader, self.__OnClickRoleHead)
  else
    local dynRole = (roleSkada.role).character
    ;
    (self.roleHeadItem):InitRoleHeadItem(dynRole, self.resLoader, self.__OnClickRoleHead, belongPlayer)
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_HeroName).text = dynRole:GetName()
  end
  do
    for k,v in ipairs(self.valueItems) do
      local detail = (roleSkada.detail)[k]
      local alpha = 1
      if k ~= skadaType then
        alpha = (self.ui).normal_alpha
      end
      v:SetSkadaValue(detail.proportion, detail.value, alpha)
      if skadaType ~= k then
        (v.transform):SetAsLastSibling()
      end
    end
  end
end

UINSkadaTeamItem.__GetValueItemColor = function(self, skadaType)
  -- function num : 0_3 , upvalues : SkadaEnum
  if skadaType == (SkadaEnum.eSkadaType).Damage then
    return (self.ui).damageColor
  else
    if skadaType == (SkadaEnum.eSkadaType).TakeDamage then
      return (self.ui).takeDamageColor
    else
      if skadaType == (SkadaEnum.eSkadaType).Heal then
        return (self.ui).healColor
      end
    end
  end
end

UINSkadaTeamItem.OnClickRoleHead = function(self, roleData, isCommander)
  -- function num : 0_4
  if self.OnClickRoleHeadEvent ~= nil then
    (self.OnClickRoleHeadEvent)(self.roleSkada, self.roleIndex)
  end
end

return UINSkadaTeamItem

