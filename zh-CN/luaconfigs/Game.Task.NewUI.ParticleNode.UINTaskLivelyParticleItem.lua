-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTaskLivelyParticleItem = class("UINTaskLivelyParticleItem", UIBaseNode)
local base = UIBaseNode
UINTaskLivelyParticleItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).resParticleSys).onAllOver = BindCallback(self, self._OnParticlOver)
end

UINTaskLivelyParticleItem.InitTaskLivelyParticleItem = function(self, startPos, tarPos, flyOverFunc)
  -- function num : 0_1
  self.flyOverFunc = flyOverFunc
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).position = startPos
  ;
  ((self.ui).resParticleSys):InitOasisResItemParticle(tarPos, 8)
  ;
  ((self.ui).resParticleSys):ParticlePlay()
end

UINTaskLivelyParticleItem._OnParticlOver = function(self)
  -- function num : 0_2
  ((self.ui).resParticleSys):ParticleReset()
  if self.flyOverFunc ~= nil then
    (self.flyOverFunc)(self)
  end
end

UINTaskLivelyParticleItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINTaskLivelyParticleItem

