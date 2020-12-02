-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFosterUpgradeNode = class("UINFosterUpgradeNode", UIBaseNode)
local base = UIBaseNode
local UINFosterUpgradeCostItem = require("Game.Friendship.Foster.UINFosterUpgradeCostItem")
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")
UINFosterUpgradeNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFosterUpgradeCostItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friendship)
  self.CostItemPool = (UIItemPool.New)(UINFosterUpgradeCostItem, (self.ui).obj_materialItem)
  ;
  ((self.ui).obj_materialItem):SetActive(false)
end

UINFosterUpgradeNode.InitUpgradekNode = function(self, heroId, heroLevel, friendShipLevel)
  -- function num : 0_1
  self.heroId = heroId
  self.friendShipLevel = friendShipLevel or 1
  self.heroLevel = heroLevel or 1
end

UINFosterUpgradeNode.RefreshAndShowInfo = function(self, fosterCfg, nowlevel)
  -- function num : 0_2 , upvalues : _ENV
  local cfg = fosterCfg[nowlevel + 1]
  local requireFlevel = cfg.friendship_level
  local requireHlevel = cfg.hero_level
  ;
  ((self.ui).tex_Condition1):SetIndex(0, tostring(requireFlevel))
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

  if requireFlevel <= self.friendShipLevel then
    ((self.ui).img_conditionItem1).color = (self.ui).color_fullfill
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_conditionItem1).color = (self.ui).color_notFullfill
  end
  ;
  ((self.ui).tex_Condition2):SetIndex(1, tostring(requireHlevel))
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

  if requireHlevel <= self.heroLevel then
    ((self.ui).img_conditionItem2).color = (self.ui).color_fullfill
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_conditionItem2).color = (self.ui).color_notFullfill
  end
  local allItemList = {}
  ;
  (self.CostItemPool):HideAll()
  for index,id in ipairs(cfg.deduct_itemIds) do
    if id ~= ItemIdOfG then
      local item = (self.CostItemPool):GetOne(true)
      item:InitCostItem(id, (cfg.deduct_itemNums)[index])
      ;
      (table.insert)(allItemList, item)
    end
  end
  local gindex = (table.indexof)(cfg.deduct_itemIds, ItemIdOfG)
  local requireGNum = (cfg.deduct_itemNums)[gindex] or 0
  local totalG = PlayerDataCenter:GetItemCount(ItemIdOfG)
  ;
  ((self.ui).tex_GName):SetIndex(0, (LanguageUtil.GetLocaleText)(((ConfigData.item)[ItemIdOfG]).name))
  if totalG < requireGNum then
    ((self.ui).tex_GConsumeNum):SetIndex(1, tostring(requireGNum))
  else
    ;
    ((self.ui).tex_GConsumeNum):SetIndex(0, tostring(requireGNum))
  end
  ;
  (((self.ui).btn_Confirm).onClick):RemoveAllListeners()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, function()
    -- function num : 0_2_0 , upvalues : self, requireFlevel, requireHlevel, allItemList, totalG, requireGNum, cfg, _ENV
    if requireFlevel <= self.friendShipLevel and requireHlevel <= self.heroLevel and self:__IsHaveEnoughItem(allItemList) and requireGNum <= totalG then
      (self.networkCtrl):CS_INTIMACY_UpgradeLine(self.heroId, cfg.id)
    else
      print("条件不满足")
    end
  end
)
  -- DECOMPILER ERROR at PC150: Confused about usage of register: R10 in 'UnsetPending'

  if requireFlevel <= self.friendShipLevel and requireHlevel <= self.heroLevel and self:__IsHaveEnoughItem(allItemList) and requireGNum <= totalG then
    ((self.ui).img_btn_Confirm).color = (self.ui).color_canClick
  else
    -- DECOMPILER ERROR at PC156: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self.ui).img_btn_Confirm).color = (self.ui).color_canNotClick
  end
end

UINFosterUpgradeNode.__IsHaveEnoughItem = function(self, allItemList)
  -- function num : 0_3 , upvalues : _ENV
  for index,item in ipairs(allItemList) do
    if item:IsHaveEnoughItem() == false then
      return false
    end
  end
  return true
end

UINFosterUpgradeNode.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINFosterUpgradeNode

