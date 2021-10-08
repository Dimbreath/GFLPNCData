local UINTaskBattlePass = class("UINTaskBattlePass", UIBaseNode)
local base = UIBaseNode
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JumpManager = require("Game.Jump.JumpManager")
UINTaskBattlePass.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnGotoBattlePassClicked)
  self.__onBattlePassDataChange = BindCallback(self, self.OnBattlePassDataChanged)
  MsgCenter:AddListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  self.__onBattlePassReddotRefresh = BindCallback(self, self.OnBattlePassReddotRefresh)
end

UINTaskBattlePass.InitTaskBattlePass = function(self)
  -- function num : 0_1 , upvalues : _ENV, ActivityFrameEnum
  local passInfo = (PlayerDataCenter.battlepassData):GetMainBattlePass()
  if passInfo == nil then
    self.passInfo = nil
    self:Hide()
    return 
  end
  self:Show()
  if self.passInfo == passInfo then
    return 
  end
  self.passInfo = passInfo
  self:RefreshTaskBattlePassNode()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local redNode = activityFrameCtrl:GetActivityReddot((ActivityFrameEnum.eActivityType).BattlePass, (self.passInfo).id)
  if self.__redNodePath ~= nil then
    RedDotController:RemoveListener(self.__redNodePath, self.__onBattlePassReddotRefresh)
    self.__redNodePath = nil
  end
  if redNode == nil then
    ((self.ui).obj_redDot):SetActive(false)
    return 
  end
  ;
  ((self.ui).obj_redDot):SetActive(redNode:GetRedDotCount() > 0)
  self.__redNodePath = redNode.nodePath
  RedDotController:AddListener(self.__redNodePath, self.__onBattlePassReddotRefresh)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTaskBattlePass.RefreshTaskBattlePassNode = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).tex_BPLevel):SetIndex(0, tostring((self.passInfo).level))
  local fillAmount = (self.passInfo).exp / (self.passInfo):GetPassCurLevelExp()
  local isFullLevel = (self.passInfo):IsPassFullLevel()
  ;
  ((self.ui).tex_BPExpMax):SetActive(isFullLevel)
  ;
  (((self.ui).tex_BPExp).gameObject):SetActive(not isFullLevel)
  if isFullLevel then
    fillAmount = 1
  else
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_BPExp).text = tostring((self.passInfo).exp) .. "/" .. tostring((self.passInfo):GetPassCurLevelExp())
  end
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).slider_bPExpBar).value = fillAmount
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_LimitExp).text = (string.format)("%d/%d", (self.passInfo).weeklyExp, (self.passInfo):GetWeeklyExpLimit())
end

UINTaskBattlePass.OnBattlePassReddotRefresh = function(self, redNode)
  -- function num : 0_3
  ((self.ui).obj_redDot):SetActive(redNode:GetRedDotCount() > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTaskBattlePass.OnBattlePassDataChanged = function(self, id)
  -- function num : 0_4
  if self.passInfo == nil then
    return 
  end
  if id ~= (self.passInfo).id then
    return 
  end
  self:RefreshTaskBattlePassNode()
end

UINTaskBattlePass.OnGotoBattlePassClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, JumpManager
  if self.passInfo == nil then
    return 
  end
  do
    if not (self.passInfo):IsBattlePassValid() then
      local showingWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      showingWindow:ShowTextBoxWithConfirm((ConfigData:GetTipContent(323)), nil)
      return 
    end
    local activityId = (self.passInfo):GetBattlePassActivityId()
    if activityId == 0 then
      return 
    end
    JumpManager:Jump((JumpManager.eJumpTarget).DynActivity, nil, nil, {activityId})
  end
end

UINTaskBattlePass.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  if self.__redNodePath ~= nil then
    RedDotController:RemoveListener(self.__redNodePath, self.__onBattlePassReddotRefresh)
  end
  ;
  (base.OnDelete)(self)
end

return UINTaskBattlePass

