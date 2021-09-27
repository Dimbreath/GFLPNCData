local UINNotifySettingItem = class("UINNotifySettingItem", UIBaseNode)
local UISingleSwitchTogItem = require("Game.Setting.UI.UISingleSwitchTogItem")
local base = UIBaseNode
UINNotifySettingItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UISingleSwitchTogItem
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, false)
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.singleSwitchTogItem = (UISingleSwitchTogItem.New)()
  ;
  (self.singleSwitchTogItem):Init((self.ui).mailItemTogItem)
  self.isInited = false
end

UINNotifySettingItem.InitNotifyItem = function(self, homesideInfoCfg, isOFF)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(homesideInfoCfg.switch_name)
  ;
  (self.singleSwitchTogItem):InitSingleSwitchTogItem(not isOFF, {ConfigData:GetTipContent(8002), ConfigData:GetTipContent(8001)}, self.OnNoticeTogValueChange, self)
  self.noticeId = homesideInfoCfg.id
  self.isInited = true
end

UINNotifySettingItem.OnNoticeTogValueChange = function(self, value)
  -- function num : 0_2 , upvalues : _ENV
  if self.isInited then
    (self.ctrl):SetNoticeSwitchOff(self.noticeId, not value)
    if not value then
      NoticeManager:DeleteNoticeByType(self.noticeId)
    else
      if self.noticeId == (NoticeManager.eNoticeType).HasOasisBuildingOperate then
        (ControllerManager:GetController(ControllerTypeId.HomeController)).isOasisHasCOB = false
      end
    end
  end
end

UINNotifySettingItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINNotifySettingItem

