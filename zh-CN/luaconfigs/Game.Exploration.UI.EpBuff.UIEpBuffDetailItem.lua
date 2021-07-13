-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpBuffDetailItem = class("UIEpBuffDetailItem", UIBaseNode)
local UIEpBuffItem = require("Game.Exploration.UI.EpBuff.UIEpBuffItem")
UIEpBuffDetailItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIEpBuffItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.buffItem = (UIEpBuffItem.New)()
  ;
  (self.buffItem):Init((self.ui).buffItem)
end

UIEpBuffDetailItem.InitEpBuffDetail = function(self, epBuff)
  -- function num : 0_1 , upvalues : _ENV
  local buffCfg = (ConfigData.exploration_buff)[epBuff.dataId]
  if buffCfg == nil then
    error("exploration buff cfg is null,id:" .. tostring(epBuff.dataId))
    return 
  end
  ;
  (self.buffItem):InitEpBuffByCfg(epBuff, buffCfg)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_BuffName).text = (LanguageUtil.GetLocaleText)(buffCfg.name)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_BuffInfomation).text = (LanguageUtil.GetLocaleText)(buffCfg.describe)
  self.expireTm = epBuff.expireTm
  ;
  (((self.ui).tex_BuffTime).gameObject):SetActive(self.expireTm > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpBuffDetailItem.RefershBuffDetailTime = function(self, curTime)
  -- function num : 0_2 , upvalues : _ENV
  if self.expireTm <= 0 then
    return 
  end
  local lastTime = (math.ceil)((math.max)(self.expireTm - curTime, 0))
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_BuffTime).text = TimestampToTime(lastTime)
end

return UIEpBuffDetailItem

