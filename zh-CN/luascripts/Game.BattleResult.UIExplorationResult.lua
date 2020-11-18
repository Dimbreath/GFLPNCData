-- params : ...
-- function num : 0 , upvalues : _ENV
local UIExplorationResult = class("UIExplorationResult", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local JumpManager = require("Game.Jump.JumpManager")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local cs_MessageCommon = CS.MessageCommon
local CCId = 1
UIExplorationResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINBaseItemWithCount
  self.sectorNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  self.isWin = false
  self.rewardsRecord = {}
  self.rewardList = {}
  self.CCNum = nil
  self.resloader = (cs_ResLoader.Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Again, self, self.OnRestartClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Detail, self, self.ShowAllChips)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ViewAllReward, self, self.ShowAllItems)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GoNext, self, self.OnGoNextBtnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Exit, self, self.OnExitBtnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GotoItem1, self, self.Jump2HeroState)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GotoItem2, self, self.Jump2HeroState)
  ;
  (((self.ui).btn_Again).gameObject):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).rewardItem)
  ;
  (((self.ui).rewardItem).gameObject):SetActive(false)
end

UIExplorationResult.CompleteExploration = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:Hide()
  ExplorationManager:SendSettle(function(rewardsRecord)
    -- function num : 0_1_0 , upvalues : self
    self.rewardsRecord = rewardsRecord[0]
    self:Show()
    self.isWin = true
    self:UpdataResultsUI(self.isWin)
  end
)
end

UIExplorationResult.CompleteExplorationFloor = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ExplorationManager:SendFloorSettle(function(rewardsRecord)
    -- function num : 0_2_0 , upvalues : self
    self.rewardsRecord = rewardsRecord[0]
    self:Show()
    self.isWin = true
    self:UpdataResultsUI(self.isWin, true)
  end
)
end

UIExplorationResult.FailExploration = function(self, clearAction, rewardsRecord)
  -- function num : 0_3 , upvalues : _ENV
  self.rewardsRecord = rewardsRecord
  self.isWin = false
  self:UpdataResultsUI(self.isWin)
  self._battleEndClear = clearAction
  local returnStamina, remainLevelCount, costStamina = ExplorationManager:GetReturnStamina()
  ;
  ((self.ui).tex_RePoint):SetIndex(0, tostring(returnStamina))
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_AgainPoint).text = tostring(costStamina)
end

UIExplorationResult.OnReturnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.isWin then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(2, function()
    -- function num : 0_4_0 , upvalues : _ENV
    ExplorationManager:ExitExploration()
  end
)
  else
    do
      if self._battleEndClear ~= nil then
        (self._battleEndClear)()
      end
      ExplorationManager:ExitExploration()
    end
  end
end

UIExplorationResult.OnRestartClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  local moduleId = ExplorationManager:GetEpModuleId()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  local againCostStamina = stageCfg.cost_strength_num
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration and (PlayerDataCenter.stamina).value < againCostStamina then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
    return 
  else
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless and ((PlayerDataCenter.infinityData).completed)[stageCfg.dungeonId] and (PlayerDataCenter.stamina).value < againCostStamina then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
      return 
    end
  end
  if self._battleEndClear ~= nil then
    (self._battleEndClear)()
  end
  ExplorationManager:RestartExploratcion()
end

UIExplorationResult.OnGoNextBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ExplorationManager:EnterNextSectionExploration()
end

UIExplorationResult.OnExitBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (ExplorationManager:GetReturnStamina())
  local returnStamina = nil
  local msg = nil
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = (string.format)(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), returnStamina)
  end
  ;
  ((CS.MessageCommon).ShowMessageBox)(msg, function()
    -- function num : 0_7_0 , upvalues : _ENV
    ExplorationManager:SendSettle(function()
      -- function num : 0_7_0_0 , upvalues : _ENV
      ExplorationManager:ExitExploration()
    end
)
  end
, nil)
end

UIExplorationResult.UpdataResultsUI = function(self, isWin, isFloor)
  -- function num : 0_8 , upvalues : _ENV
  local resultBG_Material = ((self.ui).img_ResultBG).material
  if not isFloor then
    isFloor = false
  end
  if isWin then
    AudioManager:PlayAudioById(1003)
    ;
    ((self.ui).img_ResultState):SetIndex(0)
    ;
    ((self.ui).tex_ResultState):SetIndex(0)
    ;
    (((self.ui).btn_Again).gameObject):SetActive(false)
    ;
    ((self.ui).vectoryNode):SetActive(true)
    ;
    ((self.ui).failureNode):SetActive(false)
    resultBG_Material:SetFloat("_Decoloration", 0)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).col_Success
  else
    AudioManager:PlayAudioById(1004)
    ;
    ((self.ui).img_ResultState):SetIndex(1)
    ;
    ((self.ui).tex_ResultState):SetIndex(1)
    ;
    (((self.ui).btn_Again).gameObject):SetActive(true)
    ;
    ((self.ui).vectoryNode):SetActive(false)
    ;
    ((self.ui).failureNode):SetActive(true)
    resultBG_Material:SetFloat("_Decoloration", 1)
  end
  ;
  (((((self.ui).tex_CurLevelCount).transform).parent).gameObject):SetActive(isFloor)
  if isFloor then
    ((self.ui).overBtnGroup):SetActive(true)
    ;
    ((self.ui).normalBtnGroup):SetActive(false)
    ;
    ((self.ui).tex_CurLevelCount):SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1))
    ;
    ((self.ui).tex_ResultState):SetIndex(2)
    resultBG_Material:SetFloat("_Decoloration", 0)
    -- DECOMPILER ERROR at PC126: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_ResultBG).color = (self.ui).col_Over
  end
  self:ShowReward(isWin, isFloor)
  self:ShowChip()
  self:ShowCoin()
  self:ShowPowerIncrease()
  self:ShowMVP()
end

UIExplorationResult.ShowReward = function(self, isWin, isFloor)
  -- function num : 0_9 , upvalues : _ENV, eDynConfigData, cs_MessageCommon
  local hasRandomAth = false
  self.rewardList = {}
  for itemId,num in pairs(self.rewardsRecord) do
    do
      if (itemId >= 8000 and itemId < 9000) or ((ConfigData.item)[itemId]).type == eItemType.Arithmetic then
        hasRandomAth = true
      else
        local itemCfg = (ConfigData.item)[itemId]
        if itemCfg == nil then
          error("can\'t read itemCfg with id=" .. itemId)
        else
          if itemCfg.explorationHold then
            do
              (table.insert)(self.rewardList, {itemCfg = itemCfg, num = num})
              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  if isWin then
    local moduleId = ExplorationManager:GetEpModuleId()
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration and not isFloor then
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      local stageState = (PlayerDataCenter.sectorStage):GetStageState(stageCfg.id)
      if stageState ~= proto_object_DungeonStageState.DungeonStageStatePicked then
        (self.sectorNetworkCtrl):Send_SECTOR_BattleFirstRewardPick(stageCfg.id)
        for index,rewardId in ipairs(stageCfg.first_reward_ids) do
          if rewardId >= 8000 and rewardId < 9000 then
            hasRandomAth = true
          else
            local rewardNum = (stageCfg.first_reward_nums)[index]
            local itemCfg = (ConfigData.item)[rewardId]
            ;
            (table.insert)(self.rewardList, index, {itemCfg = itemCfg, num = rewardNum})
          end
        end
      end
    end
  end
  do
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
      local stageCfg = ExplorationManager:GetSectorStageCfg()
      -- DECOMPILER ERROR at PC115: Confused about usage of register: R6 in 'UnsetPending'

      if ((PlayerDataCenter.infinityData).freshData)[stageCfg.dungeonId] ~= nil then
        ((PlayerDataCenter.infinityData).freshData)[stageCfg.dungeonId] = nil
        ConfigData:LoadDynCfg(eDynConfigData.endless_layer)
        local endlessCfg = stageCfg.endlessCfg
        local isComplete = ((PlayerDataCenter.infinityData).completed)[stageCfg.dungeonId]
        local layerIndex = ((PlayerDataCenter.infinityData).processingUpdate)[stageCfg.dungeonId]
        local layerId = nil
        if layerIndex ~= nil then
          layerId = (endlessCfg.layer)[layerIndex]
        end
        if isComplete then
          for index,rewardId in ipairs(endlessCfg.clear_reward_itemIds) do
            if rewardId >= 8000 and rewardId < 9000 then
              hasRandomAth = true
            else
              local rewardNum = (endlessCfg.clear_reward_itemNums)[index]
              local itemCfg = (ConfigData.item)[rewardId]
              ;
              (table.insert)(self.rewardList, index, {itemCfg = itemCfg, num = rewardNum})
            end
          end
          local lastLayerId = (endlessCfg.layer)[#endlessCfg.layer]
          local layerCfg = (ConfigData.endless_layer)[lastLayerId]
          for index,rewardId in ipairs(layerCfg.reward_itemIds) do
            if rewardId >= 8000 and rewardId < 9000 then
              hasRandomAth = true
            else
              local rewardNum = (layerCfg.reward_itemNums)[index]
              local itemCfg = (ConfigData.item)[rewardId]
              ;
              (table.insert)(self.rewardList, {itemCfg = itemCfg, num = rewardNum})
            end
          end
        else
          do
            if layerId ~= nil then
              local layerCfg = (ConfigData.endless_layer)[layerId]
              for index,rewardId in ipairs(layerCfg.reward_itemIds) do
                if rewardId >= 8000 and rewardId < 9000 then
                  hasRandomAth = true
                else
                  local rewardNum = (layerCfg.reward_itemNums)[index]
                  local itemCfg = (ConfigData.item)[rewardId]
                  ;
                  (table.insert)(self.rewardList, {itemCfg = itemCfg, num = rewardNum})
                end
              end
            end
            do
              do
                ConfigData:ReleaseDynCfg(eDynConfigData.endless_layer)
                if hasRandomAth then
                  if PlayerDataCenter.lastAthDiff ~= nil then
                    for _,athData in ipairs(PlayerDataCenter.lastAthDiff) do
                      (table.insert)(self.rewardList, {num = 1, itemCfg = athData.itemCfg, isAth = true, athData = athData})
                    end
                  end
                  do
                    -- DECOMPILER ERROR at PC252: Confused about usage of register: R4 in 'UnsetPending'

                    PlayerDataCenter.lastAthDiff = nil
                    local containAth = false
                    ;
                    (self.rewardItemPool):HideAll()
                    ;
                    (((self.ui).btn_ViewAllReward).gameObject):SetActive(false)
                    for index,v in ipairs(self.rewardList) do
                      if index > 5 then
                        (((self.ui).btn_ViewAllReward).gameObject):SetActive(true)
                        break
                      end
                      local item = (self.rewardItemPool):GetOne()
                      if v.isAth then
                        item:InitItemWithCount(v.itemCfg, v.num, function()
    -- function num : 0_9_0 , upvalues : _ENV, v
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_9_0_0 , upvalues : v
      if win ~= nil then
        win:InitAthDetail(v.itemCfg, v.athData)
      end
    end
)
  end
)
                      else
                        item:InitItemWithCount(v.itemCfg, v.num, nil)
                      end
                      if (v.itemCfg).type == eItemType.Arithmetic then
                        containAth = true
                      end
                    end
                    do
                      if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
                        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

UIExplorationResult.ShowChip = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.chipList = ((ExplorationManager.epCtrl).dynPlayer):GetChipList()
  local chipNum = 0
  for _,chipData in ipairs(self.chipList) do
    chipNum = chipNum + chipData:GetCount()
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ChipCount).text = tostring(chipNum)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  if chipNum <= 0 then
    ((self.ui).btn_Detail).interactable = false
  else
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).btn_Detail).interactable = true
  end
end

UIExplorationResult.ShowCoin = function(self)
  -- function num : 0_11 , upvalues : CCId, _ENV
  self.CCNum = 0
  if (self.rewardsRecord)[CCId] ~= nil then
    self.CCNum = (self.rewardsRecord)[CCId]
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_MoneyCount).text = tostring(self.CCNum)
end

UIExplorationResult.ShowPowerIncrease = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local newPower = ((ExplorationManager.epCtrl).dynPlayer):GetTotalFightingPower(true, false)
  local oldPower = ((ExplorationManager.epCtrl).dynPlayer):GetMirrorTeamFightPower(true, false)
  local increase = GetPreciseDecimalStr((newPower / oldPower - 1) * 100, 0)
  ;
  ((self.ui).tex_BuffRate):SetIndex(0, tostring(increase))
end

UIExplorationResult.ShowMVP = function(self)
  -- function num : 0_13 , upvalues : _ENV, cs_ResLoader
  if ExplorationManager.epMvpData ~= nil then
    local heroId, MvpType, diggestRate = (ExplorationManager.epMvpData):GetEpMvpData()
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    ;
    ((self.ui).tex_MvpType):SetIndex(MvpType)
    ;
    ((self.ui).tex_Rate):SetIndex(0, GetPreciseDecimalStr(diggestRate * 100, 0))
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
    end
    self.bigImgResloader = (cs_ResLoader.Create)()
    ;
    (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()), function(prefab)
    -- function num : 0_13_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroBigImgNode)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  end
end

UIExplorationResult.ShowAllChips = function(self)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
    -- function num : 0_14_0 , upvalues : self
    if windows ~= nil then
      self.viewAllChipWin = windows
      if self.chipList ~= nil then
        windows:InitChips(self.chipList, self.resloader)
      end
    end
  end
)
end

UIExplorationResult.ShowAllItems = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewItems, function(windows)
    -- function num : 0_15_0 , upvalues : self
    if windows ~= nil then
      self.viewAllItemWin = windows
      windows:InitItems(self.rewardList, self.resloader)
    end
  end
)
end

UIExplorationResult.Jump2HeroState = function(self)
  -- function num : 0_16 , upvalues : _ENV, JumpManager
  if self._battleEndClear ~= nil then
    (self._battleEndClear)()
  end
  ExplorationManager:ExitExploration((Consts.SceneName).Main, function()
    -- function num : 0_16_0 , upvalues : JumpManager
    JumpManager:Jump((JumpManager.eJumpTarget).Hero)
  end
)
end

UIExplorationResult.OnDelete = function(self)
  -- function num : 0_17 , upvalues : base
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  if self.viewAllChipWin ~= nil then
    (self.viewAllChipWin):Delete()
  end
  if self.viewAllItemWin ~= nil then
    (self.viewAllItemWin):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIExplorationResult

