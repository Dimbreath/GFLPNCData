local UIEpOverclock = class("UIEpOverclock", UIBaseWindow)
local base = UIBaseWindow
local UINEpOverclockListPanel = require("Game.Exploration.UI.Overclock.UINEpOverclockListPanel")
local UINEpOverclockChipSelect = require("Game.Exploration.UI.Overclock.UINEpOverclockChipSelect")
local ScrambleMode = ((CS.DG).Tweening).ScrambleMode
local eBuffLogic = {randomChip = 11, selectChip = 12}
UIEpOverclock.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpOverclockListPanel, UINEpOverclockChipSelect
  (UIUtil.AddButtonListener)((self.ui).background, self, self.OnBtnCloseClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnClickReturn)
  self.resloader = ((CS.ResLoader).Create)()
  self.overclockList = (UINEpOverclockListPanel.New)()
  ;
  (self.overclockList):Init((self.ui).obj_overclockNode)
  self.chipSelectNode = (UINEpOverclockChipSelect.New)()
  ;
  (self.chipSelectNode):Init((self.ui).obj_sortChipNode)
  self.__OnClockOptionSelect = BindCallback(self, self.OnClockOptionSelect)
  self.__onMoneyChange = BindCallback(self, self.RefreshClockMoney)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  self.__RefreshOverClockUI = BindCallback(self, self.RefreshOverClockUI)
  MsgCenter:AddListener(eMsgEventId.UpdateEpOverclock, self.__RefreshOverClockUI)
end

UIEpOverclock.InitOverclockUI = function(self, overclockCtrl, showMoney)
  -- function num : 0_1
  self.overclockCtrl = overclockCtrl
  self.__showMoney = showMoney or false
  ;
  ((self.ui).obj_money):SetActive(self.__showMoney)
  self:RefreshClockMoney(true)
  self:RefreshOverClockUI()
end

UIEpOverclock.RefreshOverClockUI = function(self)
  -- function num : 0_2
  self:__RefreshBaseClockUI()
  ;
  (self.overclockList):InitOverclockListUI(self.overclockCtrl, self.__OnClockOptionSelect)
end

UIEpOverclock.RefreshClockMoney = function(self, isInit)
  -- function num : 0_3 , upvalues : _ENV, ScrambleMode
  if not self.__showMoney then
    return 
  end
  local money = 0
  local dynplayer = nil
  if ExplorationManager ~= nil then
    dynplayer = ExplorationManager:GetDynPlayer()
    if dynplayer ~= nil then
      local theMoney = dynplayer:GetMoneyCount()
      if theMoney ~= nil then
        money = theMoney
      end
    end
  end
  do
    ;
    ((self.ui).tex_Money):DOKill(true)
    ;
    (((self.ui).tex_Money):DOText(tostring(money), 1, true, ScrambleMode.Numerals)):SetLink(((self.ui).tex_Money).gameObject)
    if isInit ~= true and self.active then
      AudioManager:PlayAudioById(1007)
    end
    if self.__LoadMoneyIcon == nil and dynplayer ~= nil then
      local icon = dynplayer:GetMoneyIconId()
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Money).sprite = CRH:GetSprite(icon)
      self.__LoadMoneyIcon = true
    end
  end
end

UIEpOverclock.__RefreshBaseClockUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local curAssembleNum, maxAssembleNum = (self.overclockCtrl):GetClockAssembleNum()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_maxCount).text = tostring(curAssembleNum) .. "/" .. tostring(maxAssembleNum)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_freeNum).text = tostring((self.overclockCtrl):GetLastFreeNum())
end

UIEpOverclock.OnClockOptionSelect = function(self, clockItem)
  -- function num : 0_5 , upvalues : _ENV, eBuffLogic
  local clockOptionData = clockItem.clockOptionData
  local overclockId = clockOptionData.overclockId
  local overclockLevel = clockOptionData.overclockLevel
  local overclockLevelCfg = clockItem.overclockLevelCfg
  local isLimit = (self.overclockCtrl):IsUseClockLimit()
  if isLimit then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Overclock_AssembleNumLimit))
    return 
  end
  local freeCount = (self.overclockCtrl):GetLastFreeNum()
  if freeCount <= 0 and (ExplorationManager:GetDynPlayer()):GetMoneyCount() < overclockLevelCfg.consumeNum then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.dorm_BuyItemInsufficient))
    return 
  end
  local buffCfg = (ConfigData.exploration_buff)[overclockLevelCfg.buffid]
  if buffCfg.logic == eBuffLogic.selectChip then
    (self.overclockList):Hide()
    ;
    (self.chipSelectNode):InitClockChipSelectNode(((self.overclockCtrl).epCtrl).dynPlayer, (self.overclockCtrl):GetClockAllChipDic(), self.resloader, function(chipData)
    -- function num : 0_5_0 , upvalues : self, overclockId, overclockLevel
    (self.overclockList):Show()
    if chipData == nil then
      return 
    end
    ;
    (self.overclockCtrl):UseOverclockOptionWithChipId(overclockId, overclockLevel, chipData.dataId)
  end
)
    return 
  end
  ;
  (self.overclockCtrl):UseOverclockOption(overclockId, overclockLevel)
end

UIEpOverclock.OnBtnCloseClicked = function(self)
  -- function num : 0_6
  self:Delete()
end

UIEpOverclock.OnClickReturn = function(self)
  -- function num : 0_7
  if (self.chipSelectNode).active then
    (self.chipSelectNode):Hide()
    ;
    (self.overclockList):Show()
    return 
  end
  self:OnBtnCloseClicked()
end

UIEpOverclock.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateEpOverclock, self.__RefreshOverClockUI)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.overclockList ~= nil then
    (self.overclockList):Delete()
  end
  if self.chipSelectNode ~= nil then
    (self.chipSelectNode):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIEpOverclock

