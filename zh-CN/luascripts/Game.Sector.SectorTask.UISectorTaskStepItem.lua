-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTaskStepItem = class("UISectorTaskStepItem", UIBaseNode)
local base = UIBaseNode
local UILevelRewardsItem = require("Game.Sector.LevelDetail.UILevelRewardsItem")
UISectorTaskStepItem.Create = function(gameObject)
  -- function num : 0_0 , upvalues : UISectorTaskStepItem
  local node = (UISectorTaskStepItem.New)()
  node:Init(gameObject)
  return node
end

UISectorTaskStepItem.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.__rewardItems = {}
  self.__rewardItemPool = {}
end

UISectorTaskStepItem.InitTaskStep = function(self, data, stepCfg, stcData)
  -- function num : 0_2 , upvalues : _ENV, UILevelRewardsItem
  self.stepCfg = stepCfg
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).intro).text = (LanguageUtil.GetLocaleText)(stepCfg.intro)
  if data == nil then
    (((self.ui).progress).gameObject):SetActive(false)
  else
    ;
    (((self.ui).progress).gameObject):SetActive(true)
    ;
    ((self.ui).progress):SetIndex(0, tostring((math.min)(data.schedule, data.aim)), tostring(data.aim))
  end
  self:__RecycleItems()
  if stepCfg.step ~= 1 then
    return 
  end
  for i = 1, #stcData.rewardIds do
    local rewardId = (stcData.rewardIds)[i]
    local rewardNum = (stcData.rewardNums)[i]
    local itemCfg = (ConfigData.item)[rewardId]
    local rewardItem = nil
    if #self.__rewardItemPool > 0 then
      rewardItem = (table.remove)(self.__rewardItemPool)
    else
      local go = ((self.ui).rewardItem):Instantiate()
      rewardItem = (UILevelRewardsItem.Create)(go)
    end
    do
      do
        rewardItem:InitRewardsItem(itemCfg, rewardNum)
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.__rewardItems)[rewardId] = rewardItem
        -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

UISectorTaskStepItem.__RecycleItems = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in pairs(self.__rewardItems) do
    v:Hide()
    ;
    (table.insert)(self.__rewardItemPool, v)
  end
  self.__rewardItems = {}
end

UISectorTaskStepItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  for k,v in ipairs(self.__rewardItemPool) do
    v:Delete()
  end
  self.__rewardItemPool = {}
  for k,v in pairs(self.__rewardItems) do
    v:Delete()
  end
  self.__rewardItems = {}
  ;
  (base.OnDelete)(self)
end

return UISectorTaskStepItem

