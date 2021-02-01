-- params : ...
-- function num : 0 , upvalues : _ENV
local UINNotifySettingItem = class("UINNotifySettingItem", UIBaseNode)
local base = UIBaseNode
local HomeEnum = require("Game.Home.HomeEnum")
UINNotifySettingItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).mailItemTogItem, self, self.OnNoticeTogValueChange)
  self.isInited = false
end

UINNotifySettingItem.InitNotifyItem = function(self, homesideInfoCfg, isOFF)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(homesideInfoCfg.switch_name)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).mailItemTogItem).isOn = not isOFF
  self.noticeId = homesideInfoCfg.id
  self.isInited = true
end

UINNotifySettingItem.OnNoticeTogValueChange = function(self, value)
  -- function num : 0_2 , upvalues : _ENV, HomeEnum
  if self.isInited then
    (self.ctrl):SetNoticeSwitchOff(self.noticeId, not value)
    if not value then
      MsgCenter:Broadcast(eMsgEventId.CleanNotice, self.noticeId)
    else
      if self.noticeId == (HomeEnum.eNoticeType).HasOasisBuildingOperate then
        (ControllerManager:GetController(ControllerTypeId.HomeController)).isOasisHasCOB = false
      else
        if self.noticeId == (HomeEnum.eNoticeType).HasSectorBuildingOperate then
          (ControllerManager:GetController(ControllerTypeId.HomeController)).isSectorHasCOB = false
        end
      end
    end
  end
end

UINNotifySettingItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINNotifySettingItem

