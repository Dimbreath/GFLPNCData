local UIEventBattlePass = class("UIEventBattlePass", UIBaseWindow)
local base = UIBaseWindow
local UINBattlePassTable = require("Game.BattlePass.UI.UINBattlePassTable")
local UIHeroSkinShowTool = require("Game.CommonUI.Skin.UIHeroSkinShowTool")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
UIEventBattlePass.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBattlePassTable, UIHeroSkinShowTool
  (UIUtil.AddButtonListener)((self.ui).btn_Task, self, self.OnBtnTaskClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BuyLevel, self, self.OnBtnBuyLevelClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBtnBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetAll, self, self.OnBtnGetAllClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Tips, self, self.OnBtnTipsClicked)
  self.originExpWidth = ((((self.ui).img_ExpFill).transform).sizeDelta).x
  self.originExpHeight = ((((self.ui).img_ExpFill).transform).sizeDelta).y
  self.passTableNode = (UINBattlePassTable.New)()
  ;
  (self.passTableNode):Init((self.ui).passTable)
  self.skinTool = (UIHeroSkinShowTool.New)()
  ;
  (self.skinTool):InitSkinShow((self.ui).heroHolder, (self.ui).picHolder, self:GetWindowSortingLayer())
  self.__onBattlePassDataChange = BindCallback(self, self.OnBattlePassDataChange)
  MsgCenter:AddListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
end

UIEventBattlePass.InitBattlePassUI = function(self, activityId)
  -- function num : 0_1 , upvalues : _ENV
  local passInfo = ((PlayerDataCenter.battlepassData).passInfos)[activityId]
  self.passInfo = passInfo
  if self.passInfo == nil then
    return 
  end
  self:InitBattlePassStaticUI()
  self:UpdateBattlePassBase(passInfo)
  ;
  (self.passTableNode):InitBattlePassTable(self.passInfo)
end

UIEventBattlePass.UpdateBattlePassBase = function(self, passInfo)
  -- function num : 0_2 , upvalues : _ENV
  (((self.ui).btn_Buy).gameObject):SetActive(not passInfo.unlockUltimate)
  ;
  ((self.ui).lockSenior):SetActive(not passInfo.unlockSenior)
  local index = passInfo.unlockSenior and 1 or 0
  ;
  ((self.ui).tex_Buy):SetIndex(index)
  ;
  ((self.ui).tex_Level):SetIndex(0, tostring(passInfo.level))
  local fillAmount = (self.passInfo).exp / (self.passInfo):GetPassCurLevelExp()
  if (self.passInfo):IsPassFullLevel() then
    ((self.ui).tex_Exp):SetIndex(0)
    fillAmount = 1
  else
    ;
    ((self.ui).tex_Exp):SetIndex(1, tostring(passInfo.exp), tostring((self.passInfo):GetPassCurLevelExp()))
  end
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).slider_ExpFill).value = fillAmount
  ;
  (((self.ui).btn_GetAll).gameObject):SetActive((self.passInfo):PassHaveRewardTake())
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_LimitExp).text = (string.format)("%d/%d", (self.passInfo).weeklyExp, (self.passInfo):GetWeeklyExpLimit())
  local endTime = (self.passInfo):GetBattlePassEndTime()
  if endTime < 0 then
    (((self.ui).tex_TimeTips).gameObject):SetActive(false)
    return 
  else
    ;
    (((self.ui).tex_TimeTips).gameObject):SetActive(true)
    self:UpdateBattlePassEndTime()
    TimerManager:StopTimer(self.__endTimer)
    self.__endTimer = TimerManager:StartTimer(2, self.UpdateBattlePassEndTime, self, false)
  end
end

UIEventBattlePass.UpdateBattlePassEndTime = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local endTime = (self.passInfo):GetBattlePassEndTime()
  local lastTime = (math.max)((math.floor)(endTime - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimestampToTimeInter(lastTime, false, true)
  if s > 0 then
    m = m + 1
  end
  ;
  ((self.ui).tex_TimeTips):SetIndex(0, tostring(d), tostring(h), tostring(m))
end

UIEventBattlePass.OnBattlePassDataChange = function(self, id)
  -- function num : 0_4
  if id ~= (self.passInfo).id then
    return 
  end
  self:UpdateBattlePassBase(self.passInfo)
  ;
  (self.passTableNode):UpdateBattlePassTable(self.passInfo)
end

UIEventBattlePass.InitBattlePassStaticUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local passCfg = (self.passInfo).passCfg
  local skinCfg = (ConfigData.skin)[passCfg.banner_skin]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = (string.format)((LanguageUtil.GetLocaleText)(passCfg.describe), (LanguageUtil.GetLocaleText)(skinCfg.name))
  ;
  (self.skinTool):ShowSkinById(passCfg.banner_skin)
end

UIEventBattlePass.OnBtnTipsClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    -- function num : 0_6_0 , upvalues : _ENV
    if window == nil then
      return 
    end
    window:InitCommonInfo(ConfigData:GetTipContent(324), ConfigData:GetTipContent(326))
  end
)
end

UIEventBattlePass.OnBtnTaskClicked = function(self)
  -- function num : 0_7 , upvalues : JumpManager, TaskEnum
  JumpManager:Jump((JumpManager.eJumpTarget).DynTask, nil, nil, {(TaskEnum.eTaskType).DailyTask}, true)
end

UIEventBattlePass.OnBtnBuyLevelClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if (self.passInfo):IsPassFullLevel() then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(325))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassBuyLevel, function(buyWindow)
    -- function num : 0_8_0 , upvalues : self
    if buyWindow == nil then
      return 
    end
    buyWindow:InitPassBuyLevelUI(self.passInfo)
  end
)
end

UIEventBattlePass.OnBtnBuyClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassPurchase, function(purchaseWindow)
    -- function num : 0_9_0 , upvalues : self
    if purchaseWindow == nil then
      return 
    end
    purchaseWindow:InitBattlePassPurchaseUI(self.passInfo)
  end
)
end

UIEventBattlePass.OnBtnGetAllClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV, BattlePassEnum
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:TakeBattlePassReward((self.passInfo).id, 0, (BattlePassEnum.TakeWay).All)
end

UIEventBattlePass.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  TimerManager:StopTimer(self.__endTimer)
  if self.skinTool ~= nil then
    (self.skinTool):OnDelete()
    self.skinTool = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIEventBattlePass

