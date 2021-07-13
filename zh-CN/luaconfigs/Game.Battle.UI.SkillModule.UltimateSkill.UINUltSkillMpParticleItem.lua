-- params : ...
-- function num : 0 , upvalues : _ENV
local UINUltSkillMpParticleItem = class("UINUltSkillMpParticleItem", UIBaseNode)
local base = UIBaseNode
UINUltSkillMpParticleItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).moveTween).onComplete):AddListener(BindCallback(self, self.OnMoveTweenComplete))
  self.psEmission = ((self.ui).particle).emission
  self.psEmBurst = (self.psEmission):GetBurst(0)
end

UINUltSkillMpParticleItem.InitUltSkillMpParticle = function(self, startPos, posX, posY, ratio, completeEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.completeEvent = completeEvent
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = startPos
  ;
  (((self.ui).moveTween).tween):ChangeEndValueV3(posX, posY, 0, true)
  ;
  ((self.ui).moveTween):DORestart()
  local particleCount = (math.ceil)(ratio / (self.ui).perParticleRatio)
  particleCount = (math.min)(particleCount, (self.ui).maxParticleCount)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

  if (self.psEmBurst).minCount ~= particleCount or (self.psEmBurst).maxCount ~= particleCount then
    (self.psEmBurst).minCount = particleCount
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.psEmBurst).maxCount = particleCount
    ;
    (self.psEmission):SetBurst(0, self.psEmBurst)
  end
  ;
  ((self.ui).particle):Play()
end

UINUltSkillMpParticleItem.OnMoveTweenComplete = function(self)
  -- function num : 0_2
  if self.completeEvent ~= nil then
    (self.completeEvent)(self)
  end
end

UINUltSkillMpParticleItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINUltSkillMpParticleItem

