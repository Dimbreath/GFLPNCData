-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEventRoomRandom = class("UINEventRoomRandom", UIBaseNode)
local base = UIBaseNode
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINRandomBeforeBattlePassItem = require("Game.Battle.UI.UINRandomBeforeBattlePassItem")
local UINEventRoomRandomOptionButton = require("Game.Exploration.UI.EventRoom.UINEventRoomRandomOptionButton")
local UINEventRoomRandomResult = require("Game.Exploration.UI.EventRoom.UINEventRoomRandomResult")
local cs_MessageCommon = CS.MessageCommon
UINEventRoomRandom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEventRoomRandomResult, UINEventRoomRandomOptionButton, UINRandomBeforeBattlePassItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.randomOptionDic = {}
  self.normalOptionDic = {}
  self.randomItemList = {}
  self.selectedCfg = nil
  self.selectedInedx = nil
  self.isAllpass = false
  self.passNum = 0
  self.resultList = {}
  self.focusItemNum = 0
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_selectButton, self, self.OnClickSelect)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_rejudgeButton, self, self.OnClickRejudge)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_acquireButton, self, self.OnClickCollectReward)
  self.resultItemPool = (UIItemPool.New)(UINEventRoomRandomResult, (self.ui).obj_resultItem)
  ;
  ((self.ui).obj_resultItem):SetActive(false)
  self.optionButtonItemPool = (UIItemPool.New)(UINEventRoomRandomOptionButton, (self.ui).obj_optionButton)
  ;
  ((self.ui).obj_optionButton):SetActive(false)
  self.randomItemPool = (UIItemPool.New)(UINRandomBeforeBattlePassItem, (self.ui).obj_randomItem)
  ;
  ((self.ui).obj_randomItem):SetActive(false)
  self.__RandomOptionClick = BindCallback(self, self.RandomOptionClick)
  self.__NormalOptionClick = BindCallback(self, self.NormalOptionClick)
  self.__refreshFocusPoint = BindCallback(self, self.RefreshFocusPoint)
  MsgCenter:AddListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
  ;
  ((ExplorationManager.epCtrl).eventCtrl):SetRejudegeOverCallback(function(judgeValue)
    -- function num : 0_0_0 , upvalues : self
    local career, judgeResult = self:UnpackageData(judgeValue)
    self:__RefreshRandomItem(career, judgeResult)
    self:RefreshDifferentResultProbability(self.selectedCfg, true)
  end
)
end

UINEventRoomRandom.InitRandomEvent = function(self, datas, dynPlayData, onClickActionNormal)
  -- function num : 0_1 , upvalues : _ENV
  self.onClickActionNormal = onClickActionNormal
  self.heroList = dynPlayData.heroList
  local eventText = nil
  local eventCfg = datas.eventCfg
  if eventCfg == nil then
    eventText = ""
  else
    eventText = eventCfg.event_txt
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).content).text = (LanguageUtil.GetLocaleText)(eventText)
  self:RefreshFocusPoint(dynPlayData.focusItemNum, dynPlayData.focusLimit)
  if datas.selectedRandomId ~= 0 then
    self:__InitAfterSelect(datas)
  else
    self:__InitBeforeSelect(datas)
  end
end

UINEventRoomRandom.__InitBeforeSelect = function(self, datas)
  -- function num : 0_2 , upvalues : _ENV
  (self.optionButtonItemPool):HideAll()
  for index,choiceData in ipairs(datas.choiceDatalist) do
    local item = ((self.optionButtonItemPool):GetOne(true))
    local cfg = nil
    if choiceData.isRandom == true then
      cfg = (ConfigData.event_random)[choiceData.choiceId]
      item:InitRandomButton(cfg, choiceData.idx, self.__RandomOptionClick)
    else
      cfg = (ConfigData.event_choice)[choiceData.choiceId]
      item:InitNormalButton(cfg, choiceData.idx, self.__NormalOptionClick)
    end
  end
  ;
  (self.randomItemPool):HideAll()
  ;
  (self.resultItemPool):HideAll()
  self.passNum = 0
  ;
  (((self.ui).btn_selectButton).gameObject):SetActive(true)
  ;
  (((self.ui).btn_rejudgeButton).gameObject):SetActive(false)
  ;
  (((self.ui).btn_acquireButton).gameObject):SetActive(false)
