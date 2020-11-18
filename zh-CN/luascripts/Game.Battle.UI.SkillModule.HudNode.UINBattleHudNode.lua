-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBattleHudNode = class("UINBattleHudNode", UIBaseNode)
local base = UIBaseNode
local UINHudItem = require("Game.Battle.UI.SkillModule.HudNode.UINHudItem")
local StartHudValue = 30
local EndHudValue = 150
local itemHudSize = 30
UINBattleHudNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.scrollItemDic = {}
end

UINBattleHudNode.InitBattleHud = function(self, camera)
  -- function num : 0_1 , upvalues : _ENV, EndHudValue, StartHudValue
  self.camera = camera
  self.camHudTimer = (TimerManager:GetTimer(1, self.RefreshBattleHudCamera, self)):Start()
  local totalCount = (EndHudValue - StartHudValue) / 30
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = totalCount
  ;
  ((self.ui).scrollRect):RefillCells()
end

UINBattleHudNode.RefreshBattleHudCamera = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if IsNull(self.camera) then
    return 
  end
  local pos = ((self.camera).transform).position
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_PosX).text = GetPreciseDecimalStr(pos.x, 4)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_PosY).text = GetPreciseDecimalStr(pos.y, 4)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_PosZ).text = GetPreciseDecimalStr(pos.z, 4)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_FOV).text = GetPreciseDecimalStr((self.camera).fieldOfView, 4)
  local angle = ((self.camera).transform).eulerAngles
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_RoteX).text = GetPreciseDecimalStr(angle.x, 4)
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_RoteY).text = GetPreciseDecimalStr(angle.y, 4)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_RoteZ).text = GetPreciseDecimalStr(angle.z, 4)
  local rotation = ((self.camera).transform).rotation
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_QuaX).text = GetPreciseDecimalStr(rotation.x, 4)
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_QuaY).text = GetPreciseDecimalStr(rotation.y, 4)
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_QuaZ).text = GetPreciseDecimalStr(rotation.z, 4)
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_QuaW).text = GetPreciseDecimalStr(rotation.w, 4)
end

UINBattleHudNode.RefreshHudScroll = function(self, value)
  -- function num : 0_3
  local normalPos = ((self.ui).scrollRect).normalizedPosition
  normalPos.y = 1 - value
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).normalizedPosition = normalPos
end

UINBattleHudNode.__OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UINHudItem
  local item = (UINHudItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.scrollItemDic)[go] = item
end

UINBattleHudNode.__OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV, EndHudValue, StartHudValue, itemHudSize
  local item = (self.scrollItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local startNum = EndHudValue - (StartHudValue + index * itemHudSize)
  item:RefreshHudItem(startNum)
end

UINBattleHudNode.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  if self.camHudTimer ~= nil then
    (self.camHudTimer):Stop()
    self.camHudTimer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINBattleHudNode

