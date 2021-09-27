local UINDungeonMultRateBase = class("UINDungeonMultRateBase", UIBaseNode)
local base = UIBaseNode
UINDungeonMultRateBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_isDoubleOrDropUp, self, self.ShowDropInfoNode)
end

UINDungeonMultRateBase.InitMultRate = function(self, dungeonData)
  -- function num : 0_1 , upvalues : _ENV
  self.dungeonData = dungeonData
  local multAddRate = dungeonData:GetActivityMultRewardRate()
  if multAddRate <= 0 then
    self:Hide()
    return 
  end
  if multAddRate == 1 then
    ((self.ui).tex_Type):SetIndex(0)
  else
    ;
    ((self.ui).tex_Type):SetIndex(1)
  end
  self.expiredTm = dungeonData:GetActivityMultRewardExpiredTm()
  if self.expiredTm < 0 then
    ((self.ui).tex_Timer):SetIndex(1)
  end
  local leftTime, totalTime = dungeonData:GetLeftActivityMultRewardNum()
  if totalTime < 0 then
    (((self.ui).tex_DoubleCount).gameObject):SetActive(true)
    ;
    ((self.ui).tex_DoubleCount):SetIndex(1)
  else
    if totalTime > 0 then
      (((self.ui).tex_DoubleCount).gameObject):SetActive(true)
      ;
      ((self.ui).tex_DoubleCount):SetIndex(0, tostring(leftTime), tostring(totalTime))
    else
      ;
      (((self.ui).tex_DoubleCount).gameObject):SetActive(false)
    end
  end
  self:UpdateLeftTime()
end

UINDungeonMultRateBase.UpdateLeftTime = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.expiredTm or 0 <= 0 then
    return 
  end
  local leftTime = self.expiredTm - PlayerDataCenter.timestamp
  ;
  ((self.ui).tex_Timer):SetIndex(0, TimestampToTime(leftTime))
end

UINDungeonMultRateBase.ShowDropInfoNode = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dungeonCfg = (self.dungeonData):GetDungeonCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    -- function num : 0_3_0 , upvalues : dungeonCfg
    if window == nil then
      return 
    end
    window:InitDungeonDropInfo(dungeonCfg.ui_type)
  end
)
end

UINDungeonMultRateBase.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonMultRateBase

