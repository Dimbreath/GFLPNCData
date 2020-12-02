-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockNode = class("UINOverclockNode", UIBaseNode)
local base = UIBaseNode
local UINOverclockList = require("Game.Sector.Overclock.UINOverclockList")
UINOverclockNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINOverclockList
  self:Show()
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
  self.overclockList = (UINOverclockList.New)()
  ;
  (self.overclockList):Init((self.ui).obj_overclockList)
  self.__listItemCallBack = BindCallback(self, self.ListItemCallBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnCliclConfirm)
end

UINOverclockNode.InitNode = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local data = (ConfigData.buildingLevel).overclockItemUnlockDic
  ;
  (self.overclockList):InitList(data, self.__listItemCallBack)
  self:RefreshAssembleNum()
end

UINOverclockNode.ListItemCallBack = function(self, isSelected, costG)
  -- function num : 0_2
  if isSelected then
    if not (self.OverclockCtrl):AddAssembleNum() then
      return false
    end
    if not (self.OverclockCtrl):AddAdvancedGNum(costG) then
      (self.OverclockCtrl):MinAssembleNum()
      return false
    end
  else
    if not (self.OverclockCtrl):MinAssembleNum() then
      return false
    end
    if not (self.OverclockCtrl):MinAdvancedGNum(costG) then
      (self.OverclockCtrl):AddAssembleNum()
      return false
    end
  end
  self:RefreshAssembleNum()
  return true
end

UINOverclockNode.OnCliclConfirm = function(self)
  -- function num : 0_3
  (self.OverclockCtrl):OnConfirm()
  ;
  (self.OverclockCtrl):CloseOverclockUI()
end

UINOverclockNode.RefreshAssembleNum = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local curAssembleNum, maxAssembleNum = (self.OverclockCtrl):GetAssembleNum()
  ;
  ((self.ui).tex_assembleNum):SetIndex(0, tostring(curAssembleNum), tostring(maxAssembleNum))
  local unitOrangeSizeDelta = ((self.ui).img_UnitOrange).sizeDelta
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_UnitOrange).sizeDelta = (Vector2.New)(curAssembleNum * 65, unitOrangeSizeDelta.y)
  local unitSlotSizeDelta = ((self.ui).img_UnitSlot).sizeDelta
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_UnitSlot).sizeDelta = (Vector2.New)(maxAssembleNum * 65, unitSlotSizeDelta.y)
end

UINOverclockNode.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINOverclockNode

