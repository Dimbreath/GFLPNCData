local DormFightHelper = require("Game.Fight.DormFightHelper")
local DormFightConst = require("Game.Fight.DormFightConst")
local Property2Name = {}
Property2Name[(DormFightConst.PropertyEnum).MoveSpeed] = "移动速度"
Property2Name[(DormFightConst.PropertyEnum).RunSpeed] = "跑步速度"
Property2Name[(DormFightConst.PropertyEnum).AcceleratedVelocity] = "加速度"
Property2Name[(DormFightConst.PropertyEnum).NegativeAcceleratedVelocity] = "减速度"
Property2Name[(DormFightConst.PropertyEnum).HitShieldTime] = "被击僵直时间"
Property2Name[(DormFightConst.PropertyEnum).MaxVitality] = "最大体力值"
Property2Name[(DormFightConst.PropertyEnum).InitialVitality] = "初始体力值"
Property2Name[(DormFightConst.PropertyEnum).IdleVitalityResumeRate] = "静止状态体力回复速率"
Property2Name[(DormFightConst.PropertyEnum).WalkVitalityResumeRate] = "行走状态体力回复速率"
Property2Name[(DormFightConst.PropertyEnum).RunVitalityResumeRate] = "跑动状态体力回复速率"
Property2Name[(DormFightConst.PropertyEnum).AttackVitalityResumeRate] = "攻击状态体力回复速率"
Property2Name[(DormFightConst.PropertyEnum).HitVitalityResumeRate] = "被击状态体力回复速率"
Property2Name[(DormFightConst.PropertyEnum).KnockOutVitalityResumeRate] = "击飞状态体力回复速率"
Property2Name[(DormFightConst.PropertyEnum).AttackedVitalityLoss] = "被攻击体力损失值"
Property2Name[(DormFightConst.PropertyEnum).HitWallVitalityLoss] = "击中墙体体力损失值"
Property2Name[(DormFightConst.PropertyEnum).KnockOutVitalityRate] = "击飞体力比例"
Property2Name[(DormFightConst.PropertyEnum).HitForceStrength] = "击中力度"
Property2Name[(DormFightConst.PropertyEnum).KnockOutForceStrength] = "击飞力度"
Property2Name[(DormFightConst.PropertyEnum).KnockOutLieDownInterval] = "击飞后倒地时间"
Property2Name[(DormFightConst.PropertyEnum).RotateRatio] = "转向速率"
Property2Name[(DormFightConst.PropertyEnum).AttackShieldInterval] = "攻击屏蔽时间"
Property2Name[(DormFightConst.PropertyEnum).AttackAutoAdjustSqrDistance] = "攻击自动转向距离的平方"
Property2Name[(DormFightConst.PropertyEnum).KnockOutGetUpInterval] = "击飞后站起时间"
Property2Name[(DormFightConst.PropertyEnum).KnockOutBasicRatio] = "击飞初始概率"
Property2Name[(DormFightConst.PropertyEnum).KnockOutRatioUpRate] = "击飞概率提升比例"
local UIFightDebugItem = class("UIFightDebugItem", UIBaseNode)
UIFightDebugItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIFightDebugItem.InitWithProperty = function(self, id, name)
  -- function num : 0_1 , upvalues : _ENV, DormFightHelper
  self._propertyId = id
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).txt_name).text = name
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).inputField).text = tostring((DormFightHelper.GetPropertyValue)(self._propertyId))
end

UIFightDebugItem.GetValue = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return tonumber(((self.ui).inputField).text) or 0
end

local UIFightDebug = class("UIFightDebug", UIBaseWindow)
UIFightDebug.OnInit = function(self)
  -- function num : 0_3 , upvalues : _ENV, UIFightDebugItem, Property2Name
  self._itemPool = (UIItemPool.New)(UIFightDebugItem, (self.ui).item)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Debug, self, self.OnDebugBtnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RestartS, self, self.OnRestartSingleBtnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RestartD, self, self.OnRestartDoubleBtnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Save, self, self.OnSaveBtnClick)
  self._items = {}
  for propertyId,propertyName in pairs(Property2Name) do
    local item = (self._itemPool):GetOne()
    item:InitWithProperty(propertyId, propertyName)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._items)[propertyId] = item
  end
end

UIFightDebug.OnDebugBtnClick = function(self)
  -- function num : 0_4
  local active = ((self.ui).debugNode).activeSelf
  ;
  ((self.ui).debugNode):SetActive(not active)
end

UIFightDebug.OnRestartSingleBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  dormFightCtrl:DebugRestartSingleMode()
end

UIFightDebug.OnRestartDoubleBtnClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  dormFightCtrl:DebugRestartDoubleMode()
end

UIFightDebug.OnSaveBtnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV, DormFightHelper
  for propertyId,item in pairs(self._items) do
    (DormFightHelper.SetPropertyValue)(propertyId, item:GetValue())
  end
  ;
  (DormFightHelper.SavePropertyValue)()
end

UIFightDebug.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (UIBaseWindow.OnDelete)(self)
  if self._itemPool ~= nil then
    (self._itemPool):DeleteAll()
    self._itemPool = nil
  end
end

return UIFightDebug

