-- params : ...
-- function num : 0 , upvalues : _ENV
local UIExplorationResult = class("UIExplorationResult", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local JumpManager = require("Game.Jump.JumpManager")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
local CCId = 1
UIExplorationResult.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINBaseItemWithCount
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
  (UIUtil.AddButtonListener)((self.ui).btn_GotoItem1, self, self.Jump2HeroState)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GotoItem2, self, self.Jump2HeroState)
  ;
  (((self.ui).btn_Again).gameObject):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).rewardItem)
  ;
  (((self.ui).rewardItem).gameObject):SetActive(false)
end

UIExplorationResult.FailExploration = function(self, clearAction, closeAction)
  -- function num : 0_1 , upvalues : _ENV
  self._auBack = AudioManager:PlayAudioById(3010, function()
    -- function num : 0_1_0 , upvalues : self
    self._auBack = nil
  end
)
  self.rewardsRecord = rewardsRecord
  self.isWin = false
  self._battleEndClear = clearAction
  self.closeAction = closeAction
end

UIExplorationResult.OnReturnClicked = function(self)
  -- function num : 0_2
  if self._battleEndClear ~= nil then
    (self._battleEndClear)()
  end
  if self.closeAction ~= nil then
    (self.closeAction)()
  end
end

UIExplorationResult.OnRestartClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ExplorationManager:ExitExploration()
  ExplorationManager:RestartExploratcion()
end

UIExplorationResult.UpdataResultsUI = function(self, isWin)
  -- function num : 0_4
  local resultBG_Material = ((self.ui).img_ResultBG).material
  if isWin then
    ((self.ui).img_ResultState):SetIndex(0)
    ;
    ((self.ui).tex_ResultState):SetIndex(0)
    ;
    ((self.ui).vectoryNode):SetActive(true)
    ;
    ((self.ui).failureNode):SetActive(false)
    resultBG_Material:SetFloat("_Decoloration", 0)
  else
    ;
    ((self.ui).img_ResultState):SetIndex(1)
    ;
    ((self.ui).tex_ResultState):SetIndex(1)
    ;
    ((self.ui).vectoryNode):SetActive(false)
    ;
    ((self.ui).failureNode):SetActive(true)
    resultBG_Material:SetFloat("_Decoloration", 1)
  end
  self:ShowReward()
  self:ShowChip()
  self:ShowCoin()
  self:ShowPowerIncrease()
  self:ShowMVP()
end

UIExplorationResult.ShowReward = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
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
  if hasRandomAth then
    if PlayerDataCenter.lastAthDiff ~= nil then
      for _,athData in ipairs(PlayerDataCenter.lastAthDiff) do
        (table.insert)(self.rewardList, {num = 1, itemCfg = athData.itemCfg, isAth = true, athData = athData})
      end
    end
    do
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

      PlayerDataCenter.lastAthDiff = nil
      local containAth = false
      ;
      (self.rewardItemPool):HideAll()
      ;
      (((self.ui).btn_ViewAllReward).gameObject):SetActive(false)
      for index,v in ipairs(self.rewardList) do
        if index <= 4 then
          do
            local item = (self.rewardItemPool):GetOne()
            if v.isAth then
              item:InitItemWithCount(v.itemCfg, v.num, function()
    -- function num : 0_5_0 , upvalues : _ENV, v
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      -- function num : 0_5_0_0 , upvalues : v
      if win ~= nil then
        win:InitAthDetail(v.itemCfg, v.athData)
      end
    end
)
  end
)
            else
              item:InitItemWithCount(v.itemCfg, v.num)
            end
            if (v.itemCfg).type == eItemType.Arithmetic then
              containAth = true
            end
            -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
      end
    end
  end
end

UIExplorationResult.ShowChip = function(self)
  -- function num : 0_6 , upvalues : _ENV
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
  -- function num : 0_7 , upvalues : CCId, _ENV
  self.CCNum = 0
  if (self.rewardsRecord)[CCId] ~= nil then
    self.CCNum = (self.rewardsRecord)[CCId]
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_MoneyCount).text = tostring(self.CCNum)
end

UIExplorationResult.ShowPowerIncrease = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local power = ((ExplorationManager.epCtrl).dynPlayer):GetTotalFightingPower(true, false)
  local oldPower = ((ExplorationManager.epCtrl).dynPlayer):GetMirrorTeamFightPower(true, false)
  local increase = GetPreciseDecimalStr(power / oldPower * 100, 0)
  ;
  ((self.ui).tex_BuffRate):SetIndex(0, tostring(increase))
end

UIExplorationResult.ShowMVP = function(self)
  -- function num : 0_9 , upvalues : _ENV, cs_ResLoader
  if ExplorationManager.tempMVP ~= nil then
    local mvpGrade = ExplorationManager.tempMVP
    local heroData = ((mvpGrade.role).character).heroData
    ;
    ((self.ui).tex_MvpType):SetIndex(mvpGrade.gradeType)
    local value = mvpGrade.value
    local totalValue = mvpGrade.totalValue
    ;
    ((self.ui).tex_Rate):SetIndex(0, GetPreciseDecimalStr(value / totalValue * 100, 0))
    if self.bigImgResloader ~= nil then
      (self.bigImgResloader):Put2Pool()
    end
    self.bigImgResloader = (cs_ResLoader.Create)()
    ;
    (self.bigImgResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()), function(prefab)
    -- function num : 0_9_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroBigImgNode)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end
)
  end
end

UIExplorationResult.ShowAllChips = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
    -- function num : 0_10_0 , upvalues : self
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
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewItems, function(windows)
    -- function num : 0_11_0 , upvalues : self
    if windows ~= nil then
      self.viewAllItemWin = windows
      windows:InitItems(self.rewardList, self.resloader)
    end
  end
)
end

UIExplorationResult.Jump2HeroState = function(self)
  -- function num : 0_12 , upvalues : _ENV, JumpManager
  if self._battleEndClear ~= nil then
    (self._battleEndClear)()
  end
  BattleDungeonManager:InjectBattleExitEvent(function()
    -- function num : 0_12_0 , upvalues : _ENV, JumpManager
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
      -- function num : 0_12_0_0 , upvalues : _ENV, JumpManager
      UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
        -- function num : 0_12_0_0_0 , upvalues : _ENV, JumpManager
        if window == nil then
          return 
        end
        window:SetFrom(AreaConst.Home)
        JumpManager:Jump((JumpManager.eJumpTarget).Hero)
      end
)
    end
)
  end
)
  if self.closeAction ~= nil then
    (self.closeAction)()
  end
end

UIExplorationResult.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  if self._auBack ~= nil then
    AudioManager:StopAudioByBack(self._auBack)
    self._auBack = nil
  end
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

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIExplorationResult = class("UIExplorationResult", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local JumpManager = require("Game.Jump.JumpManager")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
local CCId = 1
UIExplorationResult.OnInit = function(self)
    -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINBaseItemWithCount
    self.isWin = false
    self.rewardsRecord = {}
    self.rewardList = {}
    self.CCNum = nil
    self.resloader = (cs_ResLoader.Create)();
    (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnReturnClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Again, self, self.OnRestartClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Detail, self, self.ShowAllChips);
    (UIUtil.AddButtonListener)((self.ui).btn_ViewAllReward, self,
                               self.ShowAllItems);
    (UIUtil.AddButtonListener)((self.ui).btn_GotoItem1, self,
                               self.Jump2HeroState);
    (UIUtil.AddButtonListener)((self.ui).btn_GotoItem2, self,
                               self.Jump2HeroState);
    (((self.ui).btn_Again).gameObject):SetActive(false)
    self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithCount,
                                           (self.ui).rewardItem);
    (((self.ui).rewardItem).gameObject):SetActive(false)
end

UIExplorationResult.FailExploration = function(self, clearAction, closeAction)
    -- function num : 0_1 , upvalues : _ENV
    self._auBack = AudioManager:PlayAudioById(3010, function()
        -- function num : 0_1_0 , upvalues : self
        self._auBack = nil
    end)
    self.rewardsRecord = rewardsRecord
    self.isWin = false
    self._battleEndClear = clearAction
    self.closeAction = closeAction
end

UIExplorationResult.OnReturnClicked = function(self)
    -- function num : 0_2
    if self._battleEndClear ~= nil then (self._battleEndClear)() end
    if self.closeAction ~= nil then (self.closeAction)() end
end

UIExplorationResult.OnRestartClicked = function(self)
    -- function num : 0_3 , upvalues : _ENV
    ExplorationManager:ExitExploration()
    ExplorationManager:RestartExploratcion()
end

UIExplorationResult.UpdataResultsUI = function(self, isWin)
    -- function num : 0_4
    local resultBG_Material = ((self.ui).img_ResultBG).material
    if isWin then
        ((self.ui).img_ResultState):SetIndex(0);
        ((self.ui).tex_ResultState):SetIndex(0);
        ((self.ui).vectoryNode):SetActive(true);
        ((self.ui).failureNode):SetActive(false)
        resultBG_Material:SetFloat("_Decoloration", 0)
    else

        ((self.ui).img_ResultState):SetIndex(1);
        ((self.ui).tex_ResultState):SetIndex(1);
        ((self.ui).vectoryNode):SetActive(false);
        ((self.ui).failureNode):SetActive(true)
        resultBG_Material:SetFloat("_Decoloration", 1)
    end
    self:ShowReward()
    self:ShowChip()
    self:ShowCoin()
    self:ShowPowerIncrease()
    self:ShowMVP()
end

UIExplorationResult.ShowReward = function(self)
    -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
    local hasRandomAth = false
    self.rewardList = {}
    for itemId, num in pairs(self.rewardsRecord) do
        do
            if (itemId >= 8000 and itemId < 9000) or
                ((ConfigData.item)[itemId]).type == eItemType.Arithmetic then
                hasRandomAth = true
            else
                local itemCfg = (ConfigData.item)[itemId]
                if itemCfg == nil then
                    error("can\'t read itemCfg with id=" .. itemId)
                else
                    if itemCfg.explorationHold then
                        do
                            (table.insert)(self.rewardList,
                                           {itemCfg = itemCfg, num = num})
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
    if hasRandomAth then
        if PlayerDataCenter.lastAthDiff ~= nil then
            for _, athData in ipairs(PlayerDataCenter.lastAthDiff) do
                (table.insert)(self.rewardList, {
                    num = 1,
                    itemCfg = athData.itemCfg,
                    isAth = true,
                    athData = athData
                })
            end
        end
        do
            -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

            PlayerDataCenter.lastAthDiff = nil
            local containAth = false;
            (self.rewardItemPool):HideAll();
            (((self.ui).btn_ViewAllReward).gameObject):SetActive(false)
            for index, v in ipairs(self.rewardList) do
                if index <= 4 then
                    do
                        local item = (self.rewardItemPool):GetOne()
                        if v.isAth then
                            item:InitItemWithCount(v.itemCfg, v.num, function()
                                -- function num : 0_5_0 , upvalues : _ENV, v
                                UIManager:ShowWindowAsync(
                                    UIWindowTypeID.GlobalItemDetail,
                                    function(win)
                                        -- function num : 0_5_0_0 , upvalues : v
                                        if win ~= nil then
                                            win:InitAthDetail(v.itemCfg,
                                                              v.athData)
                                        end
                                    end)
                            end)
                        else
                            item:InitItemWithCount(v.itemCfg, v.num)
                        end
                        if (v.itemCfg).type == eItemType.Arithmetic then
                            containAth = true
                        end
                        -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC109: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
            end
            if containAth and (ConfigData.game_config).athMaxNum <=
                #(PlayerDataCenter.allAthData):GetAllAthList() then
                (cs_MessageCommon.ShowMessageTips)(
                    ConfigData:GetTipContent(TipContent.Ath_MaxCount))
            end
        end
    end
end

UIExplorationResult.ShowChip = function(self)
    -- function num : 0_6 , upvalues : _ENV
    self.chipList = ((ExplorationManager.epCtrl).dynPlayer):GetChipList()
    local chipNum = 0
    for _, chipData in ipairs(self.chipList) do
        chipNum = chipNum + chipData:GetCount()
    end -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).tex_ChipCount).text = tostring(chipNum)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    if chipNum <= 0 then
        ((self.ui).btn_Detail).interactable = false
    else
        -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).btn_Detail).interactable = true
    end
end

UIExplorationResult.ShowCoin = function(self)
    -- function num : 0_7 , upvalues : CCId, _ENV
    self.CCNum = 0
    if (self.rewardsRecord)[CCId] ~= nil then
        self.CCNum = (self.rewardsRecord)[CCId]
    end -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'
    
    ((self.ui).tex_MoneyCount).text = tostring(self.CCNum)
