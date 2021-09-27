local UINDungeonItemBase = class("UINDungeonItemBase", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UINDungeonItemBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.isLock = false
  self.clickEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).tog_DungeonItem, self, self.__onClick)
  ;
  (((self.ui).state_lock).gameObject):SetActive(false)
  ;
  ((self.ui).img_Select):SetActive(false)
end

UINDungeonItemBase.InitDungeonItem = function(self, dungeonData, resLoader, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.dungeonData = dungeonData
  self.clickEvent = clickEvent
  local name, name_en = dungeonData:GetDungeonName()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = name
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

  if (self.ui).tex_ENName ~= nil and not IsNull(((self.ui).tex_ENName).text) then
    ((self.ui).tex_ENName).text = name_en
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.gameObject).name = name_en
  if not dungeonData:GetIsUnlock() then
    ((self.ui).state_lock):SetActive(true)
    self.isLock = true
  end
  self:IsMultReward()
end

UINDungeonItemBase.UpdateDailyLimit = function(self)
  -- function num : 0_2
  self:IsMultReward()
end

UINDungeonItemBase.__onClick = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  if self.isLock then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)((self.dungeonData):GetDungeonUnlockDes())
    return 
  end
  AudioManager:PlayAudioById(1060)
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UINDungeonItemBase.OnSelectDisplay = function(self, isShow)
  -- function num : 0_4
  ((self.ui).img_Select):SetActive(isShow)
end

UINDungeonItemBase.IsMultReward = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self.ui).obj_dropUp ~= nil then
    if (self.dungeonData):GetIsHaveMultReward() then
      ((self.ui).obj_dropUp):SetActive(true)
      local multAddRate = (self.dungeonData):GetActivityMultRewardRate()
      if multAddRate == 1 then
        ((self.ui).tex_multType):SetIndex(1)
      else
        ;
        ((self.ui).tex_multType):SetIndex(0)
      end
      local leftTime, totalTime = (self.dungeonData):GetLeftActivityMultRewardNum()
      ;
      ((self.ui).tex_CompleteNum):SetIndex(0, tostring(leftTime), tostring(totalTime))
    else
      do
        ;
        ((self.ui).obj_dropUp):SetActive(false)
      end
    end
  end
end

UINDungeonItemBase.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonItemBase

