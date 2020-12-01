-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingSlot = class("UITrainingSlot", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local SlotState = {Lock = 1, Empty = 2, Training = 3, TrainingComplete = 4}
UITrainingSlot.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.OnSlotHeroEvent = nil
  self.OnSettleEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickRootButton)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Hero).texture = nil
end

UITrainingSlot.InitTrainingSlot = function(self, slotData, resloader)
  -- function num : 0_1
  self.slotData = slotData
  self.resloader = resloader
end

UITrainingSlot.Update = function(self, timestamp)
  -- function num : 0_2
  self.__timestamp = timestamp
  if self.__enableUpdateProgress then
    self:__UpdateProgress()
  end
end

UITrainingSlot.__UpdateProgress = function(self)
  -- function num : 0_3 , upvalues : _ENV, SlotState
  local duration, remainSecond, progress = (self.slotData):UpdateProgress(self.__timestamp)
  MsgCenter:Broadcast(eMsgEventId.UpdateTrainingProgress, (self.slotData).index, duration, remainSecond, progress)
  if progress < 1 then
    self.__slotState = SlotState.Training
    local reaminText = TimestampToTime(remainSecond)
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Exp).fillAmount = progress
    ;
    ((self.ui).tex_Time):SetIndex(0, reaminText)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (((self.ui).tex_Time).text).color = (self.ui).trainingColor
    self.__enableUpdateProgress = true
  else
    do
      self.__slotState = SlotState.TrainingComplete
      ;
      ((self.ui).finish):SetActive(true)
      ;
      ((self.ui).tex_Time):SetIndex(1)
      -- DECOMPILER ERROR at PC55: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((self.ui).tex_Time).text).color = (self.ui).trainingCompleteColor
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_Exp).fillAmount = 1
      self.__enableUpdateProgress = false
    end
  end
end

UITrainingSlot.UpdateSlot = function(self)
  -- function num : 0_4 , upvalues : SlotState, _ENV
  local unlock, unlockLevels = (self.slotData):CheckUnlock()
  self.__enableUpdateProgress = false
  if not unlock then
    self.__slotState = SlotState.Lock
    ;
    ((self.ui).heroInfoNode):SetActive(false)
    ;
    ((self.ui).add):SetActive(false)
    ;
    ((self.ui).finish):SetActive(false)
    ;
    ((self.ui).addOrLockNode):SetActive(true)
    ;
    ((self.ui).lock):SetActive(true)
    ;
    (((self.ui).tex_Lock).gameObject):SetActive(true)
    ;
    ((self.ui).tex_Title):SetIndex(1)
    if unlockLevels ~= nil and #unlockLevels > 0 then
      ((self.ui).tex_Lock):SetIndex(0, tostring(unlockLevels[1]))
    end
  else
    if (self.slotData).heroId == nil then
      self.__slotState = SlotState.Empty
      ;
      ((self.ui).heroInfoNode):SetActive(false)
      ;
      ((self.ui).add):SetActive(true)
      ;
      ((self.ui).finish):SetActive(false)
      ;
      ((self.ui).addOrLockNode):SetActive(true)
      ;
      ((self.ui).lock):SetActive(false)
      ;
      (((self.ui).tex_Lock).gameObject):SetActive(false)
      ;
      ((self.ui).tex_Title):SetIndex(0)
      -- DECOMPILER ERROR at PC102: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).img_Hero).texture = nil
    else
      ;
      ((self.ui).heroInfoNode):SetActive(true)
      ;
      ((self.ui).addOrLockNode):SetActive(false)
      local heroCard = (PlayerDataCenter.heroDic)[(self.slotData).heroId]
      if heroCard == nil then
        error("角色不存在,heroCardId=" .. tostring((self.slotData).heroId))
        return 
      end
      if IsNull(((self.ui).img_Hero).texture) then
        (self.resloader):LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroCard:GetResName()), function(texture)
    -- function num : 0_4_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_Hero).texture = texture
  end
)
      end
      -- DECOMPILER ERROR at PC150: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Name).text = heroCard:GetName()
      -- DECOMPILER ERROR at PC159: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Level).text = "LV.<Size=30>" .. tostring(heroCard.level) .. "</Size>"
      local starSize = ((self.ui).img_Star).sizeDelta
      starSize.x = starSize.y * heroCard.star
      -- DECOMPILER ERROR at PC169: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).img_Star).sizeDelta = starSize
      self:__UpdateProgress()
    end
  end
end

UITrainingSlot.OnClickRootButton = function(self)
  -- function num : 0_5 , upvalues : SlotState, cs_MessageCommon, _ENV
  if self.__slotState == SlotState.Lock then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Train_LockedInfo))
  else
    -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

    if self.__slotState == SlotState.Empty and self.OnSlotHeroEvent ~= nil then
      (self.OnSlotHeroEvent)((self.slotData).index)
    end
  end
  -- DECOMPILER ERROR at PC35: Unhandled construct in 'MakeBoolean' P1

  if self.__slotState == SlotState.Training and self.OnSettleEvent ~= nil then
    (self.OnSettleEvent)((self.slotData).index, false)
  end
  if self.__slotState == SlotState.TrainingComplete and self.OnSettleEvent ~= nil then
    (self.OnSettleEvent)((self.slotData).index, true)
  end
end

UITrainingSlot.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UITrainingSlot

-- params : ...
-- function num : 0 , upvalues : _ENV
local UITrainingSlot = class("UITrainingSlot", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local SlotState = {Lock = 1, Empty = 2, Training = 3, TrainingComplete = 4}
UITrainingSlot.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.OnSlotHeroEvent = nil
    self.OnSettleEvent = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickRootButton) -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_Hero).texture = nil
end

UITrainingSlot.InitTrainingSlot = function(self, slotData, resloader)
    -- function num : 0_1
    self.slotData = slotData
    self.resloader = resloader
end

UITrainingSlot.Update = function(self, timestamp)
    -- function num : 0_2
    self.__timestamp = timestamp
    if self.__enableUpdateProgress then self:__UpdateProgress() end
end

UITrainingSlot.__UpdateProgress = function(self)
    -- function num : 0_3 , upvalues : _ENV, SlotState
    local duration, remainSecond, progress =
        (self.slotData):UpdateProgress(self.__timestamp)
    MsgCenter:Broadcast(eMsgEventId.UpdateTrainingProgress,
                        (self.slotData).index, duration, remainSecond, progress)
    if progress < 1 then
        self.__slotState = SlotState.Training
        local reaminText = TimestampToTime(remainSecond) -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).img_Exp).fillAmount = progress;
        ((self.ui).tex_Time):SetIndex(0, reaminText) -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'
        ;
        (((self.ui).tex_Time).text).color = (self.ui).trainingColor
        self.__enableUpdateProgress = true
    else
        do
            self.__slotState = SlotState.TrainingComplete;
            ((self.ui).finish):SetActive(true);
            ((self.ui).tex_Time):SetIndex(1) -- DECOMPILER ERROR at PC55: Confused about usage of register: R4 in 'UnsetPending'
            ;
            (((self.ui).tex_Time).text).color = (self.ui).trainingCompleteColor -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((self.ui).img_Exp).fillAmount = 1
            self.__enableUpdateProgress = false
        end
    end
end

UITrainingSlot.UpdateSlot = function(self)
    -- function num : 0_4 , upvalues : SlotState, _ENV
    local unlock, unlockLevels = (self.slotData):CheckUnlock()
    self.__enableUpdateProgress = false
    if not unlock then
        self.__slotState = SlotState.Lock;
        ((self.ui).heroInfoNode):SetActive(false);
        ((self.ui).add):SetActive(false);
        ((self.ui).finish):SetActive(false);
        ((self.ui).addOrLockNode):SetActive(true);
        ((self.ui).lock):SetActive(true);
        (((self.ui).tex_Lock).gameObject):SetActive(true);
        ((self.ui).tex_Title):SetIndex(1)
        if unlockLevels ~= nil and #unlockLevels > 0 then
            ((self.ui).tex_Lock):SetIndex(0, tostring(unlockLevels[1]))
        end
    else
        if (self.slotData).heroId == nil then
            self.__slotState = SlotState.Empty;
            ((self.ui).heroInfoNode):SetActive(false);
            ((self.ui).add):SetActive(true);
            ((self.ui).finish):SetActive(false);
            ((self.ui).addOrLockNode):SetActive(true);
            ((self.ui).lock):SetActive(false);
            (((self.ui).tex_Lock).gameObject):SetActive(false);
            ((self.ui).tex_Title):SetIndex(0) -- DECOMPILER ERROR at PC102: Confused about usage of register: R3 in 'UnsetPending'
            ;
            ((self.ui).img_Hero).texture = nil
        else

            ((self.ui).heroInfoNode):SetActive(true);
            ((self.ui).addOrLockNode):SetActive(false)
            local heroCard = (PlayerDataCenter.heroDic)[(self.slotData).heroId]
            if heroCard == nil then
                error("角色不存在,heroCardId=" ..
                          tostring((self.slotData).heroId))
                return
            end
            if IsNull(((self.ui).img_Hero).texture) then
                (self.resloader):LoadABAssetAsync(
                    PathConsts:GetCharacterPicPath(heroCard:GetResName()),
                    function(texture)
                        -- function num : 0_4_0 , upvalues : self
                        -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

                        ((self.ui).img_Hero).texture = texture
                    end)
            end -- DECOMPILER ERROR at PC150: Confused about usage of register: R4 in 'UnsetPending'
            
            ((self.ui).tex_Name).text = heroCard:GetName() -- DECOMPILER ERROR at PC159: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((self.ui).tex_Level).text =
                "LV.<Size=30>" .. tostring(heroCard.level) .. "</Size>"
            local starSize = ((self.ui).img_Star).sizeDelta
            starSize.x = starSize.y * heroCard.star -- DECOMPILER ERROR at PC169: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.ui).img_Star).sizeDelta = starSize
            self:__UpdateProgress()
        end
    end
end

UITrainingSlot.OnClickRootButton = function(self)
    -- function num : 0_5 , upvalues : SlotState, cs_MessageCommon, _ENV
    if self.__slotState == SlotState.Lock then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.Train_LockedInfo))
    else
        -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

        if self.__slotState == SlotState.Empty and self.OnSlotHeroEvent ~= nil then
            (self.OnSlotHeroEvent)((self.slotData).index)
        end
    end
    -- DECOMPILER ERROR at PC35: Unhandled construct in 'MakeBoolean' P1

    if self.__slotState == SlotState.Training and self.OnSettleEvent ~= nil then
        (self.OnSettleEvent)((self.slotData).index, false)
    end
    if self.__slotState == SlotState.TrainingComplete and self.OnSettleEvent ~=
        nil then (self.OnSettleEvent)((self.slotData).index, true) end
end

UITrainingSlot.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    self.resloader = nil;
    (base.OnDelete)(self)
end

return UITrainingSlot