end

UIExplorationResult.ShowPowerIncrease = function(self)
    -- function num : 0_8 , upvalues : _ENV
    local power = ((ExplorationManager.epCtrl).dynPlayer):GetTotalFightingPower(
                      true, false)
    local oldPower =
        ((ExplorationManager.epCtrl).dynPlayer):GetMirrorTeamFightPower(true,
                                                                        false)
    local increase = GetPreciseDecimalStr(power / oldPower * 100, 0);
    ((self.ui).tex_BuffRate):SetIndex(0, tostring(increase))
end

UIExplorationResult.ShowMVP = function(self)
    -- function num : 0_9 , upvalues : _ENV, cs_ResLoader
    if ExplorationManager.tempMVP ~= nil then
        local mvpGrade = ExplorationManager.tempMVP
        local heroData = ((mvpGrade.role).character).heroData;
        ((self.ui).tex_MvpType):SetIndex(mvpGrade.gradeType)
        local value = mvpGrade.value
        local totalValue = mvpGrade.totalValue;
        ((self.ui).tex_Rate):SetIndex(0, GetPreciseDecimalStr(
                                          value / totalValue * 100, 0))
        if self.bigImgResloader ~= nil then
            (self.bigImgResloader):Put2Pool()
        end
        self.bigImgResloader = (cs_ResLoader.Create)();
        (self.bigImgResloader):LoadABAssetAsync(
            PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResName()),
            function(prefab)
                -- function num : 0_9_0 , upvalues : _ENV, self
                DestroyUnityObject(self.bigImgGameObject)
                self.bigImgGameObject = prefab:Instantiate(
                                            (self.ui).heroBigImgNode)
                local commonPicCtrl = (self.bigImgGameObject):FindComponent(
                                          eUnityComponentID.CommonPicController)
                commonPicCtrl:SetPosType("HeroList")
            end)
    end
end

UIExplorationResult.ShowAllChips = function(self)
    -- function num : 0_10 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
        -- function num : 0_10_0 , upvalues : self
        if windows ~= nil then
            self.viewAllChipWin = windows
            if self.chipList ~= nil then
                windows:InitChips(self.chipList, self.resloader)
            end
        end
    end)
end

UIExplorationResult.ShowAllItems = function(self)
    -- function num : 0_11 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.ViewItems, function(windows)
        -- function num : 0_11_0 , upvalues : self
        if windows ~= nil then
            self.viewAllItemWin = windows
            windows:InitItems(self.rewardList, self.resloader)
        end
    end)
end

UIExplorationResult.Jump2HeroState = function(self)
    -- function num : 0_12 , upvalues : _ENV, JumpManager
    if self._battleEndClear ~= nil then (self._battleEndClear)() end
    BattleDungeonManager:InjectBattleExitEvent(
        function()
            -- function num : 0_12_0 , upvalues : _ENV, JumpManager
            ((CS.GSceneManager).Instance):LoadSceneAsyncByAB(
                (Consts.SceneName).Main, function(ok)
                    -- function num : 0_12_0_0 , upvalues : _ENV, JumpManager
                    UIManager:ShowWindowAsync(UIWindowTypeID.Home,
                                              function(window)
                        -- function num : 0_12_0_0_0 , upvalues : _ENV, JumpManager
                        if window == nil then return end
                        window:SetFrom(AreaConst.Home)
                        JumpManager:Jump((JumpManager.eJumpTarget).Hero)
                    end)
                end)
        end)
    if self.closeAction ~= nil then (self.closeAction)() end
end

UIExplorationResult.OnDelete = function(self)
    -- function num : 0_13 , upvalues : _ENV, base
    if self._auBack ~= nil then
        AudioManager:StopAudioByBack(self._auBack)
        self._auBack = nil
    end
    if self.resLoader ~= nil then
        (self.resLoader):Put2Pool()
        self.resLoader = nil
    end
    if self.bigImgResloader ~= nil then
        (self.bigImgResloader):Put2Pool()
        self.bigImgResloader = nil
    end
    if self.viewAllChipWin ~= nil then (self.viewAllChipWin):Delete() end
    if self.viewAllItemWin ~= nil then (self.viewAllItemWin):Delete() end
    (base.OnDelete)(self)
end

return UIExplorationResult

