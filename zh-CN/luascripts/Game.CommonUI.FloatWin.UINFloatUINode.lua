-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFloatUINode = class("UINFloatUINode", UIBaseNode)
local base = UIBaseNode
local cs_Screen = (CS.UnityEngine).Screen
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINFloatUINode.FloatTo = function(self, transform, horizontalAlign, verticalAlign, shiftX, shiftY)
  -- function num : 0_0 , upvalues : HAType, _ENV, cs_Screen, VAType
  if not shiftX then
    shiftX = 0
  end
  if not shiftY then
    shiftY = 0
  end
  local pos = (self.transform).position
  local x = pos.x
  local y = pos.y
  local pivotx = 0.5
  local pivoty = 0.5
  local targetWorldConersArray = transform:ExGetWorldCorners()
  local targetWorldConers = {}
  for i = 0, targetWorldConersArray.Length - 1 do
    if targetWorldConersArray[i] ~= nil then
      targetWorldConers[i + 1] = targetWorldConersArray[i]
    end
  end
  if horizontalAlign == HAType.left then
    x = (targetWorldConers[1]).x
    pivotx = 0
  else
    if horizontalAlign == HAType.right then
      x = (targetWorldConers[4]).x
      pivotx = 1
    else
      if horizontalAlign == HAType.center then
        x = ((targetWorldConers[1]).x + (targetWorldConers[4]).x) / 2
        pivotx = 0.5
      else
        if horizontalAlign == HAType.autoCenter then
          x = ((targetWorldConers[1]).x + (targetWorldConers[4]).x) / 2
          pivotx = 0.5
          local middlePoint = (Vector3.New)(x, y, pos.z)
          local screenMiddlePointX = (UIManager:World2UIPosition(middlePoint, nil, nil, UIManager.UICamera)).x
          local leftX = screenMiddlePointX - ((self.transform).sizeDelta).x / 2
          local rightX = screenMiddlePointX + ((self.transform).sizeDelta).x / 2
          local helfScreen = cs_Screen.width / 2
          if leftX < -helfScreen then
            x = (targetWorldConers[1]).x
            pivotx = 0
          else
            if helfScreen < rightX then
              x = (targetWorldConers[4]).x
              pivotx = 1
            end
          end
        end
      end
    end
  end
  do
    local targetHeight = (targetWorldConers[1]).y - (targetWorldConers[2]).y
    if verticalAlign == VAType.up then
      y = (targetWorldConers[2]).y + shiftY * ((targetWorldConers[2]).y - (targetWorldConers[1]).y)
      pivoty = 0
    else
      if verticalAlign == VAType.down then
        y = (targetWorldConers[1]).y - shiftY * ((targetWorldConers[2]).y - (targetWorldConers[1]).y)
        pivoty = 1
      end
    end
    -- DECOMPILER ERROR at PC138: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self.transform).pivot = (Vector2.New)(pivotx, pivoty)
    -- DECOMPILER ERROR at PC146: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self.transform).position = (Vector3.New)(x, y, pos.z)
  end
end

UINFloatUINode.AutoFlotTo = function(self, transform, judgeWorldPoint)
  -- function num : 0_1
end

return UINFloatUINode

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFloatUINode = class("UINFloatUINode", UIBaseNode)
local base = UIBaseNode
local cs_Screen = (CS.UnityEngine).Screen
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINFloatUINode.FloatTo = function(self, transform, horizontalAlign,
                                  verticalAlign, shiftX, shiftY)
    -- function num : 0_0 , upvalues : HAType, _ENV, cs_Screen, VAType
    if not shiftX then shiftX = 0 end
    if not shiftY then shiftY = 0 end
    local pos = (self.transform).position
    local x = pos.x
    local y = pos.y
    local pivotx = 0.5
    local pivoty = 0.5
    local targetWorldConersArray = transform:ExGetWorldCorners()
    local targetWorldConers = {}
    for i = 0, targetWorldConersArray.Length - 1 do
        if targetWorldConersArray[i] ~= nil then
            targetWorldConers[i + 1] = targetWorldConersArray[i]
        end
    end
    if horizontalAlign == HAType.left then
        x = (targetWorldConers[1]).x
        pivotx = 0
    else
        if horizontalAlign == HAType.right then
            x = (targetWorldConers[4]).x
            pivotx = 1
        else
            if horizontalAlign == HAType.center then
                x = ((targetWorldConers[1]).x + (targetWorldConers[4]).x) / 2
                pivotx = 0.5
            else
                if horizontalAlign == HAType.autoCenter then
                    x = ((targetWorldConers[1]).x + (targetWorldConers[4]).x) /
                            2
                    pivotx = 0.5
                    local middlePoint = (Vector3.New)(x, y, pos.z)
                    local screenMiddlePointX =
                        (UIManager:World2UIPosition(middlePoint, nil, nil,
                                                    UIManager.UICamera)).x
                    local leftX = screenMiddlePointX -
                                      ((self.transform).sizeDelta).x / 2
                    local rightX = screenMiddlePointX +
                                       ((self.transform).sizeDelta).x / 2
                    local helfScreen = cs_Screen.width / 2
                    if leftX < -helfScreen then
                        x = (targetWorldConers[1]).x
                        pivotx = 0
                    else
                        if helfScreen < rightX then
                            x = (targetWorldConers[4]).x
                            pivotx = 1
                        end
                    end
                end
            end
        end
    end
    do
        local targetHeight = (targetWorldConers[1]).y - (targetWorldConers[2]).y
        if verticalAlign == VAType.up then
            y = (targetWorldConers[2]).y + shiftY *
                    ((targetWorldConers[2]).y - (targetWorldConers[1]).y)
            pivoty = 0
        else
            if verticalAlign == VAType.down then
                y = (targetWorldConers[1]).y - shiftY *
                        ((targetWorldConers[2]).y - (targetWorldConers[1]).y)
                pivoty = 1
            end
        end -- DECOMPILER ERROR at PC138: Confused about usage of register: R14 in 'UnsetPending'
        
        (self.transform).pivot = (Vector2.New)(pivotx, pivoty) -- DECOMPILER ERROR at PC146: Confused about usage of register: R14 in 'UnsetPending'
        ;
        (self.transform).position = (Vector3.New)(x, y, pos.z)
    end
end

UINFloatUINode.AutoFlotTo = function(self, transform, judgeWorldPoint)
    -- function num : 0_1
end

return UINFloatUINode

