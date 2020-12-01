-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10175 = class("bs_10175", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_10175.config = {sheildBuffId = 174, shieldKeyYuan = "50002_HuDun", shieldKeyJin = "50003_HuDun"}
bs_10175.ctor = function(self)
  -- function num : 0_0
end

bs_10175.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10175_3", 1000, self.OnSetHurt)
end

bs_10175.OnSetHurt = function(self, context)
  -- function num : 0_2 , upvalues : _ENV, ShieldSkillBase
  if context.sender == self.caster then
    local restTier = (context.target):GetBuffTier((self.config).sheildBuffId)
    if restTier > 0 then
      do
        if ((context.target).recordTable).sheildValue_50002 ~= nil and ((context.target).recordTable).sheildValue_50002hurt ~= nil and ((context.target).recordTable).sheildValue_50002 > 0 then
          local yuanHurt = ((context.target).recordTable).sheildValue_50002hurt * (self.arglist)[1] // 1000
          -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((context.target).recordTable).sheildValue_50002 = (math.max)(0, ((context.target).recordTable).sheildValue_50002 - yuanHurt)
          ;
          (ShieldSkillBase.ShieldBaseFunc)(yuanHurt, context.target, (self.config).shieldKeyYuan)
        end
        if ((context.target).recordTable).sheildValue_50003 ~= nil and ((context.target).recordTable).sheildValue_50003hurt ~= nil and ((context.target).recordTable).sheildValue_50003 > 0 then
          local jinHurt = ((context.target).recordTable).sheildValue_50003hurt * (self.arglist)[1] // 1000
          -- DECOMPILER ERROR at PC82: Confused about usage of register: R4 in 'UnsetPending'

          ;
          ((context.target).recordTable).sheildValue_50003 = (math.max)(0, ((context.target).recordTable).sheildValue_50003 - jinHurt)
          ;
          (ShieldSkillBase.ShieldBaseFunc)(jinHurt, context.target, (self.config).shieldKeyJin)
        end
      end
    end
  end
end

bs_10175.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10175

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10175 = class("bs_10175", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require(
                            "GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_10175.config = {
    sheildBuffId = 174,
    shieldKeyYuan = "50002_HuDun",
    shieldKeyJin = "50003_HuDun"
}
bs_10175.ctor = function(self)
    -- function num : 0_0
end

bs_10175.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10175_3", 1000,
                    self.OnSetHurt)
end

bs_10175.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV, ShieldSkillBase
    if context.sender == self.caster then
        local restTier =
            (context.target):GetBuffTier((self.config).sheildBuffId)
        if restTier > 0 then
            do
                if ((context.target).recordTable).sheildValue_50002 ~= nil and
                    ((context.target).recordTable).sheildValue_50002hurt ~= nil and
                    ((context.target).recordTable).sheildValue_50002 > 0 then
                    local yuanHurt =
                        ((context.target).recordTable).sheildValue_50002hurt *
                            (self.arglist)[1] // 1000 -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'
                    ;
                    ((context.target).recordTable).sheildValue_50002 =
                        (math.max)(0,
                                   ((context.target).recordTable).sheildValue_50002 -
                                       yuanHurt);
                    (ShieldSkillBase.ShieldBaseFunc)(yuanHurt, context.target,
                                                     (self.config).shieldKeyYuan)
                end
                if ((context.target).recordTable).sheildValue_50003 ~= nil and
                    ((context.target).recordTable).sheildValue_50003hurt ~= nil and
                    ((context.target).recordTable).sheildValue_50003 > 0 then
                    local jinHurt =
                        ((context.target).recordTable).sheildValue_50003hurt *
                            (self.arglist)[1] // 1000 -- DECOMPILER ERROR at PC82: Confused about usage of register: R4 in 'UnsetPending'
                    ;
                    ((context.target).recordTable).sheildValue_50003 =
                        (math.max)(0,
                                   ((context.target).recordTable).sheildValue_50003 -
                                       jinHurt);
                    (ShieldSkillBase.ShieldBaseFunc)(jinHurt, context.target,
                                                     (self.config).shieldKeyJin)
                end
            end
        end
    end
end

bs_10175.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10175

