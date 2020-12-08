-- params : ...
-- function num : 0 , upvalues : _ENV
local UINMailContent = class("UINMailContent", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
UINMailContent.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Mail, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.poolMailItem = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
  ;
  ((self.ui).rewardItem):SetActive(false)
  ;
  (((self.ui).tex_Content).onHrefClick):AddListener(BindCallback(self, self.OnClickHerf))
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Get, self, self.m_GetReward)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Delete, self, self.m_DeleteOneMail)
end

UINMailContent.UpdateContent = function(self, mailData)
  -- function num : 0_1 , upvalues : _ENV
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  self.mailData = mailData
  if mailData == nil then
    ((self.ui).empty):SetActive(true)
    ;
    ((self.ui).normal):SetActive(false)
    return 
  end
  ;
  ((self.ui).empty):SetActive(false)
  ;
  ((self.ui).normal):SetActive(true)
  self:m_RefreshStaticUI(mailData)
  self:m_RefreshReward(mailData)
  self:m_OutOfDataTime()
  self.timer = (TimerManager:GetTimer(1, self.m_OutOfDataTime, self, false, false, true)):Start()
end

UINMailContent.m_RefreshStaticUI = function(self, mailData)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Tile).text = mailData:GetTitle()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Frome).text = mailData:GetSender()
  local ymd, hm = mailData:GetTime()
  ;
  ((self.ui).tex_Time):SetIndex(0, ymd, hm)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = mailData:GetContent()
end

UINMailContent.m_RefreshReward = function(self, mailData)
  -- function num : 0_3 , upvalues : _ENV
  local isHaveAtt, attDic, isPicked = mailData:IsHaveAtt()
  ;
  ((self.ui).reward):SetActive(isHaveAtt)
  if isHaveAtt then
    (self.poolMailItem):HideAll()
    for id,num in pairs(attDic) do
      local itemCfg = (ConfigData.item)[id]
      if itemCfg == nil then
        error("Can\'t read itemCfg with id=" .. tostring(id))
      else
        local reward = (self.poolMailItem):GetOne()
        reward:InitItemWithCount(itemCfg, num, nil, isPicked)
      end
    end
    ;
    (((self.ui).btn_Get).gameObject):SetActive(not isPicked)
    ;
    (((self.ui).btn_Delete).gameObject):SetActive(isPicked)
  else
    ;
    (((self.ui).btn_Delete).gameObject):SetActive(true)
  end
end

local tiemType = {day = 0, hour = 1, min = 2, second = 3}
UINMailContent.m_OutOfDataTime = function(self)
  -- function num : 0_4 , upvalues : _ENV, tiemType
  local time = (self.mailData):GetTimeBeforeExpired()
  if time > 86400 then
    local num = (math.ceil)(time // 86400)
    ;
    ((self.ui).tex_ExpiryDate):SetIndex(tiemType.day, tostring(num))
  else
    do
      if time > 3600 then
        local num = (math.ceil)(time // 3600)
        ;
        ((self.ui).tex_ExpiryDate):SetIndex(tiemType.hour, tostring(num))
      else
        do
          if time > 60 then
            local num = (math.ceil)(time // 60)
            ;
            ((self.ui).tex_ExpiryDate):SetIndex(tiemType.min, tostring(num))
          else
            do
              if time > 0 then
                ((self.ui).tex_ExpiryDate):SetIndex(tiemType.second, tostring(time))
              end
            end
          end
        end
      end
    end
  end
end

UINMailContent.m_GetReward = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  local containAth = false
  for k,item in ipairs((self.poolMailItem).listItem) do
    local itemCfg = item.itemCfg
    if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
      containAth = true
      break
    end
  end
  do
    if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
      return 
    end
    ;
    (self.ctrl):ReqReceiveAttachment((self.mailData).uid)
  end
end

UINMailContent.m_DeleteOneMail = function(self)
  -- function num : 0_6
  (self.ctrl):ReqDeleteOneMail((self.mailData).uid)
end

UINMailContent.OnClickHerf = function(self, herfStr)
  -- function num : 0_7 , upvalues : _ENV, JumpManager
  local arg = (string.split)(herfStr, ":")
  if arg[1] == "GameJump" then
    local typeAndArgs = (string.split)(arg[2], "=")
    do
      local jumpTypeId = (tonumber(typeAndArgs[1]))
      local jumpArgs = nil
      if typeAndArgs[2] ~= nil then
        jumpArgs = (CommonUtil.SplitStrToNumber)(typeAndArgs[2], "_")
      end
      if jumpTypeId > 0 then
        JumpManager:Jump(jumpTypeId, function()
    -- function num : 0_7_0 , upvalues : jumpTypeId, JumpManager, _ENV
    if jumpTypeId == (JumpManager.eJumpTarget).Mail then
      return 
    end
    local win = UIManager:GetWindow(UIWindowTypeID.Mail)
    win:Delete()
  end
, nil, jumpArgs)
      end
    end
  end
end

UINMailContent.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINMailContent

