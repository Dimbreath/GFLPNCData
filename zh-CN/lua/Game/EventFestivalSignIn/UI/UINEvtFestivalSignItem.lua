local UINEvtFestivalSignItem = class("UINEvtFestivalSignItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINEvtFestivalSignItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).Btn_IsCompleted, self, self._OnClickPickReward)
  ;
  ((self.ui).uINBaseItemWithCount):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).uINBaseItemWithCount)
end

UINEvtFestivalSignItem.InitFestivalSignItem = function(self, signData, signAwardCfg)
  -- function num : 0_1 , upvalues : _ENV
  self.signData = signData
  self.signAwardCfg = signAwardCfg
  ;
  ((self.ui).img_Day):SetIndex(signAwardCfg.day - 1)
  ;
  (self.rewardItemPool):HideAll()
  for k,awardId in ipairs(signAwardCfg.awardIds) do
    local awardNum = (signAwardCfg.awardCounts)[k]
    local itemCfg = (ConfigData.item)[awardId]
    if itemCfg == nil then
      error("Cant get itemCfg, id:" .. tostring(awardId))
    else
      local rewardItem = (self.rewardItemPool):GetOne()
      rewardItem:SetNotNeedAnyJump(true)
      rewardItem:InitItemWithCount(itemCfg, awardNum)
    end
  end
  self:UpdUIFestivalSignInItem()
end

UINEvtFestivalSignItem.UpdUIFestivalSignInItem = function(self)
  -- function num : 0_2 , upvalues : TaskEnum, _ENV
  local state = (self.signData):GetReceiveState((self.signAwardCfg).day)
  local canPick = state == (TaskEnum.eTaskState).Completed
  ;
  (((self.ui).Btn_IsCompleted).gameObject):SetActive(canPick)
  local picked = state == (TaskEnum.eTaskState).Picked
  ;
  ((self.ui).isPicked):SetActive(picked)
  ;
  ((self.ui).pickedMask):SetActive(picked)
  if picked then
    for k,item in ipairs((self.rewardItemPool).listItem) do
      item:CloseGreatRewardLoopFx()
    end
  end
  local cantPick = (not canPick and not picked)
  ;
  ((self.ui).isNormal):SetActive(cantPick)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINEvtFestivalSignItem._OnClickPickReward = function(self)
  -- function num : 0_3 , upvalues : _ENV, TaskEnum
  local startTs, endTs = (self.signData):GetSignDataStartEndTimestamp()
  do
    if endTs ~= -1 and endTs < PlayerDataCenter.timestamp then
      local signWin = UIManager:GetWindow(UIWindowTypeID.EventFestivalSignIn)
      if signWin ~= nil then
        signWin:FestivalSignOutOfDate()
      end
      return 
    end
    if (self.signData):GetReceiveState((self.signAwardCfg).day) ~= (TaskEnum.eTaskState).Completed then
      return 
    end
    if not self._OnPickCompleteFunc then
      self._OnPickCompleteFunc = BindCallback(self, self._OnPickComplete)
      ;
      (NetworkManager:GetNetwork(NetworkTypeID.EventNoviceSign)):CS_SIGNACTIVITY_Pick((self.signData).id, self._OnPickCompleteFunc)
    end
  end
end

UINEvtFestivalSignItem._OnPickComplete = function(self, objList)
  -- function num : 0_4 , upvalues : _ENV
  self:UpdUIFestivalSignInItem()
  if objList.Count == 0 then
    error("objList.Count == 0")
    return 
  end
  local rewardDic = objList[0]
  local rewardIdList = {}
  local rewardNumList = {}
  for k,v in pairs(rewardDic) do
    (table.insert)(rewardIdList, k)
    ;
    (table.insert)(rewardNumList, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_4_0 , upvalues : rewardIdList, rewardNumList
    if window ~= nil then
      window:InitRewardsItem(rewardIdList, rewardNumList)
    end
  end
)
end

UINEvtFestivalSignItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.rewardItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINEvtFestivalSignItem

