-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventGrowBag = class("UIEventGrowBag", UIBaseWindow)
local base = UIBaseWindow
local UINEventGrowBag = require("Game.EventGrowBag.UI.UINEventGrowBag")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
UIEventGrowBag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEventGrowBag
  ((self.ui).taskItem):SetActive(false)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).AdvanTitleCol = ((self.ui).img_AdvanTitle).color
  self.itemPool = (UIItemPool.New)(UINEventGrowBag, (self.ui).taskItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnClickBuy)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Achieve, self, self.OnBtnAchieveOpen)
  self.__OnDataChangeCallback = BindCallback(self, self.OnDataChange)
  self.__RefreshCallback = BindCallback(self, self.Refresh)
  MsgCenter:AddListener(eMsgEventId.BattlePassChange, self.__OnDataChangeCallback)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__RefreshCallback)
  self.__onRefreshAchievementLevel = BindCallback(self, self.RefreshAchievementLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__onRefreshAchievementLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedRewardLevel, self.__onRefreshAchievementLevel)
end

UIEventGrowBag.InitEventGrow = function(self)
  -- function num : 0_1 , upvalues : _ENV, BattlePassEnum
  local id, def = nil, nil
  for k,v in pairs(ConfigData.battlepass_type) do
    if v.condition == (BattlePassEnum.ConditionType).AchievementLevel then
      id = k
      def = v
      break
    end
  end
  do
    if id == nil then
      return 
    end
    self.info = ((PlayerDataCenter.battlepassData).passInfos)[id]
    local itemId = ((self.info).passCfg).senior_reward_id
    local itemNum = ((self.info).passCfg).senior_reward_num
    local itemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[itemId]).name)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_BuyDesc).text = tostring(itemNum)
    self.levelCfg = (ConfigData.battlepass)[id]
    itemId = ConstGlobalItem.PaidSubItem
    itemNum = 0
    for k,v in pairs(self.levelCfg) do
      for i,v2 in ipairs(v.senior_item_ids) do
        if v2 == itemId then
          itemNum = itemNum + (v.senior_item_nums)[i]
          break
        end
      end
    end
    itemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[itemId]).name)
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_ReturnDesc).text = tostring(itemNum)
    local payCtr = ControllerManager:GetController(ControllerTypeId.Pay, true)
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_Price).text = payCtr:GetPayPriceShow(((self.info).passCfg).senior_price)
    local tableArray = {}
    for k,v in pairs(self.levelCfg) do
      (table.insert)(tableArray, R15_PC105)
    end
    ;
    (table.sort)(tableArray, function(a, b)
    -- function num : 0_1_0
    do return a.level < b.level end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (self.itemPool):HideAll()
    for i = 1, #tableArray do
      local item = (self.itemPool):GetOne(true)
      -- DECOMPILER ERROR at PC127: Overwrote pending register: R15 in 'AssignReg'

      -- DECOMPILER ERROR at PC128: Overwrote pending register: R15 in 'AssignReg'

      ;
      (item.transform):SetParent(R15_PC105)
      -- DECOMPILER ERROR at PC131: Overwrote pending register: R15 in 'AssignReg'

      item:InitItem(R15_PC105, self.info, function()
    -- function num : 0_1_1 , upvalues : self
    self:OnClickBuy()
  end
)
    end
    self.tableArray = tableArray
    self:Refresh()
  end
end

UIEventGrowBag.OnDataChange = function(self, id)
  -- function num : 0_2
  if id == ((self.info).passCfg).id then
    self:Refresh()
  end
end

UIEventGrowBag.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local AccomplishCount = self:GetAccomplishCondition()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_CompleteCount).text = tostring(AccomplishCount) .. "/" .. tostring(#self.tableArray)
  for i,v in ipairs((self.itemPool).listItem) do
    v:Refresh()
  end
  do
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

    if not (self.info).unlockSenior or not (self.ui).color_Buyed then
      ((self.ui).img_Buy).color = (self.ui).color_canBuy
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).btn_Buy).interactable = not (self.info).unlockSenior
      ;
      ((self.ui).obj_canBuy):SetActive(not (self.info).unlockSenior)
      ;
      ((self.ui).obj_dontBuy):SetActive((self.info).unlockSenior)
      self:RefreshAchievementLevel()
      local unlockSenior = (self.info).unlockSenior
      -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

      if not unlockSenior or not (self.ui).AdvanTitleCol then
        ((self.ui).img_AdvanTitle).color = (self.ui).col_AdvanTitle
      end
    end
  end
end

UIEventGrowBag.OnClickBuy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.info).unlockSenior then
    return 
  end
  if not (self.info):IsBattlePassValid() then
    return 
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
  network:CS_BATTLEPASS_Buy(((self.info).passCfg).senior_price)
end

UIEventGrowBag.RefreshAchievementLevel = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local curLevel = (PlayerDataCenter.playerLevel).level
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_AchieveLv).text = "LV." .. tostring(curLevel)
end

UIEventGrowBag.OnBtnAchieveOpen = function(self)
  -- function num : 0_6 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    -- function num : 0_6_0 , upvalues : _ENV
    if win ~= nil then
      win:InitAchievement(nil, false)
      win:SetOnAchievementSystemCloseCallback(function()
      -- function num : 0_6_0_0 , upvalues : _ENV
      UIManager:ShowWindowOnly(UIWindowTypeID.ActivityFrameMain)
    end
)
      UIManager:HideWindow(UIWindowTypeID.ActivityFrameMain)
    end
  end
)
end

UIEventGrowBag.GetAccomplishCondition = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local Accomplish = 0
  for index,cfg in ipairs(self.tableArray) do
    local rewardState = ((self.info).taken)[cfg.level]
    local isNormalLocked = (PlayerDataCenter.playerLevel).level < cfg.level
    local isNormalGetReward = (rewardState ~= nil and rewardState.base)
    if not isNormalLocked then
      local isSeniorLocked = not (self.info).unlockSenior
    end
    local isSeniorGetReward = (rewardState ~= nil and rewardState.senior)
    local baseCanGet = rewardState ~= nil and not rewardState.base
    local seniorCanGet = (self.info).unlockSenior and (rewardState ~= nil and not rewardState.senior)
    self.isCanGet = baseCanGet or seniorCanGet
    if (not isNormalLocked or not self.isCanGet) and not (self.info).unlockSenior then
      do
        Accomplish = Accomplish + 1
        -- DECOMPILER ERROR at PC68: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC68: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  do return Accomplish end
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

UIEventGrowBag.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__OnDataChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__RefreshCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__onRefreshAchievementLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedRewardLevel, self.__onRefreshAchievementLevel)
  ;
  (base.OnDelete)(self)
end

return UIEventGrowBag

