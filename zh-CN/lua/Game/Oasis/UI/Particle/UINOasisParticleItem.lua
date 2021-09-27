local UINOasisParticleItem = class("UINOasisParticleItem", UIBaseNode)
local base = UIBaseNode
local cs_Material = (CS.UnityEngine).Material
UINOasisParticleItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.onParticlOver = BindCallback(self, self.OnParticlOver)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).resParticleSys).onAllOver = self.onParticlOver
end

UINOasisParticleItem.InitParticleItem = function(self, resId, resUiPos, targetPos, onResFlyAniOver, num)
  -- function num : 0_1
  if targetPos == nil then
    return 
  end
  self.targetPos = targetPos
  self.onResFlyAniOver = onResFlyAniOver
  self:SetResItemPic(resId)
  self:UpdateRootPos(resUiPos)
  ;
  ((self.ui).resParticleSys):InitOasisResItemParticle(targetPos, num)
  ;
  ((self.ui).resParticleSys):ParticlePlay()
end

UINOasisParticleItem.UpdateRootPos = function(self, resUiPos)
  -- function num : 0_2 , upvalues : _ENV
  local anchorPos = UIManager:World2UIPosition(resUiPos)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = anchorPos
end

UINOasisParticleItem.SetResItemPic = function(self, resId)
  -- function num : 0_3 , upvalues : _ENV
  local cfg = (ConfigData.item)[resId]
  if cfg == nil then
    return 
  end
  local sprite = CRH:GetSprite(cfg.icon)
  ;
  ((self.ui).resParticleSys):SetParticleMatarailBySprite(sprite)
end

UINOasisParticleItem.OnParticlOver = function(self)
  -- function num : 0_4
  ((self.ui).resParticleSys):ParticleReset()
  if self.onResFlyAniOver ~= nil then
    (self.onResFlyAniOver)(self)
  else
    self:Hide()
  end
end

UINOasisParticleItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  ((self.ui).resParticleSys):ParticleReset()
  ;
  (base.OnDelete)(self)
end

return UINOasisParticleItem

