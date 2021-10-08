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
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetAll, self, self.OnClickGetAll)
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
  for i,v in ipairs((self.itemPool).listItem) do
    v:Refresh()
  end
  ;
  (((self.ui).btn_Buy).gameObject):SetActive(not (self.info).unlockSenior)
  ;
  ((self.ui).mask):SetActive(not (self.info).unlockSenior)
  ;
  ((self.ui).obj_AdvanLock):SetActive(not (self.info).unlockSenior)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  if not (self.info).unlockSenior or not (self.ui).AdvanTitleCol then
    ((self.ui).img_AdvanTitle).color = (self.ui).col_AdvanTitle
    local sizeDelta = (((self.ui).btn_GetAll).transform).sizeDelta
    if not (self.info).unlockSenior or not (self.ui).number_getAllExrX then
      sizeDelta.x = (self.ui).number_getAllNorX
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((self.ui).btn_GetAll).transform).sizeDelta = sizeDelta
      self:RefreshAchievementLevel()
      local isCanGet = self:IsCanGet()
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R3 in 'UnsetPending'

      if not isCanGet or not (self.ui).color_canBuy then
        ((self.ui).img_GetAll).color = (self.ui).color_Buyed
        -- DECOMPILER ERROR at PC80: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).btn_GetAll).enabled = isCanGet
      end
    end
  end
end

UIEventGrowBag.OnClickBuy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self.info).unlockSenior then
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

UIEventGrowBag.OnClickGetAll = function(self)
  -- function num : 0_7 , upvalues : _ENV, BattlePassEnum
  if not self:IsCanGet() then
    return 
  end
  local battlePassNetwork = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
  battlePassNetwork:CS_BATTLEPASS_Take(((self.info).passCfg).id, nil, (BattlePassEnum.TakeWay).All, function()
    -- function num : 0_7_0 , upvalues : _ENV
    local rewardDic = NetworkManager:GetRewardShowCache()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_7_0_0 , upvalues : _ENV, rewardDic
      if window == nil then
        return 
      end
      local rewardIds = {}
      local rewardNums = {}
      for id,num in pairs(rewardDic) do
        (table.insert)(rewardIds, id)
        ;
        (table.insert)(rewardNums, num)
      end
      window:AddNext2ShowReward(rewardIds, rewardNums)
    end
)
  end
)
end

UIEventGrowBag.IsCanGet = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local levelDic = {}
  for index,cfg in ipairs(self.tableArray) do
    local rewardState = ((self.info).taken)[cfg.level]
    local isNormalLocked = (PlayerDataCenter.playerLevel).level < cfg.level
    local isNormalGetReward = (rewardState ~= nil and rewardState.base)
    if not isNormalLocked then
      local isSeniorLocked = not (self.info).unlockSenior
    end
    local isSeniorGetReward = (rewardState ~= nil and rewardState.senior)
    -- DECOMPILER ERROR at PC40: Unhandled construct in 'MakeBoolean' P3

    local baseCanGet = (not isNormalLocked and rewardState == nil)
    local seniorCanGet = (isSeniorLocked or (self.info).unlockSenior) and rewardState ~= nil and not rewardState.senior
    local isCanGet = baseCanGet or seniorCanGet
    if isCanGet then
      return true
    end
  end
  do return false end
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

UIEventGrowBag.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__OnDataChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__RefreshCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__onRefreshAchievementLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedRewardLevel, self.__onRefreshAchievementLevel)
  ;
  (base.OnDelete)(self)
end

return UIEventGrowBag

