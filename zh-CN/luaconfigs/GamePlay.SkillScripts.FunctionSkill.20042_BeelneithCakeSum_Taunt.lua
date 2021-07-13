-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_20042 = class("bs_20042", LuaSkillBase)
local base = LuaSkillBase
bs_20042.config = {taunt_buff = 273, deBuffId = 1163}
bs_20042.ctor = function(self)
  -- function num : 0_0
end

bs_20042.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddSetHurtTrigger("bs_20042_1", 99, self.OnSetHurt, nil, self.caster)
end

bs_20042.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.sender).uid == (self.caster).uid then
    context.hurt = (self.caster).hp
  else
    if (context.sender).uid == (((self.caster).recordTable).caster).uid then
      context.hurt = (self.caster).hp
      LuaSkillCtrl:CallBuff(self, ((self.caster).recordTable).caster, (self.config).deBuffId, 1, nil, true)
    else
      context.hurt = 0
    end
  end
end

bs_20042.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, ((self.caster).recordTable).caster, (self.config).taunt_buff, 1, 75, true)
  LuaSkillCtrl:StartTimer(self, 75, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    LuaSkillCtrl:RemoveLife((self.caster).hp, self, self.caster, false, true, nil, false, true)
  end
)
end

bs_20042.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  local effect = ((self.caster).recordTable).cakeEffect
  if effect ~= nil then
    effect:Die()
    effect = nil
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.caster).recordTable).cakeEffect = nil
  end
  local beelneith = ((self.caster).recordTable).caster
  if beelneith ~= nil and beelneith.hp > 0 then
    LuaSkillCtrl:CallBuff(self, ((self.caster).recordTable).caster, 198, 1, nil, true)
  end
  ;
  (base.OnCasterDie)(self)
end

return bs_20042

