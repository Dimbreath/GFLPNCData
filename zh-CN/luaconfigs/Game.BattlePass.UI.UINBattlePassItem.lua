-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBattlePassItem = class("UINBattlePassItem", UIBaseNode)
local base = UIBaseNode
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UINBaseItemWithLock = require("Game.CommonUI.Item.UINBaseItemWithLock")
UINBattlePassItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Base, self, self.OnBtnPassBaseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Advance, self, self.OnBtnPassSeniorClicked)
end

UINBattlePassItem.InitPassItemUI = function(self, baseItemPrefab, passLevelCfg, passInfo, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.passLevelCfg = passLevelCfg
  self.level = passLevelCfg.level
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = tostring(passLevelCfg.level)
  self:__InitPassItemUI(baseItemPrefab, passLevelCfg, passInfo)
end

UINBattlePassItem.__InitPassItemUI = function(self, baseItemPrefab, passLevelCfg, passInfo)
  -- function num : 0_2 , upvalues : _ENV
  self.passInfo = passInfo
  self.baseItemList = {}
  self.seniorItemList = {}
  local basepacked, baselocked, seniorpacked, seniorlocked = self:__GetRewardPackLockState(passInfo)
  self:__UpdatePickState(basepacked, baselocked, seniorpacked, seniorlocked)
  for index,itemId in pairs(passLevelCfg.base_item_ids) do
    local itemCount = (passLevelCfg.base_item_nums)[index]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self:__CreatePassRewardItem(baseItemPrefab, ((self.ui).btn_Base).transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, basepacked, baselocked)
      ;
      (table.insert)(self.baseItemList, baseItem)
    end
  end
  for index,itemId in pairs(passLevelCfg.senior_item_ids) do
    local itemCount = (passLevelCfg.senior_item_nums)[index]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    else
      local baseItem = self:__CreatePassRewardItem(baseItemPrefab, ((self.ui).btn_Advance).transform)
      baseItem:InitItemWithLock(itemCfg, itemCount, nil, seniorpacked, seniorlocked)
      ;
      (table.insert)(self.seniorItemList, baseItem)
    end
  end
end

UINBattlePassItem.__GetRewardPackLockState = function(self, passInfo)
  -- function num : 0_3
  local unlockSenior = passInfo.unlockSenior
  local basepacked = false
  local takenReward = (passInfo.taken)[self.level]
  if takenReward ~= nil and takenReward.base then
    basepacked = true
  end
  local baselocked = false
  if passInfo.level < self.level then
    baselocked = true
  end
  local seniorpacked = false
  local takenReward = (passInfo.taken)[self.level]
  if takenReward ~= nil and takenReward.senior then
    seniorpacked = true
  end
  local seniorlocked = false
  if not unlockSenior or passInfo.level < self.level then
    seniorlocked = true
  end
  return basepacked, baselocked, seniorpacked, seniorlocked
end

UINBattlePassItem.__UpdatePickState = function(self, basepacked, baselocked, seniorpacked, seniorlocked)
  -- function num : 0_4 , upvalues : BattlePassEnum, _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  if not basepacked and not baselocked then
    ((self.ui).img_Base).color = BattlePassEnum.pickColor
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Base).color = Color.white
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  if not seniorpacked and not seniorlocked then
    ((self.ui).img_Advance).color = BattlePassEnum.pickColor
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Advance).color = Color.white
  end
  ;
  ((self.ui).obj_BaseBlack):SetActive(basepacked)
  ;
  ((self.ui).obj_SeniorBlack):SetActive(seniorpacked)
end

UINBattlePassItem.__CreatePassRewardItem = function(self, baseItemPrefab, parent)
  -- function num : 0_5 , upvalues : UINBaseItemWithLock, _ENV
  local baseItemObj = baseItemPrefab:Instantiate()
  baseItemObj:SetActive(true)
  local baseItem = (UINBaseItemWithLock.New)()
  baseItem:Init(baseItemObj)
  ;
  (baseItem.transform):SetParent(parent)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (baseItem.transform).localPosition = Vector3.zero
  return baseItem
end

UINBattlePassItem.UpdatePassItemUI = function(self, passInfo)
  -- function num : 0_6 , upvalues : _ENV
  self.passInfo = passInfo
  local basepacked, baselocked, seniorpacked, seniorlocked = self:__GetRewardPackLockState(passInfo)
  self:__UpdatePickState(basepacked, baselocked, seniorpacked, seniorlocked)
  for _,baseItem in pairs(self.baseItemList) do
    baseItem:SetPickedUIActive(basepacked)
    baseItem:SetLockUIActive(baselocked)
  end
  for _,baseItem in pairs(self.seniorItemList) do
    baseItem:SetPickedUIActive(seniorpacked)
    baseItem:SetLockUIActive(seniorlocked)
  end
end

UINBattlePassItem.OnBtnPassBaseClicked = function(self)
  -- function num : 0_7
  if self.clickEvent == nil then
    return 
  end
  local basepacked, baselocked, seniorpacked, seniorlocked = self:__GetRewardPackLockState(self.passInfo)
  if not basepacked and not baselocked then
    (self.clickEvent)(self.level, false)
  end
end

UINBattlePassItem.OnBtnPassSeniorClicked = function(self)
  -- function num : 0_8
  if self.clickEvent == nil then
    return 
  end
  local basepacked, baselocked, seniorpacked, seniorlocked = self:__GetRewardPackLockState(self.passInfo)
  if not seniorpacked and not seniorlocked then
    (self.clickEvent)(self.level, true)
  end
end

UINBattlePassItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattlePassItem

