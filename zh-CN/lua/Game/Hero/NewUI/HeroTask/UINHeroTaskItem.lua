local UINHeroTaskItem = class("UINHeroTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
UINHeroTaskItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Get, self, self.OnClickGet)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnClickGoto)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.rewardPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
end

UINHeroTaskItem.InitHeroTaskItem = function(self, taskInfo, heroData)
  -- function num : 0_1 , upvalues : _ENV
  self.taskInfo = taskInfo
  self.heroData = heroData
  local isFinish = (self.heroData):HasGetQuestReward((self.taskInfo).indx)
  ;
  (self.rewardPool):HideAll()
  for i,v in ipairs(taskInfo.rewardIds) do
    local item = (self.rewardPool):GetOne(true)
    local itemCfg = (ConfigData.item)[v]
    local num = (taskInfo.rewardCounts)[i]
    item:InitItemWithCount(itemCfg, num, nil, isFinish)
  end
  self:UpdateUI()
end

UINHeroTaskItem.UpdateUI = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local tempStr = ConfigData:GetTipContent(7001)
  local res = (string.split)(tempStr, "%s")
  local heroName = (LanguageUtil.GetLocaleText)(((self.heroData).heroCfg).name)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_TaskIntro).text = (string.format)(tempStr, heroName, (self.taskInfo).param)
  ;
  ((self.ui).obj_Unfinish):SetActive(false)
  ;
  ((self.ui).obj_Completed):SetActive(false)
  ;
  (((self.ui).btn_Get).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Goto).gameObject):SetActive(false)
  local isFinish = (self.heroData):HasGetQuestReward((self.taskInfo).indx)
  local isComplect = (self.taskInfo).isComplect
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_TaskIntro).color = Color.black
  if isFinish then
    ((self.ui).img_Buttom):SetIndex(2)
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_TaskIntro).color = (self.ui).col_isFinish
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Progress).color = (self.ui).col_isFinish
  else
    if isComplect then
      ((self.ui).img_Buttom):SetIndex(1)
    else
      ;
      ((self.ui).img_Buttom):SetIndex(0)
    end
  end
  ;
  (((self.ui).obj_Unfinish).gameObject):SetActive(not isComplect)
  if isComplect then
    (((self.ui).btn_Get).gameObject):SetActive(not isFinish)
    ;
    ((self.ui).obj_Completed):SetActive(isFinish)
    local aim = (self.taskInfo).param
    local schedule = nil
    if (self.taskInfo).param <= (self.heroData).level then
      schedule = (self.taskInfo).param
    else
      schedule = (self.heroData).level
    end
    -- DECOMPILER ERROR at PC133: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tex_Progress).text = tostring(schedule) .. "/" .. tostring(aim)
    local progress = schedule / aim
    if progress >= 1 or not progress then
      progress = 1
    end
    self.barWidth = ((((self.ui).bar).rectTransform).rect).width
    local vec = (((self.ui).img_Fill).rectTransform).sizeDelta
    vec.x = self.barWidth * progress
    -- DECOMPILER ERROR at PC156: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (((self.ui).img_Fill).rectTransform).sizeDelta = vec
    for i,v in ipairs((self.rewardPool).listItem) do
      v:SetPickedUIActive(isFinish)
    end
  end
end

UINHeroTaskItem.OnClickGoto = function(self)
  -- function num : 0_3 , upvalues : JumpManager
  if ((self.taskInfo).stcData).jump_id ~= nil and ((self.taskInfo).stcData).jump_id > 0 then
    JumpManager:Jump(((self.taskInfo).stcData).jump_id, nil, nil, ((self.taskInfo).stcData).jumpArgs)
  end
end

UINHeroTaskItem.OnClickGet = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local stcTask = (self.taskInfo).stcData
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Hero)):CS_HERO_QuestFinish((self.taskInfo).hero_id, (self.taskInfo).indx, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    (self.heroData):SetQuestGeted((self.taskInfo).indx)
    MsgCenter:Broadcast(eMsgEventId.OnHeroTaskChange, self.heroData)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_4_0_0 , upvalues : _ENV, self
      if window == nil then
        return 
      end
      local rewardTips = (string.format)(ConfigData:GetTipContent(360), "", ((self.ui).tex_TaskIntro).text, (self.taskInfo).param, (self.taskInfo).param)
      window:InitRewardTips(rewardTips)
      window:InitRewardsItem((self.taskInfo).rewardIds, (self.taskInfo).rewardCounts, self._heroIdSnapShoot)
    end
)
  end
)
end

UINHeroTaskItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroTaskItem

