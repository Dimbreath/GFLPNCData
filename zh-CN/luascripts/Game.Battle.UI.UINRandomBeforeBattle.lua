-- params : ...
-- function num : 0 , upvalues : _ENV
local UINRandomBeforeBattle = class("UINRandomBeforeBattle", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local UINRandomBeforeBattlePassItem = require("Game.Battle.UI.UINRandomBeforeBattlePassItem")
local __randomType = {ambush = 1, stealth = 2}
UINRandomBeforeBattle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, __randomType, UINRandomBeforeBattlePassItem
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.judgeItemList = {}
  for key,value in pairs(__randomType) do
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R6 in 'UnsetPending'

    (self.judgeItemList)[value] = {}
  end
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_rejudgeAmbush, self, self.RejudgeAmbush)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_rejudgeStealth, self, self.RejudgeSneak)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_stealth, self, self.StartSneak)
  self.focusPointNum = 0
  self.foucusPointItemId = (ConfigData.game_config).RandomBeforeBatteleRejudgeItem
  self.focusPointNum = 0
  self.ambushPool = (UIItemPool.New)(UINRandomBeforeBattlePassItem, (self.ui).ambushItem)
  ;
  ((self.ui).ambushItem):SetActive(false)
  self.stealthPool = (UIItemPool.New)(UINRandomBeforeBattlePassItem, (self.ui).stealthItem)
  ;
  ((self.ui).stealthItem):SetActive(false)
  self.__updateData = BindCallback(self, self.UpdateData)
  MsgCenter:AddListener(eMsgEventId.OnBeforeBattleRandomDataChange, self.__updateData)
  self.__refreshFocusPoint = BindCallback(self, self.RefreshFocusPoint)
  MsgCenter:AddListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
end

UINRandomBeforeBattle.InitData = function(self, roomData, focusLimit, focusPointNum)
  -- function num : 0_1
  self.roomData = roomData
  self.roomPosition = roomData.position
  self:RefreshFocusPoint(focusPointNum, focusLimit)
end

UINRandomBeforeBattle.UpdateData = function(self, ambush, stealth, position)
  -- function num : 0_2 , upvalues : _ENV, __randomType
  if position ~= self.roomPosition then
    return 
  end
  for key,value in pairs(__randomType) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R9 in 'UnsetPending'

    (self.judgeItemList)[value] = {}
  end
  ;
  (((self.ui).btn_rejudgeAmbush).gameObject):SetActive(false)
  ;
  (((self.ui).btn_rejudgeStealth).gameObject):SetActive(false)
  ;
  (((self.ui).btn_stealth).gameObject):SetActive(false)
  if ambush ~= nil then
    self:ShowResult(__randomType.ambush, self:UnpackageData(ambush))
  end
  if stealth ~= nil then
    self:ShowResult(__randomType.stealth, self:UnpackageData(stealth))
  end
end

UINRandomBeforeBattle.UnpackageData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
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

UINRandomBeforeBattle.ShowResult = function(self, type, career, judgeResult)
  -- function num : 0_4 , upvalues : __randomType, _ENV
  local pool = nil
  if type == __randomType.ambush then
    pool = self.ambushPool
  else
    if type == __randomType.stealth then
      pool = self.stealthPool
    end
  end
  pool:HideAll()
  for index,judgeNum in ipairs(judgeResult) do
    local isPass = judgeNum > 0
    local item = pool:GetOne(true)
    item:InitPassItem(isPass)
    item:SetJudgeIcon(career)
    if judgeNum == 2 then
      item:LuckPass()
    end
    ;
    (table.insert)((self.judgeItemList)[type], item)
  end
  self:RefreshJudgeBtn(type)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINRandomBeforeBattle.RefreshJudgeBtn = function(self, type)
  -- function num : 0_5 , upvalues : _ENV, __randomType
  local isAllPass = true
  if #(self.judgeItemList)[type] == 0 then
    isAllPass = false
  else
    for index,item in ipairs((self.judgeItemList)[type]) do
      if not item.isPass then
        isAllPass = false
        break
      end
    end
  end
  do
    if isAllPass then
      if type == __randomType.ambush then
        (((self.ui).btn_rejudgeAmbush).gameObject):SetActive(false)
        ;
        ((ExplorationManager.epCtrl).battleCtrl):SetAmbush(true)
      else
        if type == __randomType.stealth then
          (((self.ui).btn_stealth).gameObject):SetActive(true)
          ;
          (((self.ui).btn_rejudgeStealth).gameObject):SetActive(false)
        end
      end
    else
      if type == __randomType.ambush then
        ((ExplorationManager.epCtrl).battleCtrl):SetAmbush(false)
        if #(self.judgeItemList)[type] == 0 then
          (((self.ui).btn_rejudgeAmbush).gameObject):SetActive(false)
        else
          ;
          (((self.ui).btn_rejudgeAmbush).gameObject):SetActive(true)
        end
      else
        if type == __randomType.stealth then
          (((self.ui).btn_stealth).gameObject):SetActive(false)
          if #(self.judgeItemList)[type] == 0 then
            (((self.ui).btn_rejudgeStealth).gameObject):SetActive(false)
          else
            ;
            (((self.ui).btn_rejudgeStealth).gameObject):SetActive(true)
          end
        end
      end
    end
  end
end

UINRandomBeforeBattle.RejudgeAmbush = function(self)
  -- function num : 0_6 , upvalues : cs_MessageCommon
  if self.focusPointNum > 0 then
    (self.explorationNetworkCtrl):CS_EXPLORATION_BATTLE_Focus(self.roomPosition, true, function(value)
    -- function num : 0_6_0 , upvalues : self
    (self.roomData):SetAmbushAndSneakData(value, (self.roomData).stealthData)
  end
)
  else
    ;
    (cs_MessageCommon.ShowMessageTips)("专注点数不足")
  end
end

UINRandomBeforeBattle.RejudgeSneak = function(self)
  -- function num : 0_7 , upvalues : cs_MessageCommon
  if self.focusPointNum > 0 then
    (self.explorationNetworkCtrl):CS_EXPLORATION_BATTLE_Focus(self.roomPosition, false, function(value)
    -- function num : 0_7_0 , upvalues : self
    (self.roomData):SetAmbushAndSneakData((self.roomData).ambushData, value)
  end
)
  else
    ;
    (cs_MessageCommon.ShowMessageTips)("专注点数不足")
  end
end

UINRandomBeforeBattle.StartSneak = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (self.explorationNetworkCtrl):CS_EXPLORATION_BATTLE_Stealth(self.roomPosition)
  ;
  ((ExplorationManager.epCtrl).battleCtrl):SetSneak()
  self:Delete()
end

UINRandomBeforeBattle.RefreshFocusPoint = function(self, itemNum, focusLimit)
  -- function num : 0_9 , upvalues : _ENV
  self.focusPointNum = itemNum
  ;
  ((self.ui).txt_focusPiontText):SetIndex(0, tostring(itemNum), tostring(focusLimit))
end

UINRandomBeforeBattle.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnBeforeBattleRandomDataChange, self.__updateData)
  MsgCenter:RemoveListener(eMsgEventId.EpFocusPointChange, self.__refreshFocusPoint)
  ;
  (base.OnDelete)(self)
end

return UINRandomBeforeBattle

