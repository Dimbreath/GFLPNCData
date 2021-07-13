-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroPotential = class("UIHeroPotential", UIBaseWindow)
local base = UIBaseWindow
local UINHeroPotentialCostItem = require("Game.Hero.NewUI.UpgradePotential.UINHeroPotentialCostItem")
local UINStarUpAttrItem = require("Game.Hero.NewUI.UpgradeStar.UINStarUpAttrItem")
local CS_MessageCommon = CS.MessageCommon
UIHeroPotential.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroPotentialCostItem, UINStarUpAttrItem
  ((self.ui).itemWithCount):SetActive(false)
  self.itemPool = (UIItemPool.New)(UINHeroPotentialCostItem, (self.ui).itemWithCount)
  ;
  ((self.ui).attriItem):SetActive(false)
  self.attriPool = (UIItemPool.New)(UINStarUpAttrItem, (self.ui).attriItem)
  self.potentialImgWidth = ((((self.ui).img_cur_Activate).sprite).textureRect).width
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickCancle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Last, self, self.OnClickLast)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Next, self, self.OnClickNext)
  ;
  (UIUtil.AddButtonListener)((self.ui).background, self, self.OnClickCancle)
  self.__onRefreshItem = BindCallback(self, self.__RefreshItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onRefreshItem)
  ;
  (UIUtil.Push2BackStack)(self, self._OnReturn)
end

UIHeroPotential.InitPotential = function(self, heroData, successCallback)
  -- function num : 0_1 , upvalues : _ENV
  AudioManager:PlayAudioById(1088)
  self.heroData = heroData
  self.successCallback = successCallback
  self.selectPotential = (self.heroData).potential
  if (self.heroData):IsFullPotential() then
    self.selectPotential = (self.heroData).potential - 1
  end
  self.potentialCfgDic = (ConfigData.hero_potential)[(self.heroData).dataId]
  self:RefreshPotentialView()
  GuideManager:TryTriggerGuide(eGuideCondition.InHeroPotential)
end

UIHeroPotential.RefreshPotentialView = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local curPotentialCfg = (self.potentialCfgDic)[self.selectPotential]
  local nextPotemtialCfg = (self.potentialCfgDic)[self.selectPotential + 1]
  local maxPontential = (self.heroData):GetMaxPotential()
  local vec = (((self.ui).img_cur_Activate).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * curPotentialCfg.potential_level
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_cur_Activate).rectTransform).sizeDelta = vec
  vec = (((self.ui).img_cur_Empty).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * (maxPontential - curPotentialCfg.potential_level)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_cur_Empty).rectTransform).sizeDelta = vec
  vec = (((self.ui).img_next_Activate).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * nextPotemtialCfg.potential_level
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_next_Activate).rectTransform).sizeDelta = vec
  vec = (((self.ui).img_next_Empty).rectTransform).sizeDelta
  vec.x = self.potentialImgWidth * (maxPontential - nextPotemtialCfg.potential_level)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).img_next_Empty).rectTransform).sizeDelta = vec
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_CurrLimit).text = tostring(curPotentialCfg.level_max)
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_NextLimit).text = tostring(nextPotemtialCfg.level_max)
  ;
  (self.attriPool):HideAll()
  local attriDataDic = (self.heroData):GetDifferAttrWhenRankUp(nil, nil, nil, nil, nextPotemtialCfg.potential_level, curPotentialCfg.potential_level)
  for key,value in ipairs(attriDataDic) do
    local item = (self.attriPool):GetOne()
    item:InitAttrItem(value.oldAttr, value.newAttr, value.attrId)
  end
  self:__RefreshCost(curPotentialCfg)
  if self.selectPotential ~= (self.heroData).potential then
    ((self.ui).empty):SetActive(true)
    ;
    ((self.ui).canUP):SetActive(false)
  else
    ;
    ((self.ui).empty):SetActive(false)
    ;
    ((self.ui).canUP):SetActive(true)
    local isCanPotential = (self.heroData):AblePotential()
    -- DECOMPILER ERROR at PC137: Confused about usage of register: R7 in 'UnsetPending'

    if not isCanPotential or not (self.ui).color_btn_canUp then
      ((self.ui).img_Confirm).color = (self.ui).color_btn_dontUp
      -- DECOMPILER ERROR at PC148: Confused about usage of register: R7 in 'UnsetPending'

      if not isCanPotential or not (self.ui).color_text_canUp then
        do
          ((self.ui).text_Confirm).color = (self.ui).color_text_dontUp
          ;
          ((self.ui).tex_Tips):SetIndex((self.heroData):IsReachLevelLimit() and 0 or 1)
          ;
          (((self.ui).btn_Last).gameObject):SetActive(curPotentialCfg.potential_level > 0)
          ;
          (((self.ui).btn_Next).gameObject):SetActive(nextPotemtialCfg.potential_level < maxPontential)
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end

UIHeroPotential.OnClickCancle = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UIHeroPotential.OnClickConfirm = function(self)
  -- function num : 0_4 , upvalues : _ENV, CS_MessageCommon
  do
    if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
      local msg = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
      ;
      (CS_MessageCommon.ShowMessageTipsWithErrorSound)(msg)
      return 
    end
    if (self.heroData):IsFullPotential() then
      return 
    end
    if not (self.heroData):IsReachLevelLimit() then
      (CS_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.PotentialForbidTip))
      return 
    end
    if not (self.heroData):AblePotential() then
      (CS_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.hero_CantUpgrade))
      return 
    end
    local localSelf = self
    local heroNetCtr = NetworkManager:GetNetwork(NetworkTypeID.Hero)
    heroNetCtr:CS_HERO_PotentialUpgrade((self.heroData).dataId, function(lastData)
    -- function num : 0_4_0 , upvalues : self, _ENV, localSelf
    self.isDelayApplyCloseEvent = true
    ;
    (UIUtil.OnClickBack)()
    localSelf:OnPotentialSuccess(lastData)
  end
)
  end
end

UIHeroPotential.OnClickLast = function(self)
  -- function num : 0_5
  if self.selectPotential > 0 then
    self.selectPotential = self.selectPotential - 1
    self:RefreshPotentialView()
  end
end

UIHeroPotential.OnClickNext = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.selectPotential < (self.heroData):GetMaxPotential() - 1 then
    self.selectPotential = self.selectPotential + 1
    self:RefreshPotentialView()
    AudioManager:PlayAudioById(1110)
  end
end

UIHeroPotential.OnPotentialSuccess = function(self, lastData)
  -- function num : 0_7 , upvalues : _ENV
  if self.successCallback ~= nil then
    (self.successCallback)()
  end
  local lastHeroData = (PlayerDataCenter.heroDic)[(lastData[0]).heroId]
  local uiLevelUp = UIManager:GetWindow(UIWindowTypeID.HeroLevelUp)
  if uiLevelUp ~= nil then
    uiLevelUp:UpdatePotential(lastHeroData.potential - 1)
  end
  self.__onPotentialSuccessOpen = BindCallback(self, self.__PotentialSuccessOpen, lastData[0], lastHeroData)
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotentialSuccess, function(win)
    -- function num : 0_7_0 , upvalues : self
    if win ~= nil then
      (self.__onPotentialSuccessOpen)(win)
    end
  end
)
end

UIHeroPotential.__PotentialSuccessOpen = function(self, lastData, heroData, win)
  -- function num : 0_8 , upvalues : _ENV
  local potentialCfgDic = (ConfigData.hero_potential)[heroData.dataId]
  local curLimit = nil
  local curCfg = potentialCfgDic[heroData.potential - 1]
  if curCfg ~= nil then
    curLimit = curCfg.level_max
  end
  local nextLimit = nil
  local nextCfg = potentialCfgDic[heroData.potential]
  if nextCfg ~= nil then
    nextLimit = nextCfg.level_max
  end
  local localSelf = self
  win:OnInitHeroLimitUpSuccess(curLimit, nextLimit, heroData.dataId)
  win:SetBtnCloseAction(function()
    -- function num : 0_8_0 , upvalues : heroData, _ENV, lastData, self
    if heroData ~= nil then
      local heroNetCtr = NetworkManager:GetNetwork(NetworkTypeID.Hero)
      heroNetCtr:__ShowHeroPowerUpSuccess(lastData.fightingPower, (heroData:GetFightingPower()), nil, function()
      -- function num : 0_8_0_0 , upvalues : self
      if self.closeEvent ~= nil then
        (self.closeEvent)()
      end
    end
)
    end
  end
)
end

UIHeroPotential.__RefreshItem = function(self)
  -- function num : 0_9
  self:RefreshPotentialView()
end

UIHeroPotential.__RefreshCost = function(self, curPotentialCfg)
  -- function num : 0_10 , upvalues : _ENV
  local curCfg = nil
  if curPotentialCfg == nil then
    curCfg = (self.potentialCfgDic)[self.selectPotential]
  else
    curCfg = curPotentialCfg
  end
  ;
  (self.itemPool):HideAll()
  local costDic = curCfg.cost
  for key,value in pairs(costDic) do
    local item = (self.itemPool):GetOne()
    item:InitCostInfo(key, value)
  end
end

UIHeroPotential.SetHeroPotentialCloseEvent = function(self, Action)
  -- function num : 0_11
  self.closeEvent = Action
end

UIHeroPotential._OnReturn = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.closeEvent ~= nil and not self.isDelayApplyCloseEvent then
    (self.closeEvent)()
  end
  AudioManager:PlayAudioById(1089)
  self:Delete()
end

UIHeroPotential.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onRefreshItem)
  ;
  (base.OnDelete)(self)
end

return UIHeroPotential