end

UINEventRoomRandom.__InitAfterSelect = function(self, datas)
  -- function num : 0_3 , upvalues : _ENV
  local career, judgeResult = self:UnpackageData(datas.judge)
  self:__RefreshRandomItem(career, judgeResult)
  local cfg = nil
  ;
  (self.optionButtonItemPool):HideAll()
  for index,choiceData in ipairs(datas.choiceDatalist) do
    if choiceData.isRandom == true and choiceData.choiceId == datas.selectedRandomId then
      local item = (self.optionButtonItemPool):GetOne(true)
      cfg = (ConfigData.event_random)[choiceData.choiceId]
      item:InitRandomButton(cfg, choiceData.idx, nil)
      self:RefreshDifferentResultProbability(cfg, true)
      self.selectedCfg = cfg
    end
  end
  ;
  (((self.ui).btn_selectButton).gameObject):SetActive(false)
  ;
  (((self.ui).btn_rejudgeButton).gameObject):SetActive(true)
  ;
  (((self.ui).btn_acquireButton).gameObject):SetActive(true)
end

UINEventRoomRandom.RandomOptionClick = function(self, cfg, idx)
  -- function num : 0_4 , upvalues : _ENV
  (self.randomItemPool):HideAll()
  ;
  (((self.ui).txt_NoremalChoice).gameObject):SetActive(false)
  self.randomItemList = {}
  for i = 1, cfg.judge_num do
    local item = (self.randomItemPool):GetOne(true)
    ;
    (table.insert)(self.randomItemList, item)
  end
  self:RefreshDifferentResultProbability(cfg, false)
  self.selectedCfg = cfg
  self.selectedInedx = idx
end

UINEventRoomRandom.NormalOptionClick = function(self, cfg, idx)
  -- function num : 0_5 , upvalues : _ENV
  (self.randomItemPool):HideAll()
  ;
  (self.resultItemPool):HideAll()
  self.passNum = 0
  ;
  (((self.ui).txt_NoremalChoice).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).txt_NoremalChoice).text = (LanguageUtil.GetLocaleText)(cfg.choice_describe_txt)
  self.selectedCfg = cfg
  self.selectedInedx = idx
end

UINEventRoomRandom.OnClickSelect = function(self)
  -- function num : 0_6 , upvalues : cs_MessageCommon
  if self.selectedCfg == nil or self.selectedInedx == nil then
    (cs_MessageCommon.ShowMessageTips)("未选择")
    return 
  end
  ;
  (self.onClickActionNormal)(self.selectedCfg, self.selectedInedx, true)
end

UINEventRoomRandom.OnClickRejudge = function(self)
  -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV
  if self.focusItemNum <= 0 then
    (cs_MessageCommon.ShowMessageTips)("专注点数不足")
    return 
  end
  if self.isAllpass then
    print("已经全部通过了")
    return 
  end
  ;
  ((ExplorationManager.epCtrl).eventCtrl):SendRejudge()
end

UINEventRoomRandom.OnClickCollectReward = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local des = ((self.resultList)[self.passNum]):GetDes()
  local couldContinue = false
  if ((self.resultList)[self.passNum]).jumpTarget ~= 0 then
    couldContinue = true
  end
  ;
  ((ExplorationManager.epCtrl).eventCtrl):SendCollectReward(des, couldContinue)
end

UINEventRoomRandom.RefreshDifferentResultProbability = function(self, cfg, isRejudege)
  -- function num : 0_9 , upvalues : _ENV
  local n = cfg.judge_num
  ;
  (self.resultItemPool):HideAll()
  local baseRate = (ConfigData.game_config).RandomBeforeBatteleProbabilityBase or 0.6
  local eachRate = (ConfigData.game_config).RandomBeforeBatteleProbabilityEachOne or 0.06
  local careeNum = 0
  for _,heroData in ipairs(self.heroList) do
    if heroData:GetCareer() == cfg.judge_profession then
      careeNum = careeNum + 1
    end
  end
  local successRate = (baseRate + eachRate * (careeNum)) / 1000
  local definitePassNum = self.passNum or 0
  if isRejudege and definitePassNum < n then
    definitePassNum = definitePassNum + 1
  end
  for i = 1, n + 1 do
    local item = (self.resultItemPool):GetOne(true)
    local passNum = i - 1
    local probability = nil
    if passNum < definitePassNum then
      probability = 0
    else
      local wantPassNum = passNum - (definitePassNum)
      local remainPssNum = n - (definitePassNum)
      probability = self:_combination(remainPssNum, wantPassNum) * (Mathf.Pow)(successRate, wantPassNum) * (Mathf.Pow)(1 - successRate, remainPssNum - wantPassNum)
    end
    do
      local logic = (cfg.logic)[i]
      local para1 = (cfg.para1)[i]
      local para2 = (cfg.para2)[i]
      do
        local jumpTarget = (cfg.jump_target)[i]
        item:InitRandomResult(passNum, probability, logic, para1, para2, jumpTarget)
        -- DECOMPILER ERROR at PC90: Confused about usage of register: R20 in 'UnsetPending'

        ;
        (self.resultList)[passNum] = item
        -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

UINEventRoomRandom._combination = function(self, n, m)
  -- function num : 0_10
  local temp1 = self:_factorial(n)
  return self:_factorial(n) / (self:_factorial(m) * self:_factorial(n - m))
end

UINEventRoomRandom._factorial = function(self, n)
  -- function num : 0_11
  if n == 0 then
    return 1
  end
  local temp = 1
  for i = 1, n do
    temp = temp * i
  end
  return temp
end

UINEventRoomRandom.__RefreshRandomItem = function(self, career, judgeResult)
  -- function num : 0_12 , upvalues : _ENV
  (self.randomItemPool):HideAll()
  self.randomItemList = {}
  self.isAllpass = true
  self.passNum = 0
  for index,judgeNum in ipairs(judgeResult) do
    local isPass = judgeNum > 0
    local item = (self.randomItemPool):GetOne(true)
    item:InitPassItem(isPass)
    item:SetJudgeIcon(career)
    if judgeNum == 2 then
      item:LuckPass()
    end
    ;
    (table.insert)(self.randomItemList, item)
    if not isPass then
      self.isAllpass = false
    else
      self.passNum = self.passNum + 1
    end
  end
  if self.isAllpass then
    (((self.ui).btn_rejudgeButton).gameObject):SetActive(false)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINEventRoomRandom.UnpackageData = function(self, data)
  -- function num : 0_13 , upvalues : _ENV
  local temp = data >> 16
  local judgeData = data & CommonUtil.UInt16Max
  local career = temp >> 4
  local judgeTimes = temp & 15
  local judgeResult = {}
  for i = 1, judgeTimes do
    judgeResult[i] = judgeData % 10
    judgeData = judgeData // 10
  end
  return career, judgeResult
end

UINEventRoomRandom.RefreshFocusPoint = function(self, focusItemNum, focusLimit)
  -- function num : 0_14 , upvalues : _ENV
  self.focusItemNum = focusItemNum
  ;
  ((self.ui).txt_focusPiont):SetIndex(0, tostring(focusItemNum), tostring(focusLimit))
end

UINEventRoomRandom.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
  ;
  (base.OnDelete)(self)
end

return UINEventRoomRandom

