-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEventGrowBag = class("UINEventGrowBag", UIBaseNode)
local base = UIBaseNode
local UINEventGrowBagReward = require("Game.EventGrowBag.UI.UINEventGrowBagReward")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
UINEventGrowBag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEventGrowBagReward
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Get, self, self.OnClickGetReward)
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
    (((self.ui).btn_Get).gameObject):SetActive(self.itemState == 0)
    ;
    ((self.ui).obj_Unfinish):SetActive(self.itemState == -1)
    ;
    ((self.ui).obj_Completed):SetActive(self.itemState == 1)
    if not self.isCanGet or not 0 then
      ((self.ui).tex_Get):SetIndex(self.itemState ~= 0 or 1)
      ;
      ((self.ui).img_SeniorItemList):SetIndex((self.data).unlockSenior and ((self.itemState == 0 or not 0) and 1))
      local oriCol = (((self.ui).img_SeniorItemList).image).color
      local colAlpha = self.itemState == 1 and 0.3 or 1
      -- DECOMPILER ERROR at PC214: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (((self.ui).img_SeniorItemList).image).color = (Color.New)(oriCol.r, oriCol.g, oriCol.b, colAlpha)
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
      -- DECOMPILER ERROR at PC254: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (((self.ui).img_Fill).rectTransform).sizeDelta = vec
      -- DECOMPILER ERROR: 31 unprocessed JMP targets
    end
  end
end

UINEventGrowBag.OnClickGetReward = function(self)
  -- function num : 0_3 , upvalues : _ENV, BattlePassEnum
  if not (self.data):IsBattlePassValid() then
    return 
  end
  if self.itemState == 0 then
    if self.isCanGet then
      local network = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
      local rewardState = ((self.data).taken)[(self.cfg).level]
      local baseCanGet = rewardState ~= nil and not rewardState.base
      local seniorCanGet = (self.data).unlockSenior and (rewardState ~= nil and not rewardState.senior)
      if baseCanGet and seniorCanGet then
        network:CS_BATTLEPASS_Take((self.cfg).id, (self.cfg).level, (BattlePassEnum.TakeWay).BaseAndSenior)
      elseif seniorCanGet then
        network:CS_BATTLEPASS_Take((self.cfg).id, (self.cfg).level, (BattlePassEnum.TakeWay).Senior)
      else
        network:CS_BATTLEPASS_Take((self.cfg).id, (self.cfg).level, (BattlePassEnum.TakeWay).Base)
      end
    elseif self.buyCallback ~= nil then
      (self.buyCallback)()
    end
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

return UINEventGrowBag

