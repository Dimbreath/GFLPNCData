local UIStOSideNode = class("UIStOSideNode", UIBaseNode)
local base = UIBaseNode
local UINStOUnlockConditionItem = require("Game.StrategyOverview.UI.Side.UINStOUnlockConditionItem")
local UINStOConsumeItem = require("Game.StrategyOverview.UI.Side.UINStOConsumeItem")
local UINStOUpItem = require("Game.StrategyOverview.UI.Side.UINStOUpItem")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local cs_MessageCommon = CS.MessageCommon
UIStOSideNode.ctor = function(self, uiStO)
  -- function num : 0_0
  self.uiStO = uiStO
end

UIStOSideNode.OnInit = function(self, uiStO)
  -- function num : 0_1 , upvalues : _ENV, UINStOUnlockConditionItem, UINStOConsumeItem, UINBaseItemWithReceived, UINStOUpItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Upgrade, self, self._OnClickUpgrade)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Preview, self, self._OnClickPreview)
  ;
  ((self.ui).conditionItem):SetActive(false)
  self.conditionItemPool = (UIItemPool.New)(UINStOUnlockConditionItem, (self.ui).conditionItem)
  ;
  ((self.ui).consumeItem):SetActive(false)
  self.consumeItemPool = (UIItemPool.New)(UINStOConsumeItem, (self.ui).consumeItem)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
  ;
  ((self.ui).uPItem):SetActive(false)
  self.upItemPool = (UIItemPool.New)(UINStOUpItem, (self.ui).uPItem)
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.ui).deffSprite = ((self.ui).img_Career).sprite
end

UIStOSideNode.InitStOSideNode = function(self, buildingData)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(buildingData.name)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)(((buildingData.dynData).stcData).intro)
  local careerCfg = (ConfigData.career)[((buildingData.dynData).stcData).strategy_career]
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

  if careerCfg == nil then
    ((self.ui).img_Career).sprite = (self.ui).deffSprite
  else
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  end
  self:RefreshStOSideData(buildingData)
end

UIStOSideNode.RefreshStOSideData = function(self, buildingData)
  -- function num : 0_3
  self.buildingData = buildingData
  self:RefreshStOSide()
end

UIStOSideNode.RefreshStOSide = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local buildingData = self.buildingData
  ;
  ((self.ui).consume):SetActive(false)
  ;
  ((self.ui).unlockCondition):SetActive(false)
  ;
  ((self.ui).isMax):SetActive(false)
  local curLv = buildingData.level or 0
  local nextLevel = curLv + 1
  ;
  ((self.ui).tex_Level):SetIndex(0, tostring(buildingData.level or 0), tostring(buildingData.maxLevel))
  self:_RefreshReward()
  self:_RefreshLogic()
  if buildingData.isBuild then
    if buildingData:IsMaxLevel() then
      ((self.ui).isMax):SetActive(true)
    else
      local nextLevelCfg = (buildingData.levelConfig)[nextLevel]
      if (CheckCondition.CheckLua)(nextLevelCfg.pre_condition, nextLevelCfg.pre_para1, nextLevelCfg.pre_para2) then
        ((self.ui).consume):SetActive(true)
        self:_RefreshConsume(buildingData)
        local canUpgrade = buildingData:CanUpgrade()
        -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).btn_Upgrade).interactable = canUpgrade
      else
        do
          do
            ;
            ((self.ui).unlockCondition):SetActive(true)
            self:_RefreshCondition(buildingData)
            local unlock = (buildingData.dynData):Unlock()
            if unlock then
              ((self.ui).consume):SetActive(true)
              self:_RefreshConsume(buildingData)
              local canBuild = (buildingData.dynData):CanBuild()
              -- DECOMPILER ERROR at PC103: Confused about usage of register: R6 in 'UnsetPending'

              ;
              ((self.ui).btn_Upgrade).interactable = canBuild
            else
              do
                ;
                ((self.ui).unlockCondition):SetActive(true)
                self:_RefreshCondition(buildingData)
              end
            end
          end
        end
      end
    end
  end
end

UIStOSideNode._RefreshCondition = function(self, buildingData)
  -- function num : 0_5 , upvalues : _ENV
  (self.conditionItemPool):HideAll()
  local unlockTab = buildingData:GetPreBuildingLevelInfo()
  for k,condition in ipairs(unlockTab) do
    local conditionItem = (self.conditionItemPool):GetOne()
    conditionItem:InitStOUnlockConditionItem(condition.unlock, condition.lockReason)
  end
end

UIStOSideNode._RefreshConsume = function(self, buildingData)
  -- function num : 0_6 , upvalues : _ENV
  (self.consumeItemPool):HideAll()
  local costList = buildingData:GetNextLevelCostItem()
  for k,cost in ipairs(costList) do
    local consumeItem = (self.consumeItemPool):GetOne()
    consumeItem:InitStOConsumeItem(cost.resId, cost.resCount)
  end
end

UIStOSideNode._RefreshReward = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((self.ui).rewardNode):SetActive(false)
  local isMaxLevel = (self.buildingData):IsMaxLevel()
  local targetLelve = (self.buildingData).level or 0
  if not isMaxLevel then
    targetLelve = targetLelve + 1
  end
  local reward = (self.buildingData):GetLevelUpgradeReward(targetLelve)
  ;
  (self.rewardItemPool):HideAll()
  if reward == nil or (table.count)(reward) == 0 then
    return 
  end
  ;
  ((self.ui).rewardNode):SetActive(true)
  ;
  ((self.ui).tex_upBtn):SetIndex(1)
  ;
  ((self.ui).tex_upTip):SetIndex(1)
  for itemId,count in pairs(reward) do
    local rewardItem = (self.rewardItemPool):GetOne()
    local itemCfg = (ConfigData.item)[itemId]
    rewardItem:InitItemWithCount(itemCfg, count)
    rewardItem:SetPickedUIActive(isMaxLevel)
  end
end

UIStOSideNode._RefreshLogic = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).boostNode):SetActive(false)
  local buffDict = (self.buildingData):GetNextLevelBuffItem()
  local isMaxLevel = ((self.buildingData):IsMaxLevel())
  -- DECOMPILER ERROR at PC11: Overwrote pending register: R3 in 'AssignReg'

  local nextLevel = .end
  if isMaxLevel then
    nextLevel = (self.buildingData).maxLevel
  else
    nextLevel = ((self.buildingData).level or 0) + 1
  end
  local customLogicList = (self.buildingData):GetBuildCustomLogicInfo(nextLevel)
  if #buffDict == 0 and #customLogicList == 0 then
    return 
  end
  ;
  ((self.ui).boostNode):SetActive(true)
  ;
  ((self.ui).tex_upBtn):SetIndex(0)
  ;
  ((self.ui).tex_upTip):SetIndex(0)
  ;
  (self.upItemPool):HideAll()
  for k,v in ipairs(buffDict) do
    if v ~= nil then
      local upItem = (self.upItemPool):GetOne()
      upItem:InitStOUpItem(v.currentInfo, v.curValue, v.nextInfoValue, isMaxLevel)
    end
  end
  for k,v in ipairs(customLogicList) do
    local upItem = (self.upItemPool):GetOne()
    upItem:InitStOUpItem(v, "", "", isMaxLevel)
  end
end

UIStOSideNode._OnClickUpgrade = function(self)
  -- function num : 0_9
  ((self.uiStO).stOCtrl):StOTechUpgrade(self.buildingData)
end

UIStOSideNode._OnClickPreview = function(self)
  -- function num : 0_10
  (self.uiStO):ShowStOPreview(self.buildingData)
end

UIStOSideNode.OnBuildUpgradeStOSide = function(self, buildingData)
  -- function num : 0_11
  if (self.buildingData).id ~= buildingData.id then
    return 
  end
  self:RefreshStOSideData(buildingData)
end

UIStOSideNode.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (self.conditionItemPool):DeleteAll()
  ;
  (self.consumeItemPool):DeleteAll()
  ;
  (self.upItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIStOSideNode

