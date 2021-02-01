-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOasisResItem = class("UINOasisResItem", UIBaseNode)
local base = UIBaseNode
UINOasisResItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self._OnClickRoot)
  self._loopScaleTweenPlaying = false
end

UINOasisResItem.InitOasisResItem = function(self, itemId, buildingId)
  -- function num : 0_1 , upvalues : _ENV
  self.buildingId = buildingId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.gameObject).name = tostring(buildingId)
  local itemCfg = (ConfigData.item)[itemId]
  if itemCfg == nil then
    return 
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_ItemIcon).sprite = CRH:GetSprite(itemCfg.icon)
end

UINOasisResItem.RefreshOasisResItemPos = function(self, position)
  -- function num : 0_2 , upvalues : _ENV
  local anchorPos = UIManager:World2UIPosition(position)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = anchorPos
end

UINOasisResItem.RefreshOasisResItemState = function(self, progress)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Fill).fillAmount = progress
  self:PlayOasisResMaxTween(progress >= 1)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINOasisResItem.RefreshOasisResItemScale = function(self, scale)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).localScale = Vector3.one * scale
end

UINOasisResItem._OnClickRoot = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local ctrl = ControllerManager:GetController(ControllerTypeId.OasisController)
  if ctrl ~= nil then
    ctrl:CollectOasisRes(self.buildingId)
  end
end

UINOasisResItem.PlayOasisResItemShowTween = function(self)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  (((self.ui).showTween).transform).localScale = Vector3.one * 0.5
  ;
  ((self.ui).showTween):DORestart()
end

UINOasisResItem.PlayOasisResMaxTween = function(self, play)
  -- function num : 0_7 , upvalues : _ENV
  if self._loopScaleTweenPlaying == play then
    return 
  end
  self._loopScaleTweenPlaying = play
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if play then
    (((self.ui).loopScaleTween).transform).localScale = Vector3.one
    ;
    ((self.ui).loopScaleTween):DORestart()
  else
    ;
    ((self.ui).loopScaleTween):DOKill()
  end
end

UINOasisResItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINOasisResItem

