local UITDProcessView = class("UITDProcessView", UIBaseWindow)
local base = UIBaseWindow
local UINTDLevelView = require("Game.BattleTowerDefence.UI.UINTDLevelView")
local UINTDProcessViewItem = require("Game.BattleTowerDefence.UI.UINTDProcessViewItem")
UITDProcessView.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINTDLevelView, _ENV, UINTDProcessViewItem
  self.uINTDLevel = (UINTDLevelView.New)()
  ;
  (self.uINTDLevel):Init((self.ui).uINTDLevel)
  self.viewItemPool = (UIItemPool.New)(UINTDProcessViewItem, (self.ui).obj_processItem)
  ;
  ((self.ui).obj_processItem):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_buttom, self, self.OnCloseClick)
  self.diff = 0
  self.curCount = 0
  self.totalCount = 0
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Bar).fillAmount = 0
end

UITDProcessView.RefreshTDProcessView = function(self, totalCount, curCount, beforeCount, closeFunc)
  -- function num : 0_1 , upvalues : _ENV
  if totalCount == nil or totalCount == 0 then
    error("UITDProcessView totalCount is nil or 0")
    return 
  end
  if curCount == nil or curCount == 0 then
    error("UITDProcessView curCount is nil or 0")
    return 
  end
  self.closeFunc = closeFunc
  self.diff = curCount - beforeCount
  self.curCount = curCount
  self.totalCount = totalCount
  self.isAdd = self.diff > 0
  ;
  (self.uINTDLevel):InitTDLevelView(totalCount, self.curCount - self.diff)
  ;
  ((self.ui).obj_barNode):SetActive(totalCount > 1)
  self:_InitViewItem(totalCount, curCount)
  self:_InitTween(curCount)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UITDProcessView._InitViewItem = function(self, totalCount, curCount)
  -- function num : 0_2 , upvalues : _ENV
  (self.viewItemPool):HideAll()
  local single = function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    return (Vector3.New)((self.ui).int_barLength / 2, 0, 0)
  end

  local mult = function(lenUnit, i)
    -- function num : 0_2_1 , upvalues : _ENV
    return (Vector3.New)(lenUnit * (i - 1), 0, 0)
  end

  local lenUnit = (self.ui).int_barLength / (totalCount - 1)
  for i = 1, totalCount do
    local item = (self.viewItemPool):GetOne()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R11 in 'UnsetPending'

    if totalCount ~= 1 or not single() then
      do
        (item.transform).localPosition = mult(lenUnit, i)
        item:InitTDProcessViewItem(i < curCount)
        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UITDProcessView._InitTween = function(self, curCount)
  -- function num : 0_3
  if self.selItem ~= nil then
    (self.selItem):DOTweenKill()
  end
  ;
  ((self.ui).img_Bar):DOKill(true)
  local selItem = ((self.viewItemPool).listItem)[curCount]
  if selItem ~= nil then
    self.selItem = selItem
  end
  local fillAmount = 0
  if curCount - 1 > 0 then
    fillAmount = (curCount - 1) / (self.totalCount - 1)
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Bar).fillAmount = (curCount - self.diff - 1) / (self.totalCount - 1)
  end
  local duraction = fillAmount > 0 and self.isAdd and 1 or 0
  ;
  (((self.ui).img_Bar):DOFillAmount(fillAmount, duraction)):OnComplete(function()
    -- function num : 0_3_0 , upvalues : self, fillAmount, curCount
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    ((self.ui).img_Bar).fillAmount = fillAmount
    ;
    (self.selItem):PlayScaleTween()
    ;
    (self.uINTDLevel):InitTDLevelView(self.totalCount, curCount)
    ;
    (self.uINTDLevel):PlayFx()
  end
)
end

UITDProcessView.OnCloseClick = function(self)
  -- function num : 0_4
  self:Hide()
  if self.closeFunc ~= nil then
    (self.closeFunc)()
  end
end

UITDProcessView.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.uINTDLevel):Delete()
  ;
  (self.viewItemPool):DeleteAll()
  ;
  ((self.ui).img_Bar):DOKill()
  ;
  (base.OnDelete)(self)
end

return UITDProcessView

