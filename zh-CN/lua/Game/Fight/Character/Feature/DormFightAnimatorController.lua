local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local WalkAnimationName = "party_walk"
local IdleAnimationName = "party_stand"
local AttackAnimationNames = {"party_attack1", "party_attack2"}
local RunAnimationName = "party_run"
local ReviveAnimationName = "party_revive"
local DormFightAnimatorController = class("DormFightAnimatorController", DormFightCharacterFeatureBase)
DormFightAnimatorController.ctor = function(self)
  -- function num : 0_0
  self._animator = nil
end

DormFightAnimatorController.OnInit = function(self)
  -- function num : 0_1
  self._animator = (self._owner).animator
end

DormFightAnimatorController.PlayWalkAnimation = function(self)
  -- function num : 0_2 , upvalues : _ENV, WalkAnimationName
  if IsNull(self._animator) then
    return 
  end
  ;
  (self._animator):Play(WalkAnimationName)
end

DormFightAnimatorController.PlayRunAnimation = function(self)
  -- function num : 0_3 , upvalues : _ENV, RunAnimationName
  if IsNull(self._animator) then
    return 
  end
  ;
  (self._animator):Play(RunAnimationName)
end

DormFightAnimatorController.PlayReviveAnimation = function(self)
  -- function num : 0_4 , upvalues : _ENV, ReviveAnimationName
  if IsNull(self._animator) then
    return 
  end
  ;
  (self._animator):Play(ReviveAnimationName)
end

DormFightAnimatorController.PlayIdleAnimation = function(self)
  -- function num : 0_5 , upvalues : _ENV, IdleAnimationName
  if IsNull(self._animator) then
    return 
  end
  ;
  (self._animator):Play(IdleAnimationName)
end

DormFightAnimatorController.PlayAttackAnimation = function(self)
  -- function num : 0_6 , upvalues : _ENV, AttackAnimationNames
  if IsNull(self._animator) then
    return 
  end
  local animationName = AttackAnimationNames[(math.random)(#AttackAnimationNames)]
  ;
  (self._animator):Play(animationName, 0, 0)
end

DormFightAnimatorController.SetEnabled = function(self, enabled)
  -- function num : 0_7 , upvalues : _ENV
  if IsNull(self._animator) then
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._animator).enabled = enabled
end

return DormFightAnimatorController

