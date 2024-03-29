local UINNotifySettingItemGroup = class("UINNotifySettingItemGroup", UIBaseNode)
local base = UIBaseNode
local UINNotifySettingItem = require("Game.Setting.UI.UINNotifySettingItem")
UINNotifySettingItemGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINNotifySettingItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.noticeTypePool = (UIItemPool.New)(UINNotifySettingItem, (self.ui).obj_notice_Item)
  ;
  ((self.ui).obj_notice_Item):SetActive(false)
end

UINNotifySettingItemGroup.InitNotifySettingGroup = function(self, homesideSwitchCfg, noticeSwitchOffDic)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_title).text = (LanguageUtil.GetLocaleText)(homesideSwitchCfg.type_name)
  ;
  (self.noticeTypePool):HideAll()
  local notifyList = {}
  for _,homesideInfoCfg in pairs(ConfigData.homeside_info) do
    if homesideInfoCfg.switch_type == homesideSwitchCfg.id and homesideInfoCfg.info_type ~= 0 then
      (table.insert)(notifyList, homesideInfoCfg)
    end
  end
  ;
  (table.sort)(notifyList, function(a, b)
    -- function num : 0_1_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,homesideInfoCfg in ipairs(notifyList) do
    if homesideInfoCfg.id ~= 100 or FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Friend) then
      local item = (self.noticeTypePool):GetOne()
      item:InitNotifyItem(homesideInfoCfg, noticeSwitchOffDic[homesideInfoCfg.id])
    end
  end
end

UINNotifySettingItemGroup.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINNotifySettingItemGroup

