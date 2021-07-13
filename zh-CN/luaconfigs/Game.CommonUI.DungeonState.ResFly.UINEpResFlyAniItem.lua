-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpResFlyAniItem = class("UINEpResFlyAniItem", UIBaseNode)
UINEpResFlyAniItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).resParticleSys).onAllOver = BindCallback(self, self.OnParticlOver)
end

UINEpResFlyAniItem.InitResFlyAniItem = function(self, resId, resUiPos, targetPos, onResFlyOver, count)
  -- function num : 0_1
  self.targetPos = targetPos
  self.onResFlyOver = onResFlyOver
  self:SetResItemPic(resId)
  self:UpdateRootPos(resUiPos)
  if targetPos ~= nil then
    ((self.ui).resParticleSys):InitOasisResItemParticle(targetPos, count)
    ;
    ((self.ui).resParticleSys):ParticlePlay()
  end
end

UINEpResFlyAniItem.UpdateRootPos = function(self, resUiPos)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).localPosition = resUiPos
end

UINEpResFlyAniItem.SetResItemPic = function(self, resId)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = (ConfigData.item)[resId]
  if cfg == nil then
    return 
  end
  local sprite = CRH:GetSprite(cfg.icon)
  ;
  ((self.ui).resParticleSys):SetParticleMatarailBySprite(sprite)
end

UINEpResFlyAniItem.OnParticlOver = function(self)
  -- function num : 0_4
  ((self.ui).resParticleSys):ParticleReset()
  ;
  (self.onResFlyOver)(self)
end

return UINEpResFlyAniItem

