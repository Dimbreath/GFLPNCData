local UINFmtPlatform = class("UINFmtPlatform", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UINFmtPlatform.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_QuickLevelUp, self, self.OnQuickLevelUp)
  ;
  (((self.ui).btn_QuickLevelUp).onPress):AddListener(BindCallback(self, self._OnPressQuickLvUp))
  ;
  (((self.ui).btn_QuickLevelUp).onPressUp):AddListener(BindCallback(self, self._OnPressUpQuickLvUp))
  ;
  (((self.ui).btn_QuickLevelUp).onPressDown):AddListener(BindCallback(self, self._OnPressDownQuickLvUp))
  self:_ReFmtPlatformUIState()
end

UINFmtPlatform.InitFmtPlatform = function(self, fmtIndex, isBench, lockStr, isBan)
  -- function num : 0_1
  self.fmtIndex = fmtIndex
  self.isBench = isBench
  self.lockStr = lockStr
  self.isBan = isBan
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  if not isBench then
    ((self.ui).img_SelectHero).color = (self.ui).selectHeroColor
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_SelectHero).color = (self.ui).selectHeroColor
  end
end

UINFmtPlatform.RefreshUIFmtPlatform = function(self, heroData)
  -- function num : 0_2 , upvalues : _ENV
  local fightingPower = 0
  self:_ReFmtPlatformUIState()
  if self.isBan then
    ((self.ui).cantUse):SetActive(true)
  else
    if not (string.IsNullOrEmpty)(self.lockStr) then
      self:_LockActive(true)
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).tex_Condition).text = self.lockStr
    else
      if heroData == nil then
        self:_SelectHeroActive(true)
      else
        local campSprite = CRH:GetSprite((heroData:GetCampCfg()).icon, CommonAtlasType.CareerCamp)
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

        if self.isBench then
          ((self.ui).img_Bench_Camp).sprite = campSprite
          self:_SetBenchHeroActive(true)
        else
          -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((self.ui).img_Camp).sprite = campSprite
          self:_SetHaveHeroActive(true)
        end
        if not heroData.isFixedFmtHero then
          fightingPower = heroData:GetFightingPower()
          self:_PowerActive(true)
          -- DECOMPILER ERROR at PC70: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((self.ui).tex_Power).text = tostring(fightingPower)
        end
      end
    end
  end
  do
    self._fightingPower = fightingPower
    return fightingPower
  end
end

UINFmtPlatform._ReFmtPlatformUIState = function(self)
  -- function num : 0_3
  self:_SetHaveHeroActive(false)
  self:_SelectHeroActive(false)
  self:_SetBenchHeroActive(false)
  self:_LockActive(false)
  self:_PowerActive(false)
  self:_QuickLevelActive(false)
  ;
  ((self.ui).cantUse):SetActive(false)
end

UINFmtPlatform.GetFmtPlatHeroFtPower = function(self)
  -- function num : 0_4
  return self._fightingPower
end

UINFmtPlatform._SetHaveHeroActive = function(self, active)
  -- function num : 0_5
  ((self.ui).haveHero):SetActive(active)
end

UINFmtPlatform._SetBenchHeroActive = function(self, active)
  -- function num : 0_6
  ((self.ui).benchHero):SetActive(active)
end

UINFmtPlatform._SelectHeroActive = function(self, active)
  -- function num : 0_7
  ((self.ui).selectHero):SetActive(active)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_SelectHero).enabled = active
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_SelectHero).enabled = active
end

UINFmtPlatform._LockActive = function(self, active)
  -- function num : 0_8
  ((self.ui).lock):SetActive(active)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Condition).enabled = active
  ;
  (((self.ui).tran_lockIcon).gameObject):SetActive(active)
end

UINFmtPlatform._PowerActive = function(self, active)
  -- function num : 0_9
  ((self.ui).power):SetActive(active)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).enabled = active
end

UINFmtPlatform.IsAbleQuickLevelup = function(self)
  -- function num : 0_10
  return self._canQuickLvUp
end

UINFmtPlatform.GetQuickLevelupBtnUI = function(self)
  -- function num : 0_11
  return ((self.ui).btn_QuickLevelUp).transform
end

UINFmtPlatform._QuickLevelActive = function(self, active)
  -- function num : 0_12 , upvalues : _ENV
  if (((self.ui).btn_QuickLevelUp).gameObject).activeSelf ~= active then
    (((self.ui).btn_QuickLevelUp).gameObject):SetActive(active)
  end
  if active then
    ((self.ui).tex_QuickLevelTex):SetIndex(0, tostring((self.heroData):GetExpByLevel((self.heroData).level)))
  else
    ;
    (((self.ui).tex_QuickLevelTex).gameObject):SetActive(false)
    ;
    ((self.ui).breakThrough):SetActive(false)
  end
end

UINFmtPlatform.SetItemParents = function(self, parentList)
  -- function num : 0_13
  (((self.ui).haveHero).transform):SetParent(parentList[1])
  ;
  (((self.ui).selectHero).transform):SetParent(parentList[2])
  ;
  (((self.ui).img_SelectHero).transform):SetParent(parentList[3])
  ;
  (((self.ui).benchHero).transform):SetParent(parentList[4])
  ;
  (((self.ui).lock).transform):SetParent(parentList[5])
  ;
  ((self.ui).tran_lockIcon):SetParent(parentList[6])
  ;
  (((self.ui).power).transform):SetParent(parentList[7])
  ;
  (((self.ui).tex_SelectHero).transform):SetParent(parentList[8])
  ;
  (((self.ui).tex_Condition).transform):SetParent(parentList[8])
  ;
  (((self.ui).tex_Power).transform):SetParent(parentList[9])
  ;
  (((self.ui).tex_QuickLevelTex).transform):SetParent(parentList[8])
  ;
  (((self.ui).btn_QuickLevelUp).transform):SetParent(parentList[10])
end

UINFmtPlatform.RefreshFmtQuickLvUp = function(self, heroData, quickLvUpFxPrefab)
  -- function num : 0_14
  if heroData == nil or heroData.isFriendSupport or heroData.isFixedFmtHero then
    self:_QuickLevelActive(false)
    return 
  end
  self.heroData = heroData
  self._canQuickLvUp = heroData:GenHeroCanQuickLevelUp()
  self:_RefreshShowQuickLvUpBtn(quickLvUpFxPrefab)
end

UINFmtPlatform._RefreshShowQuickLvUpBtn = function(self, quickLvUpFxPrefab)
  -- function num : 0_15 , upvalues : _ENV
  local showBtn = true
  local isPowerWarn = false
  local uiFmtRoot = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFmtRoot ~= nil then
    showBtn = uiFmtRoot:GetFmtHeroQuickLvUpBtnShow(self.heroData)
    if self._canQuickLvUp then
      isPowerWarn = uiFmtRoot:IsFmtToltalPowerWarn()
    end
  end
  local showBreakThrough = false
  local canBreakThrough = false
  if (self.heroData):IsReachLevelLimit() and not (self.heroData):IsFullLevel() and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
    showBreakThrough = true
    canBreakThrough = (self.heroData):AblePotential()
  end
  showBtn = not showBtn or self._canQuickLvUp or showBreakThrough
  local showFx = not showBtn or isPowerWarn or canBreakThrough
  ;
  ((self.ui).img_QuickLevelUp):SetIndex(canBreakThrough and 1 or 0)
  ;
  ((self.ui).breakThrough):SetActive(showBreakThrough)
  ;
  (((self.ui).tex_QuickLevelTex).gameObject):SetActive(self._canQuickLvUp)
  self:_QuickLevelActive(showBtn)
  self:_ShowPowerWarnFx(showFx, quickLvUpFxPrefab)
end

UINFmtPlatform._ShowPowerWarnFx = function(self, showFx, quickLvUpFxPrefab)
  -- function num : 0_16 , upvalues : _ENV
  if showFx then
    if IsNull(self.quickLvUpFx) then
      self.quickLvUpFx = quickLvUpFxPrefab:Instantiate(((self.ui).btn_QuickLevelUp).transform)
    end
    ;
    (self.quickLvUpFx):SetActive(true)
  else
    if not IsNull(self.quickLvUpFx) then
      (self.quickLvUpFx):SetActive(false)
    end
  end
end

UINFmtPlatform.OnQuickLevelUp = function(self)
  -- function num : 0_17 , upvalues : _ENV, cs_MessageCommon
  if not self._canClickQuickLv then
    return 
  end
  do
    if self._canQuickLvUp then
      local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
      if fmtCtrl ~= nil then
        fmtCtrl:ReqFmtHeroLvUp(self.fmtIndex, (self.heroData).dataId, (self.heroData).level + 1)
      end
      return 
    end
    if (self.heroData):IsReachLevelLimit() then
      do
        if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
          local tip = FunctionUnlockMgr:GetFuncUnlockDecription(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential)
          ;
          (cs_MessageCommon.ShowMessageTips)(tip)
          return 
        end
        if (self.heroData):IsFullPotential() then
          (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(172))
          return 
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.HeroPotential, function(window)
    -- function num : 0_17_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    window:InitPotential(self.heroData, function()
      -- function num : 0_17_0_0 , upvalues : _ENV, self
      local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
      self:_ShowLvUpEffect()
    end
)
  end
)
      end
    end
  end
end

UINFmtPlatform._OnPressDownQuickLvUp = function(self)
  -- function num : 0_18
  self._addLevel = 0
  self._canClickQuickLv = true
end

UINFmtPlatform._OnPressQuickLvUp = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self.heroData == nil or (self.heroData):GetLevelLimit() <= (self.heroData).level + self._addLevel then
    return 
  end
  local needExp = (self.heroData):GetExpToTargetLevel((self.heroData).level + self._addLevel)
  local totalExp = PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp)
  if totalExp < needExp then
    self:_OnPressUpQuickLvUp()
  else
    self._addLevel = self._addLevel + 1
    local level = (self.heroData).level + self._addLevel
    local level_max = (self.heroData):GetLevelLimit()
    self:_ShowLvUpEffect()
    local fmtWin = UIManager:GetWindow(UIWindowTypeID.Formation)
    if fmtWin ~= nil then
      fmtWin:SetUIFmtHeroInfoItemLv((self.heroData).dataId, level)
      fmtWin:SetUIFmtExpNum(totalExp - needExp)
    end
    self._canClickQuickLv = false
    ;
    ((self.ui).tex_QuickLevelTex):SetIndex(0, tostring((self.heroData):GetExpByLevel(level)))
    if level_max <= level then
      self:_OnPressUpQuickLvUp()
    else
      AudioManager:PlayAudioById(1126)
    end
  end
end

UINFmtPlatform._OnPressUpQuickLvUp = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if self._addLevel > 0 then
    (NetworkManager:GetNetwork(NetworkTypeID.Hero)):CS_HERO_Upgrade((self.heroData).dataId, (self.heroData).level + self._addLevel, function()
    -- function num : 0_20_0 , upvalues : _ENV
    AudioManager:PlayAudioById(1126)
    GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
  end
)
    self._addLevel = 0
  end
end

UINFmtPlatform._ShowLvUpEffect = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if fmtCtrl ~= nil then
    (fmtCtrl.fmtSceneCtrl):ShowHeroQuickLvUpEffect(self.fmtIndex)
  end
end

UINFmtPlatform.OnDelete = function(self)
  -- function num : 0_22 , upvalues : base
  (base.OnDelete)(self)
end

return UINFmtPlatform

