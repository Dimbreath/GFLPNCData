-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrSWaveRing = class("UINLtrSWaveRing", UIBaseNode)
local base = UIBaseNode
local cs_Material = (CS.UnityEngine).Material
UINLtrSWaveRing.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrSWaveRing.InitLtrSWaveRing = function(self, pos, color)
  -- function num : 0_1 , upvalues : _ENV, cs_Material
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.transform).anchoredPosition = pos
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).sizeDelta = Vector2.zero
  ;
  ((self.ui).dtAnim):DORestart()
  if self.mat == nil then
    self.mat = cs_Material(((self.ui).img).material)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img).material = self.mat
  end
  ;
  (self.mat):SetColor("_Maincolor", color)
end

UINLtrSWaveRing.OnDelete = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  DestroyUnityObject(self.mat)
  self.mat = nil
  ;
  (base.OnDelete)(self)
end

return UINLtrSWaveRing

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrSWaveRing = class("UINLtrSWaveRing", UIBaseNode)
local base = UIBaseNode
local cs_Material = (CS.UnityEngine).Material
UINLtrSWaveRing.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrSWaveRing.InitLtrSWaveRing = function(self, pos, color)
    -- function num : 0_1 , upvalues : _ENV, cs_Material
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

    (self.transform).anchoredPosition = pos -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.transform).sizeDelta = Vector2.zero;
    ((self.ui).dtAnim):DORestart()
    if self.mat == nil then
        self.mat = cs_Material(((self.ui).img).material) -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img).material = self.mat
    end
    (self.mat):SetColor("_Maincolor", color)
end

UINLtrSWaveRing.OnDelete = function(self)
    -- function num : 0_2 , upvalues : _ENV, base
    DestroyUnityObject(self.mat)
    self.mat = nil;
    (base.OnDelete)(self)
end

return UINLtrSWaveRing

