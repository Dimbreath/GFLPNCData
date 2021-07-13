-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventBattlePass = class("UIEventBattlePass", UIBaseWindow)
local base = UIBaseWindow
local UINBattlePassBuyLevel = require("Game.BattlePass.UI.UINBattlePassBuyLevel")
local UINBattlePassTable = require("Game.BattlePass.UI.UINBattlePassTable")
local UIHeroSkinShowTool = require("Game.CommonUI.Skin.UIHeroSkinShowTool")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
UIEventBattlePass.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBattlePassBuyLevel, UINBattlePassTable, UIHeroSkinShowTool
  (UIUtil.AddButtonListener)((self.ui).btn_Task, self, self.OnBtnTaskClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BuyLevel, self, self.OnBtnBuyLevelClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnBtnBuyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetAll, self, self.OnBtnGetAllClicked)
  self.originExpWidth = ((((self.ui).img_ExpFill).transform).sizeDelta).x
  self.originExpHeight = ((((self.ui).img_ExpFill).transform).sizeDelta).y
  self.buylevelNode = (UINBattlePassBuyLevel.New)()
  ;
  (self.buylevelNode):Init((self.ui).buyLevelNode)
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
  self:InitBattlePassStaticUI()
  self:UpdateBattlePassBase(passInfo)
  ;
  (self.passTableNode):InitBattlePassTable(self.passInfo)
end

UIEventBattlePass.UpdateBattlePassBase = function(self, passInfo)
  -- function num : 0_2 , upvalues : _ENV
  (((self.ui).btn_Buy).gameObject):SetActive(not passInfo.unlockSenior)
  ;
  ((self.ui).lockSenior):SetActive(not passInfo.unlockSenior)
  ;
  ((self.ui).tex_Level):SetIndex(0, tostring(passInfo.level))
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Exp).text = tostring(passInfo.exp) .. "/" .. tostring((self.passInfo):GetPassCurLevelExp())
  local fillAmount = passInfo.exp / (self.passInfo):GetPassCurLevelExp()
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_ExpFill).transform).sizeDelta = (Vector2.New)(self.originExpWidth * fillAmount, self.originExpHeight)
  ;
  (((self.ui).btn_GetAll).gameObject):SetActive((self.passInfo):PassHaveRewardTake())
end

UIEventBattlePass.OnBattlePassDataChange = function(self, id)
  -- function num : 0_3
  if id ~= (self.passInfo).id then
    return 
  end
  self:UpdateBattlePassBase(self.passInfo)
  ;
  (self.passTableNode):UpdateBattlePassTable(self.passInfo)
end

UIEventBattlePass.InitBattlePassStaticUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local passCfg = (self.passInfo).passCfg
  local skinCfg = (ConfigData.skin)[passCfg.banner_skin]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Tips).text = (string.format)((LanguageUtil.GetLocaleText)(passCfg.describe), (LanguageUtil.GetLocaleText)(skinCfg.name))
  ;
  (self.skinTool):ShowSkinById(passCfg.banner_skin)
end

UIEventBattlePass.OnBtnTaskClicked = function(self)
  -- function num : 0_5 , upvalues : JumpManager, TaskEnum
  JumpManager:Jump((JumpManager.eJumpTarget).DynTask, nil, nil, {(TaskEnum.eTaskType).DailyTask})
end

UIEventBattlePass.OnBtnBuyLevelClicked = function(self)
  -- function num : 0_6
  (self.buylevelNode):InitPassBuyLevelUI(self.passInfo)
  ;
  (self.buylevelNode):Show()
end

UIEventBattlePass.OnBtnBuyClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassPurchase, function(purchaseWindow)
    -- function num : 0_7_0 , upvalues : self
    if purchaseWindow == nil then
      return 
    end
    purchaseWindow:InitBattlePassPurchaseUI(self.passInfo)
  end
)
end

UIEventBattlePass.OnBtnGetAllClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV, BattlePassEnum
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:TakeBattlePassReward((self.passInfo).id, 0, (BattlePassEnum.TakeWay).All)
end

UIEventBattlePass.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  if self.skinTool ~= nil then
    (self.skinTool):OnDelete()
    self.skinTool = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIEventBattlePass

