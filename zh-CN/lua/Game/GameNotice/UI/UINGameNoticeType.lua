local UINGameNoticeType = class("UINGameNoticeType", UIBaseNode)
local base = UIBaseNode
UINGameNoticeType.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Item, self, self._OnValueChange)
end

UINGameNoticeType.InitGameNoticType = function(self, typeId, callback)
  -- function num : 0_1
  self._typeId = typeId
  self._onClickCallback = callback
  self:SetBlueDotActive(typeId)
end

UINGameNoticeType.SetNoticeTypeIsOn = function(self, isOn)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_Item).isOn = isOn
end

UINGameNoticeType._OnValueChange = function(self, bool)
  -- function num : 0_3 , upvalues : _ENV
  local rgb = bool and 0 or 1
  local alpha = bool and 0.8 or 0.5
  local col = (Color.New)(rgb, rgb, rgb, alpha)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_State).color = col
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_State).color = col
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = col
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Sel).enabled = bool
  if not bool then
    return 
  end
  if self._onClickCallback ~= nil then
    (self._onClickCallback)(self._typeId)
  end
end

UINGameNoticeType.SetBlueDotActive = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.redDotFunc == nil then
    self.redDotFunc = BindCallback(self, self.OnRedDotCallback)
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.GameNotice, self._typeId)
  if ok then
    (self.redDotFunc)(node)
    RedDotController:AddListener(node.nodePath, self.redDotFunc)
    self.nodePath = node.nodePath
  end
end

UINGameNoticeType.OnRedDotCallback = function(self, node)
  -- function num : 0_5
  self:SetBlueDot(node:GetRedDotCount() > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINGameNoticeType.SetBlueDot = function(self, active)
  -- function num : 0_6
  ((self.ui).blueDot):SetActive(active)
end

UINGameNoticeType.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  if self.nodePath ~= nil then
    RedDotController:RemoveListener(self.nodePath, self.redDotFunc)
  end
  ;
  (base.OnDelete)(self)
end

return UINGameNoticeType

