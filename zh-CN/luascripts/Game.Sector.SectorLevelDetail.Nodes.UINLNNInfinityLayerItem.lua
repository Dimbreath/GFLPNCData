-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLNNInfinityLayerItem = class("UINLNNInfinityLayerItem", UIBaseNode)
local base = UIBaseNode
local UINLNNInfinityRewardItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLNNInfinityRewardItem")
UINLNNInfinityLayerItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLNNInfinityRewardItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  local rewardItem = (UINLNNInfinityRewardItem.New)()
  rewardItem:Init((self.ui).obj_rewardItem)
  self.rewardList = {}
  ;
  (table.insert)(self.rewardList, rewardItem)
  self.passCountList = {}
  ;
  (table.insert)(self.passCountList, (self.ui).obj_img_PassCount)
end

UINLNNInfinityLayerItem.InitNodeInfinityLevel = function(self, LayerData)
  -- function num : 0_1 , upvalues : _ENV
  self.id = LayerData.id
  self.index = LayerData.index
  local endlessLayerCfg = (ConfigData.endless_layer)[self.id]
  if endlessLayerCfg == nil then
    error("can\'t read endlessLayerCfg with id=" .. tostring(self.id))
  end
  self:RefeshPassCount(self.index)
  self:RefeshReward(endlessLayerCfg)
  ;
  ((self.ui).obj_isGetReward):SetActive(LayerData.isPass)
end

UINLNNInfinityLayerItem.RefeshReward = function(self, endlessLayerCfg)
  -- function num : 0_2 , upvalues : _ENV, UINLNNInfinityRewardItem
  for _,item in ipairs(self.rewardList) do
    (item.gameObject):SetActive(false)
  end
  for index,id in ipairs(endlessLayerCfg.reward_itemIds) do
    local num = (endlessLayerCfg.reward_itemNums)[index]
    if (self.rewardList)[index] ~= nil then
      (((self.rewardList)[index]).gameObject):SetActive(true)
    else
      local newGo = ((self.ui).obj_rewardItem):Instantiate()
      local newItem = (UINLNNInfinityRewardItem.New)()
      newItem:Init(newGo)
      ;
      (table.insert)(self.rewardList, newItem)
      ;
      (newItem.gameObject):SetActive(true)
    end
    do
      do
        ;
        ((self.rewardList)[index]):InitReardItem(id, num)
        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

UINLNNInfinityLayerItem.RefeshPassCount = function(self, num)
  -- function num : 0_3 , upvalues : _ENV
  for _,go in ipairs(self.passCountList) do
    go:SetActive(false)
  end
  for i = 1, num do
    if (self.passCountList)[i] ~= nil then
      ((self.passCountList)[i]):SetActive(true)
    else
      local newGo = ((self.ui).obj_img_PassCount):Instantiate()
      ;
      (table.insert)(self.passCountList, newGo)
      newGo:SetActive(true)
    end
  end
end

UINLNNInfinityLayerItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLNNInfinityLayerItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLNNInfinityLayerItem = class("UINLNNInfinityLayerItem", UIBaseNode)
local base = UIBaseNode
local UINLNNInfinityRewardItem = require(
                                     "Game.Sector.SectorLevelDetail.Nodes.UINLNNInfinityRewardItem")
UINLNNInfinityLayerItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINLNNInfinityRewardItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    local rewardItem = (UINLNNInfinityRewardItem.New)()
    rewardItem:Init((self.ui).obj_rewardItem)
    self.rewardList = {};
    (table.insert)(self.rewardList, rewardItem)
    self.passCountList = {};
    (table.insert)(self.passCountList, (self.ui).obj_img_PassCount)
end

UINLNNInfinityLayerItem.InitNodeInfinityLevel =
    function(self, LayerData)
        -- function num : 0_1 , upvalues : _ENV
        self.id = LayerData.id
        self.index = LayerData.index
        local endlessLayerCfg = (ConfigData.endless_layer)[self.id]
        if endlessLayerCfg == nil then
            error("can\'t read endlessLayerCfg with id=" .. tostring(self.id))
        end
        self:RefeshPassCount(self.index)
        self:RefeshReward(endlessLayerCfg);
        ((self.ui).obj_isGetReward):SetActive(LayerData.isPass)
    end

UINLNNInfinityLayerItem.RefeshReward = function(self, endlessLayerCfg)
    -- function num : 0_2 , upvalues : _ENV, UINLNNInfinityRewardItem
    for _, item in ipairs(self.rewardList) do
        (item.gameObject):SetActive(false)
    end
    for index, id in ipairs(endlessLayerCfg.reward_itemIds) do
        local num = (endlessLayerCfg.reward_itemNums)[index]
        if (self.rewardList)[index] ~= nil then
            (((self.rewardList)[index]).gameObject):SetActive(true)
        else
            local newGo = ((self.ui).obj_rewardItem):Instantiate()
            local newItem = (UINLNNInfinityRewardItem.New)()
            newItem:Init(newGo);
            (table.insert)(self.rewardList, newItem);
            (newItem.gameObject):SetActive(true)
        end
        do
            do

                ((self.rewardList)[index]):InitReardItem(id, num)
                -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
end

UINLNNInfinityLayerItem.RefeshPassCount =
    function(self, num)
        -- function num : 0_3 , upvalues : _ENV
        for _, go in ipairs(self.passCountList) do go:SetActive(false) end
        for i = 1, num do
            if (self.passCountList)[i] ~= nil then
                ((self.passCountList)[i]):SetActive(true)
            else
                local newGo = ((self.ui).obj_img_PassCount):Instantiate();
                (table.insert)(self.passCountList, newGo)
                newGo:SetActive(true)
            end
        end
    end

UINLNNInfinityLayerItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINLNNInfinityLayerItem

