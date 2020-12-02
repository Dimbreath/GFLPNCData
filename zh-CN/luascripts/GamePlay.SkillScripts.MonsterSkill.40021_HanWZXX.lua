-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40021 = class("bs_40021", LuaSkillBase)
local base = LuaSkillBase
bs_40021.config = {}
bs_40021.ctor = function(self)
  -- function num : 0_0
end

bs_40021.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40021_2", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["40021Suck"] = 0
end

bs_40021.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV
  if context.sender == self.caster then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    if targetlist.Count > 0 then
      local time = targetlist.Count * (self.arglist)[1]
      do
        do
          if ((self.caster).recordTable)["40021Suck"] > 0 then
            local destime = -((self.caster).recordTable)["40021Suck"]
            ;
            (self.caster):AddRoleProperty(eHeroAttr.life_steal, destime, eHeroAttrType.Extra)
            ;
            (self.caster):AddRoleProperty(eHeroAttr.spell_life_steal, destime, eHeroAttrType.Extra)
          end
          ;
          (self.caster):AddRoleProperty(eHeroAttr.life_steal, time, eHeroAttrType.Extra)
          ;
          (self.caster):AddRoleProperty(eHeroAttr.spell_life_steal, time, eHeroAttrType.Extra)
          -- DECOMPILER ERROR at PC60: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((self.caster).recordTable)["40021Suck"] = time
          if ((self.caster).recordTable)["40021Suck"] > 0 then
            local destime = -((self.caster).recordTable)["40021Suck"]
            print(destime)
            ;
            (self.caster):AddRoleProperty(eHeroAttr.life_steal, destime, eHeroAttrType.Extra)
            ;
            (self.caster):AddRoleProperty(eHeroAttr.spell_life_steal, destime, eHeroAttrType.Extra)
          end
        end
      end
    end
  end
end

bs_40021.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40021

