local UIBattleEffectGirdInfo = class("UIBattleEffectGirdInfo", UIBaseWindow)
local base = UIBaseWindow
local UINBattleGirdInfoNode = require("Game.Battle.UI.Grid.UINBattleGirdInfoNode")
UIBattleEffectGirdInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINBattleGirdInfoNode, _ENV
  self.battleGirdInfoNode = (UINBattleGirdInfoNode.New)()
  ;
  (self.battleGirdInfoNode):Init((self.ui).battleGirdInfoNode)
  self.gridInfoSizeDelta = ((self.battleGirdInfoNode).transform).sizeDelta
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.gridInfoSizeDelta).y = 0
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  ;
  ((((CS.Lean).Touch).LeanTouch).OnFingerDown)("+", self.__onFingerDown)
end

UIBattleEffectGirdInfo.InitBattleGridInfo = function(self, dynEffectGrid, worldPos)
  -- function num : 0_1 , upvalues : _ENV
  local position = (UIManager:World2UIPosition(worldPos))
  local offsetRatio = nil
  if position.x <= 0 and position.y >= 0 then
    offsetRatio = (Vector2.New)(1, -1)
  else
    if position.x <= 0 and position.y <= 0 then
      offsetRatio = (Vector2.New)(1, 1)
    else
      if position.x >= 0 and position.y <= 0 then
        offsetRatio = (Vector2.New)(-1, 1)
      else
        offsetRatio = (Vector2.New)(-1, -1)
      end
    end
  end
  local arrowOffset = (self.gridInfoSizeDelta / 2 + (self.ui).gridInfoOffset) * offsetRatio + position
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.battleGirdInfoNode).transform).localPosition = (Vector3.New)(arrowOffset.x, arrowOffset.y, 0)
  ;
  (self.battleGirdInfoNode):InitBattleGridInfo(dynEffectGrid)
end

UIBattleEffectGirdInfo.OnFingerDown = function(self)
  -- function num : 0_2
  self:Hide()
end

UIBattleEffectGirdInfo.OnDelete = function(self)
  -- function num : 0_3 , upvalues : _ENV, base
  ((((CS.Lean).Touch).LeanTouch).OnFingerDown)("-", self.__onFingerDown)
  ;
  (base.OnDelete)(self)
end

return UIBattleEffectGirdInfo

