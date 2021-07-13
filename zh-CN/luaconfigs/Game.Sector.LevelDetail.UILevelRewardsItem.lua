-- params : ...
-- function num : 0 , upvalues : _ENV
local UILevelRewardsItem = class("UILevelRewardsItem", UIBaseNode)
local base = UIBaseNode
UILevelRewardsItem.Create = function(gameObject)
  -- function num : 0_0 , upvalues : UILevelRewardsItem
  local node = (UILevelRewardsItem.New)()
  node:Init(gameObject)
  return node
end

UILevelRewardsItem.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.OnClickEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  if not IsNull((self.ui).rootBtn) then
    (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.__OnClickRootBtn)
  end
end

UILevelRewardsItem.InitRewardsItem = function(self, itemCfg, count)
  -- function num : 0_2 , upvalues : _ENV
  self.itemCfg = itemCfg
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  if count ~= nil then
    ((self.ui).count).text = tostring(count)
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).count).text = ""
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  if not IsNull((self.ui).name) then
    ((self.ui).name).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  end
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).icon).sprite = CRH:GetSprite(itemCfg.icon)
  ;
  (self.transform):SetAsLastSibling()
  self:Show()
end

UILevelRewardsItem.__OnClickRootBtn = function(self)
  -- function num : 0_3
  if self.OnClickEvent ~= nil then
    (self.OnClickEvent)(self)
  end
end

UILevelRewardsItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UILevelRewardsItem

