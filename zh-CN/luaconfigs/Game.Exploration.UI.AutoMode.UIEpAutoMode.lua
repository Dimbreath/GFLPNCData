-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpAutoMode = class("UIEpAutoMode", UIBaseWindow)
local base = UIBaseWindow
local UINEpAutoOperator = require("Game.Exploration.UI.AutoMode.UINEpAutoOperator")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpAutoMode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_AutoMask, self, self.OnBtnAutoMaskClicked)
  ;
  ((self.ui).autoOperator):SetActive(false)
end

UIEpAutoMode.SetAutoTitleActive = function(self, active)
  -- function num : 0_1
  ((self.ui).autoTitle):SetActive(active)
end

UIEpAutoMode.SetAutoOperatorActive = function(self, active, bindParent)
  -- function num : 0_2 , upvalues : UINEpAutoOperator, _ENV
  if active then
    self.autoOperatorNode = (UINEpAutoOperator.New)()
    local operatorObject = ((self.ui).autoOperator):Instantiate(bindParent)
    operatorObject:SetActive(true)
    ;
    (self.autoOperatorNode):Init(operatorObject)
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.autoOperatorNode).transform).localPosition = Vector3.zero
    ;
    (self.autoOperatorNode):BindAutoParent(bindParent)
  else
    do
      if self.autoOperatorNode ~= nil and not IsNull((self.autoOperatorNode).gameObject) then
        (self.autoOperatorNode):Delete()
      end
      self.autoOperatorNode = nil
    end
  end
end

UIEpAutoMode.SetAutoOperatorText = function(self, second)
  -- function num : 0_3 , upvalues : _ENV
  if self.autoOperatorNode ~= nil then
    if not IsNull((self.autoOperatorNode).gameObject) then
      (self.autoOperatorNode):UpdateAutoOperatorText(second)
    else
      self.autoOperatorNode = nil
    end
  end
end

UIEpAutoMode.SetAutoTitleState = function(self, tileType, second)
  -- function num : 0_4 , upvalues : ExplorationEnum, _ENV
  if tileType == (ExplorationEnum.eAutoTitleType).Normal then
    ((self.ui).tex_Auto):SetIndex((ExplorationEnum.eAutoTitleType).Normal)
  else
    ;
    ((self.ui).tex_Auto):SetIndex(tileType, tostring(second or 0))
  end
end

UIEpAutoMode.SetAutoMaskActive = function(self, active)
  -- function num : 0_5
  (((self.ui).btn_AutoMask).gameObject):SetActive(active)
end

UIEpAutoMode.OnBtnAutoMaskClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if ExplorationManager.epCtrl == nil then
    return 
  end
  self:SetAutoMaskActive(false)
  self:SetAutoTitleActive(false)
  self:SetAutoOperatorActive(false)
  ;
  ((ExplorationManager.epCtrl).autoCtrl):DisableEpAutoMode()
end

UIEpAutoMode.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  if self.autoOperatorNode ~= nil and not IsNull((self.autoOperatorNode).gameObject) then
    (self.autoOperatorNode):Delete()
  end
  self.autoOperatorNode = nil
  ;
  (base.OnDelete)(self)
end

return UIEpAutoMode

