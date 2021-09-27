local UINBattlePassBuyLevel = class("UINBattlePassBuyLevel", UIBaseNode)
local base = UINBattlePassBuyLevel
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINBattlePassBuyLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBtnBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sub, self, self.OnBtnSubClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnBtnAddClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Max, self, self.OnBtnMaxClicked)
  ;
  ((self.ui).baseItem):SetActive(false)
  self.baseRewardPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).baseItem)
end

UINBattlePassBuyLevel.InitPassBuyLevelUI = function(self, passInfo)
  -- function num : 0_1
  self.levelup = 0
  self.passInfo = passInfo
  self:UpdatePassLevelCount(1)
end

UINBattlePassBuyLevel.UpdatePassLevelCount = function(self, levelup)
  -- function num : 0_2 , upvalues : _ENV
  if self.levelup == levelup then
    return 
  end
  self.levelup = levelup
  local id = (self.passInfo).id
  local curlevel = (self.passInfo).level
  local nextlevel = curlevel + self.levelup
  ;
  ((self.ui).tex_CurLevel):SetIndex(0, tostring(curlevel))
  ;
  ((self.ui).tex_NextLevel):SetIndex(0, tostring(nextlevel))
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_SelCount).text = tostring(self.levelup)
  local passCfg = (self.passInfo).passCfg
  local itemCfg = (ConfigData.item)[passCfg.price_id]
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_money).text = tostring(passCfg.price_num * self.levelup)
  local item_ids, item_nums = (self.passInfo):GetPassLevelReward(curlevel + 1, nextlevel, true)
  ;
  (self.baseRewardPool):HideAll()
  for index,itemId in pairs(item_ids) do
    local itemCount = item_nums[index]
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("item cfg is null,id:" .. tostring(itemId))
    end
    local baseItem = (self.baseRewardPool):GetOne()
    baseItem:InitItemWithCount(itemCfg, itemCount)
  end
end

UINBattlePassBuyLevel.OnBtnSubClicked = function(self)
  -- function num : 0_3
  if self.levelup == 1 then
    return 
  end
  self:UpdatePassLevelCount(self.levelup - 1)
end

UINBattlePassBuyLevel.OnBtnAddClicked = function(self)
  -- function num : 0_4
  self:UpdatePassLevelCount(self.levelup + 1)
end

UINBattlePassBuyLevel.OnBtnMaxClicked = function(self)
  -- function num : 0_5
  if (self.passInfo):IsPassFullLevel() then
    return 
  end
  self:UpdatePassLevelCount((self.passInfo).maxlevel - (self.passInfo).level)
end

UINBattlePassBuyLevel.OnBtnBuyClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local passCfg = (self.passInfo).passCfg
  local haveCount = PlayerDataCenter:GetItemCount(passCfg.price_id)
  if haveCount < passCfg.price_num * self.levelup then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(25))
    return 
  end
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:BuyBattlePassExp((self.passInfo).id, self.levelup, function()
    -- function num : 0_6_0 , upvalues : self
    self:Hide()
  end
)
end

UINBattlePassBuyLevel.OnBtnCloseClicked = function(self)
  -- function num : 0_7
  self:Hide()
end

UINBattlePassBuyLevel.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattlePassBuyLevel

