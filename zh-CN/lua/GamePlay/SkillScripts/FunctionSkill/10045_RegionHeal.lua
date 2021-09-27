local bs_10045 = class("bs_10045", LuaSkillBase)
local base = LuaSkillBase
bs_10045.config = {monsterId = 1, 
monsterSkillList = {10046, 1007}
, monsterEffectId = 103}
bs_10045.ctor = function(self)
  -- function num : 0_0
end

bs_10045.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_10045_3", 1, self.OnAfterHurt, nil, nil, nil, (self.caster).belongNum)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).summonerFlag = true
end

bs_10045.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

  if target.belongNum == (self.caster).belongNum and target.hp < target.maxHp * (self.arglist)[3] // 1000 and ((self.caster).recordTable).summonerFlag then
    ((self.caster).recordTable).summonerFlag = false
    local summoner = LuaSkillCtrl:CreateSummoner(self, (self.config).monsterId, target.x, target.y)
    do
      for k,skillId in pairs((self.config).monsterSkillList) do
        summoner:AddSkill(skillId, self.level)
      end
      summoner:SetAttr(eHeroAttr.maxHp, 1000)
      self.effect = LuaSkillCtrl:CallEffect(target, (self.config).monsterEffectId, self)
      local summonerEntity = LuaSkillCtrl:AddSummonerRole(summoner)
      self:PlayChipEffect()
      LuaSkillCtrl:StartTimer(self, (self.arglist)[2], function()
    -- function num : 0_2_0 , upvalues : _ENV, self, summonerEntity
    LuaSkillCtrl:RemoveLife(9999, self, summonerEntity)
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
  end
, nil)
    end
  end
end

bs_10045.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_10045.LuaDispose = function(self)
  -- function num : 0_4 , upvalues : base
  self.effect = nil
  ;
  (base.LuaDispose)(self)
end

return bs_10045

