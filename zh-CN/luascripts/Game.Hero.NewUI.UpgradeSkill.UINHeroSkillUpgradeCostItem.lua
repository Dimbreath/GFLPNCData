-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroSkillUpgradeCostItem = class("UINHeroSkillUpgradeCostItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINHeroSkillUpgradeCostItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.extrBaseItem = (UINBaseItem.New)()
  ;
  (self.extrBaseItem):Init((self.ui).obj_uINBaseItem)
end

UINHeroSkillUpgradeCostItem.InitCostItem = function(self, itemId, num)
  -- function num : 0_1 , upvalues : _ENV
  local totalExtrItemNum = PlayerDataCenter:GetItemCount(itemId)
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    error("extr itemCfg error id=" .. tostring(itemId))
  else
    ;
    (self.extrBaseItem):InitBaseItem(itemCfg)
  end
  if num <= totalExtrItemNum then
    ((self.ui).tex_ExtrCount):SetIndex(0, tostring(num), tostring(totalExtrItemNum))
  else
    ;
    ((self.ui).tex_ExtrCount):SetIndex(2, tostring(num), tostring(totalExtrItemNum))
  end
end

UINHeroSkillUpgradeCostItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroSkillUpgradeCostItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroSkillUpgradeCostItem = class("UINHeroSkillUpgradeCostItem",
                                          UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINHeroSkillUpgradeCostItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINBaseItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.extrBaseItem = (UINBaseItem.New)();
    (self.extrBaseItem):Init((self.ui).obj_uINBaseItem)
end

UINHeroSkillUpgradeCostItem.InitCostItem =
    function(self, itemId, num)
        -- function num : 0_1 , upvalues : _ENV
        local totalExtrItemNum = PlayerDataCenter:GetItemCount(itemId)
        local itemCfg = (ConfigData.item)[itemId]
        if itemCfg == nil then
            error("extr itemCfg error id=" .. tostring(itemId))
        else

            (self.extrBaseItem):InitBaseItem(itemCfg)
        end
        if num <= totalExtrItemNum then
            ((self.ui).tex_ExtrCount):SetIndex(0, tostring(num),
                                               tostring(totalExtrItemNum))
        else

            ((self.ui).tex_ExtrCount):SetIndex(2, tostring(num),
                                               tostring(totalExtrItemNum))
        end
    end

UINHeroSkillUpgradeCostItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroSkillUpgradeCostItem

