-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFloatFrame = class("UIFloatFrame", UIBaseWindow)
local base = UIBaseWindow
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")
UIFloatFrame.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINFloatUINode
  self.floatFrame = (UINFloatUINode.New)()
  ;
  (self.floatFrame):Init(((self.ui).frame).gameObject)
end

UIFloatFrame.SetTitleAndContext = function(self, title, context)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Title).text = title
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = context
end

UIFloatFrame.FloatTo = function(self, transform, horizontalAlign, verticalAlign, shiftX, shiftY)
  -- function num : 0_2
  (self.floatFrame):FloatTo(transform, horizontalAlign, verticalAlign, shiftX, shiftY)
end

UIFloatFrame.Copy3DModifier = function(self, comp_3dModifier)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).comp_3dModifier).rotation = comp_3dModifier.rotation
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).comp_3dModifier).position = comp_3dModifier.position
  ;
  ((self.ui).comp_3dModifier):RefreshGraphics()
end

UIFloatFrame.Clean3DModifier = function(self)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).comp_3dModifier).rotation = (Vector3.New)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).comp_3dModifier).position = (Vector3.New)()
  ;
  ((self.ui).comp_3dModifier):RefreshGraphics()
end

UIFloatFrame.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIFloatFrame

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFloatFrame = class("UIFloatFrame", UIBaseWindow)
local base = UIBaseWindow
local UINFloatUINode = require("Game.CommonUI.FloatWin.UINFloatUINode")
UIFloatFrame.OnInit = function(self)
    -- function num : 0_0 , upvalues : UINFloatUINode
    self.floatFrame = (UINFloatUINode.New)();
    (self.floatFrame):Init(((self.ui).frame).gameObject)
end

UIFloatFrame.SetTitleAndContext = function(self, title, context)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).tex_Title).text = title -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_Content).text = context
end

UIFloatFrame.FloatTo = function(self, transform, horizontalAlign, verticalAlign,
                                shiftX, shiftY)
    -- function num : 0_2
    (self.floatFrame):FloatTo(transform, horizontalAlign, verticalAlign, shiftX,
                              shiftY)
end

UIFloatFrame.Copy3DModifier = function(self, comp_3dModifier)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).comp_3dModifier).rotation = comp_3dModifier.rotation -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).comp_3dModifier).position = comp_3dModifier.position;
    ((self.ui).comp_3dModifier):RefreshGraphics()
end

UIFloatFrame.Clean3DModifier = function(self)
    -- function num : 0_4 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).comp_3dModifier).rotation = (Vector3.New)() -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).comp_3dModifier).position = (Vector3.New)();
    ((self.ui).comp_3dModifier):RefreshGraphics()
end

UIFloatFrame.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UIFloatFrame

