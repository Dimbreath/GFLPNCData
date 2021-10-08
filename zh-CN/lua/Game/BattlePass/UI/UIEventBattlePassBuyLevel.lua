local UIEventBattlePassBuyLevel = class("UIEventBattlePassBuyLevel", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UIEventBattlePassBuyLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnBtnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnBtnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBtnBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Sub, self, self.OnBtnSubClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnBtnAddClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Max, self, self.OnBtnMaxClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Least, self, self.OnBtnMinClicked)
  ;
  (UIUtil.SetTopStatus)(self, self.OnReturnClick, {ConstGlobalItem.PaidItem, ConstGlobalItem.PaidSubItem}, nil, nil)
  ;
  (UIUtil.SetCurButtonGroupActive)(false)
  ;
  ((self.ui).baseItem):SetActive(false)
  self.baseRewardPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).baseItem)
end

UIEventBattlePassBuyLevel.InitPassBuyLevelUI = function(self, passInfo)
  -- function num : 0_1
  self.levelup = 0
  self.passInfo = passInfo
  self:UpdatePassLevelCount(1)
end

UIEventBattlePassBuyLevel.UpdatePassLevelCount = function(self, levelup)
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
  local item_ids, item_nums = (self.passInfo):GetPassLevelReward(curlevel + 1, nextlevel, true, (self.passInfo).unlockSenior)
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

UIEventBattlePassBuyLevel.OnBtnSubClicked = function(self)
  -- function num : 0_3
  if self.levelup == 1 then
    return 
  end
  self:UpdatePassLevelCount(self.levelup - 1)
end

UIEventBattlePassBuyLevel.OnBtnAddClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.passInfo).maxlevel - (self.passInfo).level <= self.levelup then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(327))
    return 
  end
  self:UpdatePassLevelCount(self.levelup + 1)
end

UIEventBattlePassBuyLevel.OnBtnMaxClicked = function(self)
  -- function num : 0_5
  if (self.passInfo):IsPassFullLevel() then
    return 
  end
  self:UpdatePassLevelCount((self.passInfo).maxlevel - (self.passInfo).level)
end

UIEventBattlePassBuyLevel.OnBtnMinClicked = function(self)
  -- function num : 0_6
  if self.levelup == 1 then
    return 
  end
  self:UpdatePassLevelCount(1)
end

UIEventBattlePassBuyLevel.OnBtnBuyClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if (self.passInfo):IsPassFullLevel() then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(325))
    return 
  end
  local passCfg = (self.passInfo).passCfg
  local haveCount = PlayerDataCenter:GetItemCount(passCfg.price_id)
  local costCount = passCfg.price_num * self.levelup
  local butFunc = function()
    -- function num : 0_7_0 , upvalues : _ENV, self
    local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
    battlepassCtrl:BuyBattlePassExp((self.passInfo).id, self.levelup, function()
      -- function num : 0_7_0_0 , upvalues : self
      self:OnBtnCloseClicked()
    end
)
  end

  do
    if haveCount < costCount then
      local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
      if not payCtrl:TryConvertPayItem(passCfg.price_id, costCount - haveCount, nil, nil, butFunc, true) then
        ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(25))
      end
      return 
    end
    butFunc()
  end
end

UIEventBattlePassBuyLevel.OnBtnCloseClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIEventBattlePassBuyLevel.OnReturnClick = function(self)
  -- function num : 0_9
  self:Delete()
end

UIEventBattlePassBuyLevel.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UIEventBattlePassBuyLevel

