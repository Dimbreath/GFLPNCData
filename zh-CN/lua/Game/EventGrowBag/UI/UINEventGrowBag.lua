local UINEventGrowBag = class("UINEventGrowBag", UIBaseNode)
local base = UIBaseNode
local UINEventGrowBagReward = require("Game.EventGrowBag.UI.UINEventGrowBagReward")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
UINEventGrowBag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEventGrowBagReward
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.rewardPool = (UIItemPool.New)(UINEventGrowBagReward, (self.ui).rewardItem)
  ;
  (((self.ui).rewardItem).gameObject):SetActive(false)
end

UINEventGrowBag.InitItem = function(self, cfg, data, buyCallback)
  -- function num : 0_1
  self.cfg = cfg
  self.data = data
  self.buyCallback = buyCallback
  self:Refresh()
end

UINEventGrowBag.Refresh = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self.rewardPool):HideAll()
  local rewardState = ((self.data).taken)[(self.cfg).level]
  local isNormalLocked = (PlayerDataCenter.playerLevel).level < (self.cfg).level
  local isNormalGetReward = (rewardState ~= nil and rewardState.base)
  local itemId = ((self.cfg).base_item_ids)[1]
  local num = ((self.cfg).base_item_nums)[1]
  do
    if itemId ~= nil and num ~= nil then
      local item = (self.rewardPool):GetOne(true)
      item:InitItem(itemId, num, isNormalGetReward, isNormalLocked)
      ;
      (item.transform):SetParent(((self.ui).fixedItemList).transform)
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (item.transform).localPosition = Vector3(0, 0, 0)
    end
    if not isNormalLocked then
      local isSeniorLocked = not (self.data).unlockSenior
    end
    local isSeniorGetReward = (rewardState ~= nil and rewardState.senior)
    for i,v in ipairs((self.cfg).senior_item_ids) do
      local num = ((self.cfg).senior_item_nums)[i]
      local item = (self.rewardPool):GetOne(true)
      ;
      (item.gameObject):SetActive(true)
      item:InitItem(v, num, isSeniorGetReward, isSeniorLocked)
      ;
      (item.transform):SetParent(((self.ui).seniorItemList).transform)
    end
    local baseCanGet = rewardState ~= nil and not rewardState.base
    local seniorCanGet = (self.data).unlockSenior and (rewardState ~= nil and not rewardState.senior)
    self.isCanGet = baseCanGet or seniorCanGet
    if isNormalLocked then
      self.itemState = -1
    elseif self.isCanGet or not (self.data).unlockSenior then
      self.itemState = 0
    else
      self.itemState = 1
    end
    ;
    ((self.ui).tex_TaskIntro):SetIndex(0, tostring((self.cfg).level))
    local schedule = (PlayerDataCenter.playerLevel).level
    local aim = (self.cfg).level
    if aim < schedule then
      schedule = aim
    end
    local progress = schedule / aim
    if progress >= 1 or not progress then
      progress = 1
    end
    self.barWidth = ((((self.ui).bar).rectTransform).rect).width
    local vec = (((self.ui).img_Fill).rectTransform).sizeDelta
    vec.x = self.barWidth * progress
    -- DECOMPILER ERROR at PC172: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (((self.ui).img_Fill).rectTransform).sizeDelta = vec
    -- DECOMPILER ERROR: 20 unprocessed JMP targets
  end
end

return UINEventGrowBag

