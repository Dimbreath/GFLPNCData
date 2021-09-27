local UINLevelLine = class("UINLevelLine", UIBaseNode)
local base = UIBaseNode
local eLevelLineType = require("Game.Sector.Enum.eLevelLineType")
UINLevelLine.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLevelLine.InitLevelLine = function(self, lineType, startPos, angle, length)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.transform).localPosition = startPos
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).localEulerAngles = (Vector3.New)(0, 0, angle)
  self.length = length
  self:RefreshLevelLineState(lineType)
end

UINLevelLine.RefreshLevelLineState = function(self, lineType)
  -- function num : 0_2 , upvalues : eLevelLineType, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_lineItem).enabled = true
  if lineType == eLevelLineType.BetweenLevel then
    (((self.ui).fill).gameObject):SetActive(true)
    self:__SetLength(self.length, (self.ui).maxWidth, 0)
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_lineItem).color = (Color.New)(1, 1, 1, 0.9)
  else
    if lineType == eLevelLineType.BetweenLevelFull then
      (((self.ui).fill).gameObject):SetActive(true)
      self:__SetLength(self.length, (self.ui).maxWidth, 1)
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_lineItem).enabled = false
    else
      if lineType == eLevelLineType.Decorate then
        (((self.ui).fill).gameObject):SetActive(false)
        self:__SetLength((self.ui).maxLength, (self.ui).minWidth)
      else
        if lineType == eLevelLineType.StoryLine then
          (((self.ui).fill).gameObject):SetActive(false)
        end
      end
    end
  end
end

UINLevelLine.__SetLength = function(self, length, width, fillAmount)
  -- function num : 0_3
  local sizeDelta = (self.transform).sizeDelta
  sizeDelta.x = length
  sizeDelta.y = width
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.transform).sizeDelta = sizeDelta
  if fillAmount ~= nil then
    sizeDelta.x = length * fillAmount
    sizeDelta.y = width + 2
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (((self.ui).fill).transform).sizeDelta = sizeDelta
  end
end

UINLevelLine.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelLine

