local UINBattlePassLimitItem = class("UINBattlePassLimitItem", UIBaseNode)
local base = UIBaseNode
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINBattlePassLimitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Base, self, self.OnPassBaseItemClicked)
  self.baseItem = (UINBaseItemWithCount.New)()
  ;
  (self.baseItem):Init((self.ui).baseItem)
end

UINBattlePassLimitItem.UpdatePassLimitItemUI = function(self, passInfo, clickEvent)
  -- function num : 0_1 , upvalues : _ENV, BattlePassEnum
  local passCfg = passInfo.passCfg
  self.clickEvent = clickEvent
  local itemId = passCfg.limit_reward_id
  local itemCount = passCfg.limit_reward_num
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = ">" .. tostring(passInfo.maxlevel)
  local notakenCount = passInfo:GetNoTakenLimitRewardCount()
  self.notakenCount = notakenCount
  if notakenCount > 0 then
    itemCount = notakenCount * itemCount
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Base).color = BattlePassEnum.pickColor
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Base).color = Color.white
  end
  local itemCfg = (ConfigData.item)[itemId]
  ;
  (self.baseItem):InitItemWithCount(itemCfg, itemCount, nil)
  ;
  ((self.ui).obj_lock):SetActive(self.notakenCount <= 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINBattlePassLimitItem.OnPassBaseItemClicked = function(self)
  -- function num : 0_2
  if self.notakenCount <= 0 then
    return 
  end
  if self.clickEvent ~= nil then
    (self.clickEvent)()
  end
end

UINBattlePassLimitItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattlePassLimitItem

