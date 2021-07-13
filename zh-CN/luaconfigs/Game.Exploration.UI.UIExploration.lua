-- params : ...
-- function num : 0 , upvalues : _ENV
local UIExploration = class("UIExploration", UIBaseWindow)
local base = UIBaseWindow
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINEpChipSuitItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitItem")
local UINMonsterLevel = require("Game.Exploration.UI.MonsterLevel.UINMonsterLevel")
local cs_MessageCommon = CS.MessageCommon
UIExploration.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpChipSuitItem, UINMonsterLevel
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Deploy, self, self.OnBtnDeployClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.OnBtnRetreatClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_EpStore, self, self.OnBtnStoreClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Guide, self, self.OnBtnGuideClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AutoModule, self, self.OnTogAutoModuleChanged)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StartAuto, self, self.OnBtnStartAutoClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RewardBag, self, self._OnClickRewardBag)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SuitDetail, self, self.OnBtnChipSuitDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChipBag, self, self.OnClickChipPreview)
  ;
  ((self.ui).chipSuitItem):SetActive(false)
  self.chipSuitItemPool = (UIItemPool.New)(UINEpChipSuitItem, (self.ui).chipSuitItem)
  self.monsterLevelNode = (UINMonsterLevel.New)()
  ;
  (self.monsterLevelNode):Init((self.ui).monsterLevel)
  ;
  (self.monsterLevelNode):Hide()
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_Retreat).gameObject):SetActive(false)
  end
  local isUnlockBattleDeploy = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleDeploy)
  if not isUnlockBattleDeploy then
    (((self.ui).btn_Deploy).gameObject):SetActive(false)
  end
  local isUnlockAutoExploration = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_AutoExploration)
  local showAutoEpBtn = isUnlockAutoExploration
  if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    showAutoEpBtn = false
  end
  ;
  ((self.ui).autoModuleNode):SetActive(showAutoEpBtn)
  local defaultAuto = ((ExplorationManager.epCtrl).autoCtrl):IsDefaultAutoEp()
  if defaultAuto then
    self:RefreshAutoModeState(true, true)
  end
  if ((ExplorationManager.epCtrl).overclockCtrl):IsLevelHasOverclock() then
    (((self.ui).btn_Overclock).gameObject):SetActive(true)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_Overclock, self, self.OnBtnOverclockClicked)
  end
  self.__OnEpChipSuitItemClicked = BindCallback(self, self.OnEpChipSuitItemClicked)
  self.hasEpRewardBag = ExplorationManager:HasEpRewardBag()
  ;
  (((self.ui).btn_RewardBag).gameObject):SetActive(self.hasEpRewardBag)
  -- DECOMPILER ERROR at PC192: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.ui).color_DefaultAuto = ((self.ui).img_StartAuto).color
  self.__onRefreshFightingPower = BindCallback(self, self.__RefreshFightingPower)
  MsgCenter:AddListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
  ;
  (((self.ui).btn_EpStore).gameObject):SetActive(((ExplorationManager.epCtrl).residentStoreCtrl):HasEpResidentStore())
end

UIExploration.ShowExplorationFirst = function(self, dynPlayer)
  -- function num : 0_1 , upvalues : _ENV
  self:RefreshPlayerData(dynPlayer)
  local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
  if unlockChipSuit then
    self:RefreshChipSuitItemPreview()
    self.__onChipSuitUpdate = BindCallback(self, self.RefreshChipSuitItemPreview)
    MsgCenter:AddListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
  else
    ;
    (((self.ui).btn_SuitDetail).gameObject):SetActive(false)
  end
  if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    (self.monsterLevelNode):InitMonsterLevelUI(dynPlayer)
  end
end

UIExploration.RefreshPlayerData = function(self, playerData)
  -- function num : 0_2 , upvalues : _ENV
  if not playerData then
    self.dnyPlayer = ExplorationManager:GetDynPlayer()
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
    self:__RefreshFightingPower()
    ;
    ((self.ui).tex_Level):SetIndex(0, tostring(ExplorationManager:GetCurLevelIndex() + 1), tostring(ExplorationManager:GetLevelCount()))
  end
end

UIExploration.__RefreshFightingPower = function(self, fightPower)
  -- function num : 0_3 , upvalues : _ENV
  local power = nil
  power = fightPower == nil and (self.dnyPlayer):GetCacheFightPower() or fightPower
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).text = tostring(power)
end

UIExploration.OnBtnDeployClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local opDetail = (ExplorationManager:GetDynPlayer()):GetOperatorDetail()
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return 
  end
  if ((ExplorationManager.epCtrl).autoCtrl):IsAutoModeRunning() then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(283))
    return 
  end
  self:Hide()
  ;
  (ExplorationManager.epCtrl):EnterDeployRoom()
end

UIExploration.OnBtnRetreatClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  AudioManager:PlayAudioById(1082)
  if (ExplorationManager.epCtrl):IsCompleteExploration() then
    (ExplorationManager.epCtrl):StartCompleteExploration()
    return 
  end
  if self.hasEpRewardBag then
    (((ExplorationManager:GetDynPlayer()).dynRewardBag):HasEpRewardBagData())
    local hasReward = nil
    local msg = nil
    if hasReward then
      msg = ConfigData:GetTipContent(753)
    else
      msg = ConfigData:GetTipContent(752)
    end
    ;
    (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_5_0 , upvalues : _ENV
    (ExplorationManager.epCtrl):ExplorationFailSettle()
  end
, nil)
  else
    do
      if ExplorationManager:GetIsInWeeklyChallenge() then
        local msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
        ;
        (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_5_1 , upvalues : _ENV
    (ExplorationManager.epCtrl):ExplorationFailSettle()
  end
, nil)
      else
        do
          ;
          (ExplorationManager:GetReturnStamina())
          local returnStamina = nil
          local msg = nil
          if returnStamina <= 0 then
            msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
          else
            msg = (string.format)(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), returnStamina)
          end
          ;
          (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_5_2 , upvalues : _ENV
    ExplorationManager:SendSettle(function()
      -- function num : 0_5_2_0 , upvalues : _ENV
      ExplorationManager:ExitExploration()
    end
, nil, nil, false)
  end
, nil)
        end
      end
    end
  end
end

UIExploration.OnBtnStoreClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (ExplorationManager.epCtrl):OpenResidentStore()
end

UIExploration.OnBtnGuideClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.GuidePicture, function(window)
    -- function num : 0_7_0
    if window == nil then
      return 
    end
    window:InitGuidePicture("Res/Images/Guide/Dungeon/", 5, nil)
  end
)
end

UIExploration.OnTogAutoModuleChanged = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local enable = ((ExplorationManager.epCtrl).autoCtrl):IsEnableAutoMode()
  local value = not enable
  if enable then
    ((ExplorationManager.epCtrl).autoCtrl):DisableEpAutoMode()
  else
    ;
    ((ExplorationManager.epCtrl).autoCtrl):EnableEpAutoMode()
  end
end

UIExploration.RefreshAutoModeState = function(self, value, isRunning)
  -- function num : 0_9
  ((self.ui).tex_AutoON):SetActive(value)
  ;
  ((self.ui).tex_AutoOFF):SetActive(not value)
  ;
  ((self.ui).img_AudoSelect):SetIndex(value and 1 or 0)
  ;
  (((self.ui).btn_StartAuto).gameObject):SetActive(value)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  if isRunning then
    ((self.ui).img_StartAuto).color = (self.ui).color_CloseAuto
    ;
    ((self.ui).tex_StartAuto):SetIndex(1)
  else
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_StartAuto).color = (self.ui).color_DefaultAuto
    ;
    ((self.ui).tex_StartAuto):SetIndex(0)
  end
end

UIExploration.OnBtnStartAutoClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local modelOpen, isRunning = ((ExplorationManager.epCtrl).autoCtrl):StartOrStopEpAutoMode()
  self:RefreshAutoModeState(modelOpen, isRunning)
end

UIExploration._OnClickRewardBag = function(self)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardPreview, function(window)
    -- function num : 0_11_0 , upvalues : _ENV
    if window == nil then
      return 
    end
    local rewardList = ((ExplorationManager:GetDynPlayer()).dynRewardBag):GetEpRewardBagDataList()
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    window:InitEpRewardPreview(stageCfg, rewardList)
  end
)
end

UIExploration.OnClickChipPreview = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local chipDataList = ExplorationManager:GetChipDataPreview()
  if chipDataList ~= nil and #chipDataList > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
    -- function num : 0_12_0 , upvalues : chipDataList, _ENV
    window:InitCurrentChip(chipDataList)
    window:SetCurrentChipCloseFunc(function()
      -- function num : 0_12_0_0 , upvalues : _ENV
      local topStatusWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if topStatusWindow ~= nil then
        (topStatusWindow.topGroup):ShowTopBtnGroupGoHomeBtn(false)
        ;
        (topStatusWindow.topGroup):RefreshouldShowNaviBtn(false)
      end
    end
)
  end
)
  end
end

UIExploration.RefreshChipSuitItemPreview = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (self.chipSuitItemPool):HideAll()
  local suitList = (self.dnyPlayer):GetChipSuitSortList()
  ;
  (((self.ui).btn_SuitDetail).gameObject):SetActive(#suitList > 0)
  for i = 1, #suitList do
    local chipSuit = suitList[i]
    local chipSuitItem = (self.chipSuitItemPool):GetOne()
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (chipSuitItem.gameObject).name = tostring(chipSuit.tagId)
    chipSuitItem:InitEpChipSuitItem(chipSuit, self.__OnEpChipSuitItemClicked)
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIExploration.OnEpChipSuitItemClicked = function(self, chipSuitItem)
  -- function num : 0_14 , upvalues : _ENV
  local chipSuit = chipSuitItem:GetDynChipSuit()
  UIManager:ShowWindowAsync(UIWindowTypeID.EpChipSuit, function(chipSuitWindow)
    -- function num : 0_14_0 , upvalues : self, chipSuit
    if chipSuitWindow == nil then
      return 
    end
    chipSuitWindow:InitChipSuitUI(self.dnyPlayer, chipSuit.tagId, nil, ((self.ui).scroll_chipSuit).verticalNormalizedPosition)
  end
)
end

UIExploration.OnBtnChipSuitDetail = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EpChipSuit, function(chipSuitWindow)
    -- function num : 0_15_0 , upvalues : self, _ENV
    if chipSuitWindow == nil then
      return 
    end
    ;
    ((self.ui).obj_chipSuitNode):SetActive(false)
    chipSuitWindow:InitChipSuitUI(self.dnyPlayer, nil, function()
      -- function num : 0_15_0_0 , upvalues : _ENV, self
      if not IsNull(self.transform) then
        ((self.ui).obj_chipSuitNode):SetActive(true)
      end
    end
, ((self.ui).scroll_chipSuit).verticalNormalizedPosition)
  end
)
end

UIExploration.OnBtnOverclockClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  ((ExplorationManager.epCtrl).overclockCtrl):ShowEpOverclockUI()
end

UIExploration.StartFlyRewardBag = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if not ExplorationManager:IsInExplorationAndScene() then
    return 
  end
  local posItem = ((ExplorationManager.epCtrl).mapCtrl):GetPlayerPosItem()
  if posItem == nil then
    return 
  end
  local pos = (posItem.transform).position
  pos = UIManager:World2UIPosition(pos)
  local dpos = (self.transform):InverseTransformPoint((((self.ui).fx_RewardBag).transform).position)
  local startPos = (Vector3.New)(pos.x, pos.y)
  local destPos = (Vector3.New)(dpos.x, dpos.y)
  local width = destPos.x - startPos.x
  local height = startPos.y - destPos.y
  local numPos = #(ConfigData.buildinConfig).RewardBagFlyOffset + 2
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).fx_lineBg).positionCount = numPos
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).fx_line).positionCount = numPos
  ;
  ((self.ui).fx_lineBg):SetPosition(0, startPos)
  ;
  ((self.ui).fx_line):SetPosition(0, startPos)
  for index,v in pairs((ConfigData.buildinConfig).RewardBagFlyOffset) do
    local x = startPos.x + v[1] * width
    local y = destPos.y + v[2] * height
    local newPos = (Vector3.New)(x, y, 0)
    ;
    ((self.ui).fx_lineBg):SetPosition(index, newPos)
    ;
    ((self.ui).fx_line):SetPosition(index, newPos)
  end
  ;
  ((self.ui).fx_lineBg):SetPosition(numPos - 1, destPos)
  ;
  ((self.ui).fx_line):SetPosition(numPos - 1, destPos)
  ;
  (((self.ui).fx_RewardFly).gameObject):SetActive(true)
  ;
  ((self.ui).fx_RewardBag):SetActive(false)
  local matBg = ((self.ui).fx_lineBg):GetMaterial()
  local mat = ((self.ui).fx_line):GetMaterial()
  matBg:SetFloat("_BFAlpha", 0)
  mat:SetFloat("_BFAlpha", 0)
  mat:SetFloat("_BFPanner01", 0)
  if self.__rewardFlyTween == nil then
    local CS_DOTween = ((CS.DG).Tweening).DOTween
    local sequence = (CS_DOTween.Sequence)()
    sequence:SetAutoKill(false)
    sequence:Append(matBg:DOFloat(1, "_BFAlpha", (ConfigData.buildinConfig).RewardBagFlyAppear))
    sequence:Join(mat:DOFloat(1, "_BFAlpha", (ConfigData.buildinConfig).RewardBagFlyAppear))
    sequence:AppendCallback(function()
    -- function num : 0_17_0 , upvalues : self
    ((self.ui).fx_RewardBag):SetActive(true)
  end
)
    sequence:Append(mat:DOFloat(1, "_BFPanner01", (ConfigData.buildinConfig).RewardBagFlyTime))
    sequence:Join((matBg:DOFloat(0, "_BFAlpha", (ConfigData.buildinConfig).RewardBagFlyDisappear)):SetDelay((ConfigData.buildinConfig).RewardBagFlyTime * (ConfigData.buildinConfig).RewardBagDisappearRatio))
    sequence:AppendCallback(function()
    -- function num : 0_17_1 , upvalues : self
    (((self.ui).fx_RewardFly).gameObject):SetActive(false)
  end
)
    self.__rewardFlyTween = sequence
  else
    do
      ;
      (self.__rewardFlyTween):Restart()
    end
  end
end

UIExploration.Show = function(self, withTween)
  -- function num : 0_18 , upvalues : base, _ENV
  if self.active then
    return 
  end
  ;
  (base.Show)(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.5)
  end
end

UIExploration.Hide = function(self, withTween)
  -- function num : 0_19 , upvalues : base, _ENV
  if not self.active then
    return 
  end
  ;
  (base.Hide)(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.5)
  end
end

UIExploration.__ClearFadeTween = function(self)
  -- function num : 0_20
  if self.__fadeTween ~= nil then
    (self.__fadeTween):Kill()
    self.__fadeTween = nil
  end
end

UIExploration.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerFightPowerChang, self.__onRefreshFightingPower)
  if self.__rewardFlyTween ~= nil then
    (self.__rewardFlyTween):Kill()
    self.__rewardFlyTween = nil
  end
  if self.__onChipSuitUpdate ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
    self.__onChipSuitUpdate = nil
  end
  ;
  (self.monsterLevelNode):Delete()
  ;
  (self.resloader):Put2Pool()
  ;
  (base.OnDelete)(self)
end

return UIExploration

