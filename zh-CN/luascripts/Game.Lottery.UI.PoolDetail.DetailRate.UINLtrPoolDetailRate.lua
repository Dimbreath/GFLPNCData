-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolDetailRate = class("UINLtrPoolDetailRate", UIBaseNode)
local base = UIBaseNode
local UILtrPoolDetailRateReward = require("Game.Lottery.UI.PoolDetail.DetailRate.UILtrPoolDetailRateReward")
UINLtrPoolDetailRate.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.rewardItemDic = {}
end

UINLtrPoolDetailRate.InitLtrPoolDetailRate = function(self, rewardDataList)
  -- function num : 0_1
  self.rewardDataList = rewardDataList
  self:_RefillScrollRect()
end

UINLtrPoolDetailRate._RefillScrollRect = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).scrollRect).totalCount = #self.rewardDataList
  ;
  ((self.ui).scrollRect):RefillCells()
end

UINLtrPoolDetailRate.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UILtrPoolDetailRateReward
  local item = (UILtrPoolDetailRateReward.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.rewardItemDic)[go] = item
end

UINLtrPoolDetailRate.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local item = (self.rewardItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local rewardData = (self.rewardDataList)[index + 1]
  if rewardData == nil then
    error("Can\'t find rewardData by index, index = " .. tonumber(index))
  end
  item:InitLtrPoolDetailRateReward(rewardData)
end

UINLtrPoolDetailRate.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolDetailRate

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolDetailRate = class("UINLtrPoolDetailRate", UIBaseNode)
local base = UIBaseNode
local UILtrPoolDetailRateReward = require(
                                      "Game.Lottery.UI.PoolDetail.DetailRate.UILtrPoolDetailRateReward")
UINLtrPoolDetailRate.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui) -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).scrollRect).onInstantiateItem =
        BindCallback(self, self.__OnNewItem) -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).scrollRect).onChangeItem =
        BindCallback(self, self.__OnChangeItem)
    self.rewardItemDic = {}
end

UINLtrPoolDetailRate.InitLtrPoolDetailRate =
    function(self, rewardDataList)
        -- function num : 0_1
        self.rewardDataList = rewardDataList
        self:_RefillScrollRect()
    end

UINLtrPoolDetailRate._RefillScrollRect =
    function(self)
        -- function num : 0_2
        -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

        ((self.ui).scrollRect).totalCount = #self.rewardDataList;
        ((self.ui).scrollRect):RefillCells()
    end

UINLtrPoolDetailRate.__OnNewItem = function(self, go)
    -- function num : 0_3 , upvalues : UILtrPoolDetailRateReward
    local item = (UILtrPoolDetailRateReward.New)()
    item:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.rewardItemDic)[go] = item
end

UINLtrPoolDetailRate.__OnChangeItem = function(self, go, index)
    -- function num : 0_4 , upvalues : _ENV
    local item = (self.rewardItemDic)[go]
    if item == nil then
        error("Can\'t find item by gameObject")
        return
    end
    local rewardData = (self.rewardDataList)[index + 1]
    if rewardData == nil then
        error("Can\'t find rewardData by index, index = " .. tonumber(index))
    end
    item:InitLtrPoolDetailRateReward(rewardData)
end

UINLtrPoolDetailRate.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINLtrPoolDetailRate

