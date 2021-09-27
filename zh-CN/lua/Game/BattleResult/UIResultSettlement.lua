local UIResultSettlement = class("UIResultSettlement", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINResultSettlementHeroItem = require("Game.BattleResult.UINResultSettlementHeroItem")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
UIResultSettlement.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResultSettlementHeroItem, UINBaseItemWithCount, cs_ResLoader
  self.playExpAnime = false
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickBack)
  self.heroItemPool = (UIItemPool.New)(UINResultSettlementHeroItem, (self.ui).obj_heroHeadItem)
  ;
  ((self.ui).obj_heroHeadItem):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).obj_baseItemWithCount)
  ;
  ((self.ui).obj_baseItemWithCount):SetActive(false)
  ;
  ((self.ui).obj_CommanderLvUp):SetActive(false)
  self.resloader = (cs_ResLoader.Create)()
  self.__updateHandle = BindCallback(self, self.Update)
  UpdateManager:AddUpdate(self.__updateHandle)
end

UIResultSettlement.InitResultSettlement = function(self, isWin, backRewards, rewardList, resultSettlementData, backCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.backCallback = backCallback
  self.isWin = isWin
  if resultSettlementData == nil or backRewards == nil then
    error("UIResultSettlement: can\'t read data backRewards" .. tostring(backRewards) .. "oldData" .. tostring(resultSettlementData))
    self:OnClickBack()
  end
  self:m_ChnageBgColor(isWin)
  self:RefreshLevelName()
  self:RefreshEpItemReward(rewardList)
  self:RefreshEpTeam(backRewards, resultSettlementData)
end

UIResultSettlement.m_ChnageBgColor = function(self, isWin)
  -- function num : 0_2
  local resultBG_Material = ((self.ui).img_ResultBG).material
  if isWin then
    resultBG_Material:SetFloat("_Decoloration", 0)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).col_Success
  else
    resultBG_Material:SetFloat("_Decoloration", 1)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).col_Over
  end
end

UIResultSettlement.RefreshLevelName = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local moduleId = ExplorationManager:GetEpModuleId()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local sectorShowId = ConfigData:GetSectorIdShow(stageCfg.sector)
    ;
    ((self.ui).tex_LevelName):SetIndex(0, tostring(sectorShowId) .. "-" .. tostring(stageCfg.num))
  else
    do
      if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
        local endlessCfg = stageCfg.endlessCfg
        ;
        ((self.ui).tex_LevelName):SetIndex(1, tostring(endlessCfg.index * 10))
      else
        do
          if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
            ((self.ui).tex_LevelName):SetIndex(2)
          end
        end
      end
    end
  end
end

UIResultSettlement.RefreshEpTeam = function(self, backRewards, resultSettlementData)
  -- function num : 0_4 , upvalues : _ENV
  local oldHeroLevelDic = resultSettlementData.oldHeroLevelDic
  local oldHeroExpDic = resultSettlementData.oldHeroExpDic
  local heroList = ((ExplorationManager.epCtrl).dynPlayer).heroList
  ;
  (self.heroItemPool):HideAll()
  for _,dynHeroData in ipairs(heroList) do
    local heroItem = (self.heroItemPool):GetOne()
    local heroId = dynHeroData.dataId
    heroItem:InitCharacterItem(dynHeroData, self.resloader, nil)
    heroItem:RefershExpData(oldHeroLevelDic[heroId], oldHeroExpDic[heroId], backRewards.exp or 0)
    heroItem:RefreshFriendShipData(backRewards.intimacy or 0)
  end
  self.playExpAnime = true
end

UIResultSettlement.RefreshEpItemReward = function(self, rewardList)
  -- function num : 0_5 , upvalues : _ENV, cs_DoTween
  ExplorationManager:RewardSort(rewardList)
  ;
  (self.rewardItemPool):HideAll()
  for i,v in pairs(rewardList) do
    do
      local item = (self.rewardItemPool):GetOne()
      item:InitItemWithCount(v.itemCfg, v.num, function()
    -- function num : 0_5_0 , upvalues : _ENV, rewardList, i
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_5_0_0 , upvalues : rewardList, i
      if win ~= nil then
        win:InitListDetail(rewardList, i)
      end
    end
)
  end
)
    end
  end
  local rewardSequence = (cs_DoTween.Sequence)()
  for index,item in ipairs((self.rewardItemPool).listItem) do
    item:SetFade(0)
    rewardSequence:AppendCallback(function()
    -- function num : 0_5_1 , upvalues : _ENV, item, self
    if ((ConfigData.game_config).itemWithGreatFxDic)[(item.itemCfg).id] then
      item:LoadGetGreatRewardFx(self.resloader, 5)
    else
      item:LoadGetRewardFx(self.resloader, 5)
    end
  end
)
    rewardSequence:Append((item:GetFade()):DOFade(1, 0.15))
  end
  rewardSequence:SetDelay(0.15)
  rewardSequence:Play()
  if self.rewardSequence ~= nil then
    (self.rewardSequence):Kill()
  end
  self.rewardSequence = rewardSequence
end

UIResultSettlement.m_isRandomAth = function(self, rewardId)
  -- function num : 0_6
  if rewardId >= 8000 and rewardId < 9000 then
    return true
  end
  return false
end

UIResultSettlement.Update = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.playExpAnime then
    local hasnotFinish = false
    for _,heroItem in ipairs((self.heroItemPool).listItem) do
      local isFinish = heroItem:UpdateExp()
      if not isFinish then
        hasnotFinish = true
      end
    end
    if not hasnotFinish then
      self.playExpAnime = false
    end
  end
end

UIResultSettlement.OnClickBack = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.isWin then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(2, function()
    -- function num : 0_8_0 , upvalues : self
    self:Delete()
    if self.backCallback ~= nil then
      (self.backCallback)()
    end
  end
)
  else
    do
      self:Delete()
      if self.backCallback ~= nil then
        (self.backCallback)()
      end
    end
  end
end

UIResultSettlement.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  UpdateManager:RemoveUpdate(self.__updateHandle)
  if self.resloaders ~= nil then
    (self.resloaders):Put2Pool()
    self.resloaders = nil
  end
  if self.rewardSequence ~= nil then
    (self.rewardSequence):Kill()
    self.rewardSequence = nil
  end
  if self.skillSequence ~= nil then
    (self.skillSequence):Kill()
    self.skillSequence = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIResultSettlement

