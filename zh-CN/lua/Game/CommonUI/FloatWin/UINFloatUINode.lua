local UINFloatUINode = class("UINFloatUINode", UIBaseNode)
local base = UIBaseNode
local cs_Screen = (CS.UnityEngine).Screen
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINFloatUINode.OnInit = function(self)
  -- function num : 0_0
  self.oldtargetTransform = nil
  self.oldtargetScreenConers = nil
end

UINFloatUINode.FloatTo = function(self, transform, horizontalAlign, verticalAlign, shiftX, shiftY, customTargetCamer)
  -- function num : 0_1 , upvalues : _ENV, HAType, VAType
  if not shiftX then
    shiftX = 0
  end
  if not shiftY then
    shiftY = 0
  end
  local x = 0
  local y = 0
  local pivotx = 0.5
  local pivoty = 0.5
  local targetScreenConers = {}
  if self.oldtargetTransform == transform then
    targetScreenConers = self.oldtargetScreenConers
  else
    local targetWorldConersArray = transform:ExGetWorldCorners()
    for i = 0, targetWorldConersArray.Length - 1 do
      if targetWorldConersArray[i] ~= nil then
        if not customTargetCamer then
          do
            targetScreenConers[i + 1] = UIManager:World2UIPosition(targetWorldConersArray[i], nil, UIManager.UICamera, UIManager.UICamera)
            -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC39: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    self.oldtargetScreenConers = targetScreenConers
    self.oldtargetTransform = transform
  end
  do
    if horizontalAlign == HAType.left then
      x = (targetScreenConers[1]).x
      pivotx = 0
    else
      if horizontalAlign == HAType.right then
        x = (targetScreenConers[4]).x
        pivotx = 1
      else
        if horizontalAlign == HAType.center then
          x = ((targetScreenConers[1]).x + (targetScreenConers[4]).x) / 2
          pivotx = 0.5
        else
          if horizontalAlign == HAType.autoCenter then
            x = ((targetScreenConers[1]).x + (targetScreenConers[4]).x) / 2
            pivotx = 0.5
            local screenMiddlePointX = x
            local leftX = screenMiddlePointX - ((self.transform).sizeDelta).x / 2
            local rightX = screenMiddlePointX + ((self.transform).sizeDelta).x / 2
            local helfScreen = (UIManager.BackgroundStretchSize).x / 2
            if leftX < -helfScreen then
              x = (targetScreenConers[1]).x
              pivotx = 0
            else
              if helfScreen < rightX then
                x = (targetScreenConers[4]).x
                pivotx = 1
              end
            end
          end
        end
      end
    end
    do
      local targetHeight = (targetScreenConers[1]).y - (targetScreenConers[2]).y
      if verticalAlign == VAType.up then
        y = (targetScreenConers[2]).y + shiftY * ((targetScreenConers[2]).y - (targetScreenConers[1]).y)
        pivoty = 0
      else
        if verticalAlign == VAType.down then
          y = (targetScreenConers[1]).y - shiftY * ((targetScreenConers[2]).y - (targetScreenConers[1]).y)
          pivoty = 1
        end
      end
      -- DECOMPILER ERROR at PC142: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self.transform).pivot = (Vector2.New)(pivotx, pivoty)
      -- DECOMPILER ERROR at PC149: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self.transform).localPosition = (Vector2.New)(x, y)
    end
  end
end

UINFloatUINode.AutoFlotTo = function(self, transform, judgeWorldPoint)
  -- function num : 0_2
end

return UINFloatUINode

