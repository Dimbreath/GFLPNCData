-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1005 = class("bs_1005", LuaSkillBase)
local base = LuaSkillBase
bs_1005.config = {monsterId = 1, 
monsterSkillList = {1006, 1007}
, monsterEffectId = 103}
bs_1005.ctor = function(self)
  -- function num : 0_0
end

bs_1005.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1005.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(5)
  local summoner = LuaSkillCtrl:CreateSummoner(self, (self.config).monsterId, (self.caster).x, (self.caster).y)
  for k,skillId in pairs((self.config).monsterSkillList) do
    summoner:AddSkill(skillId, self.level)
  end
  summoner:SetAttr(eHeroAttr.maxHp, 1)
  local record = {}
  record[101] = (self.caster).maxHp
  record[102] = (self.caster).pow
  summoner:SetRecordTable(record)
  LuaSkillCtrl:AddSummonerRole(summoner)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).monsterEffectId, self)
end

bs_1005.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1005

