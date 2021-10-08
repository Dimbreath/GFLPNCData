local UINTDBattleHeroHeadItem = class("UINTDBattleHeroHeadItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINTDBattleHeroHeadItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.headItem = (UINHeroHeadItem.New)()
  ;
  (self.headItem):Init((self.ui).heroHeadItem)
  local eventTrigger = ((CS.EventTriggerListener).Get)((self.headItem).gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnDragHero))
  eventTrigger:onClick("+", BindCallback(self, self.OnClickHeroHead))
end

UINTDBattleHeroHeadItem.OnInitHeroItem = function(self, roleEntity, cost, onDragFunc, onClickHeroFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.onDragFunc = onDragFunc
  self.onClickHeroFunc = onClickHeroFunc
  self.dataId = roleEntity.roleDataId
  self.roleEntity = roleEntity
  ;
  (self.headItem):InitHeroHeadItemWithId(roleEntity.roleDataId)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_CostToken).text = tostring(cost)
  ;
  ((self.ui).returnCD):SetActive(false)
  self._cost = cost
end

UINTDBattleHeroHeadItem.OnDragHero = function(self, go, eventData)
  -- function num : 0_2
  if self.onDragFunc ~= nil then
    (self.onDragFunc)(self, eventData)
  end
end

UINTDBattleHeroHeadItem.UpdateCd = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local curCd = (self.roleEntity):GetTDRoleCurCd()
  local totalCd = (self.roleEntity):GetTDRoleCastCd()
  local remainSec = (BattleUtil.FrameToTime)(totalCd - curCd)
  if remainSec > 0 then
    ((self.ui).returnCD):SetActive(true)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_ReCD).text = tostring(remainSec)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).cDImage).fillAmount = (totalCd - curCd) / totalCd
  else
    ;
    ((self.ui).returnCD):SetActive(false)
  end
end

UINTDBattleHeroHeadItem.UpdateCostState = function(self, mp)
  -- function num : 0_4
  ((self.ui).notEnough):SetActive(mp < self._cost)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINTDBattleHeroHeadItem.OnClickHeroHead = function(self)
  -- function num : 0_5
  if self.onClickHeroFunc ~= nil then
    (self.onClickHeroFunc)(self.roleEntity)
  end
end

return UINTDBattleHeroHeadItem

