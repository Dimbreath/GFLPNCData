local UINEventWeChatItem = class("UINEventWeChatItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINEventWeChatItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINEventWeChatItem.InitWeChatItem = function(self, awardCfg, awardId, awardCount, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.awardCfg = awardCfg
  self.awardId = awardId
  self.awardCount = awardCount
  self.resloader = resloader
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  if self.awardCount > 1 then
    ((self.ui).tex_TotalCount).text = tostring(self.awardCount)
  else
    ;
    ((self.ui).count):SetActive(false)
  end
  ;
  (self.baseItem):SetNotNeedAnyJump(true)
  ;
  (self.baseItem):InitBaseItem(awardCfg)
end

UINEventWeChatItem.RefreshItem = function(self, flag)
  -- function num : 0_2
  ((self.ui).obj_isPicked):SetActive(flag)
  if flag then
    (self.baseItem):CloseGreatRewardLoopFx()
  end
end

UINEventWeChatItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINEventWeChatItem

