local UISkillInput = class("UISkillInput", UIBaseNode)
local base = UIBaseNode
local csInputUtility = CS.InputUtility
local cs_MessageCommon = CS.MessageCommon
UISkillInput.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_cancle, self, self.__onClick)
  self.cancleButton = (self.ui).btn_cancle
  self.onButtonImageChanged = BindCallback(self, self.__onButtonImageChanged)
  self.defaultTip = ((self.ui).text_messageTips).text
  self.__UltStartAction = function()
    -- function num : 0_0_0 , upvalues : self
    self:UpdateInputStateUI(true)
  end

  self.__UltEndAction = function()
    -- function num : 0_0_1 , upvalues : self
    self:UpdateInputStateUI(false)
  end

  MsgCenter:AddListener(eMsgEventId.OnUltSkillRoleActionStart, self.__UltStartAction)
  MsgCenter:AddListener(eMsgEventId.OnUltSkillViewEnd, self.__UltEndAction)
end

UISkillInput.OnShow = function(self)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).messageTips):SetActive(true)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_cancle).color = (self.ui).img_cancle_normalColor
  ;
  (self.transform):SetAsLastSibling()
  self.detectedButtonChangedTimerId = TimerManager:StartTimer(0.1, self.onButtonImageChanged, self, false, false, true)
  self:__CheckBuffListSetAbleToPointer(false)
  self:UpdateInputStateUI(true)
  if UIManager:GetWindow(UIWindowTypeID.TDBattle) ~= nil then
    MsgCenter:Broadcast(eMsgEventId.TDOpenTopView)
  end
end

UISkillInput.__CheckBuffListSetAbleToPointer = function(self, able)
  -- function num : 0_2 , upvalues : _ENV
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow == nil then
    return 
  end
  local buffListNode = stateInfoWindow.buffList
  if buffListNode == nil then
    return 
  end
  buffListNode:SetBuffListAbleToPointer(able)
end

UISkillInput.__onButtonImageChanged = function(self)
  -- function num : 0_3 , upvalues : csInputUtility, _ENV
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  if (csInputUtility.OverUIValidTag)(TagConsts.ValidTarget) then
    ((self.ui).img_cancle).color = (self.ui).img_cancle_HighlightColor
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_cancle).color = (self.ui).img_cancle_normalColor
  end
end

UISkillInput.OnHide = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:__CheckBuffListSetAbleToPointer(true)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_cancle).color = (self.ui).img_cancle_normalColor
  TimerManager:StopTimer(self.detectedButtonChangedTimerId)
  ;
  ((self.ui).messageTips):SetActive(false)
  self:UpdateInputStateUI(false)
  if UIManager:GetWindow(UIWindowTypeID.TDBattle) ~= nil then
    MsgCenter:Broadcast(eMsgEventId.TDCloseTopView, true)
  end
end

UISkillInput.InjectCancleInputAction = function(self, cancleFunc)
  -- function num : 0_5
  self.cancleFunc = cancleFunc
end

UISkillInput.RefreshUITip = function(self, tipText)
  -- function num : 0_6 , upvalues : _ENV
  if (string.IsNullOrEmpty)(tipText) then
    tipText = self.defaultTip
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).text_messageTips).text = tipText
end

UISkillInput.__onClick = function(self)
  -- function num : 0_7
  if self.cancleFunc ~= nil then
    (self.cancleFunc)()
  end
end

UISkillInput.InvokeCancleInputAction = function(self)
  -- function num : 0_8
  if self.cancleFunc ~= nil then
    (self.cancleFunc)()
  end
end

UISkillInput.ShowUnavailableMentionTips = function(self, castTip)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
  if (string.IsNullOrEmpty)(castTip) then
    castTip = ConfigData:GetTipContent(TipContent.SkillSelectUnavailableTips)
  end
  ;
  (cs_MessageCommon.ShowMessageTips)(castTip)
end

UISkillInput.UpdateInputStateUI = function(self, isInInput)
  -- function num : 0_10 , upvalues : _ENV
  local skillModuleWin = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if skillModuleWin ~= nil then
    skillModuleWin:SetSkillInputState(isInInput)
  end
  local windowHideCollectAct = function(windowId)
    -- function num : 0_10_0 , upvalues : _ENV, self
    local win = UIManager:GetWindow(windowId)
    if win == nil then
      return 
    end
    if win.active then
      (table.insert)(self.hideList, windowId)
    end
  end

  local windowActiveCtrlAct = function(windowId)
    -- function num : 0_10_1 , upvalues : _ENV, isInInput
    local win = UIManager:GetWindow(windowId)
    if win == nil then
      return 
    end
    if win.active and isInInput then
      win:Hide()
    else
      if not win.active and not isInInput then
        win:Show()
      end
    end
  end

  if isInInput then
    self.hideList = {}
    windowHideCollectAct(UIWindowTypeID.Battle)
    windowHideCollectAct(UIWindowTypeID.DungeonStateInfo)
    windowHideCollectAct(UIWindowTypeID.BattleDPS)
    windowHideCollectAct(UIWindowTypeID.BattleCrazyMode)
  end
  if self.hideList ~= nil then
    for i,winId in ipairs(self.hideList) do
      windowActiveCtrlAct(winId)
    end
  end
end

UISkillInput.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base, _ENV
  (base.OnDelete)(self)
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillRoleActionStart, self.__UltStartAction)
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillViewEnd, self.__UltEndAction)
  TimerManager:StopTimer(self.detectedButtonChangedTimer)
end

return UISkillInput

