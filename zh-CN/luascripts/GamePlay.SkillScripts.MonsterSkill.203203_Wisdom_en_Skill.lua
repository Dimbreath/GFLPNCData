-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202603 = require("GamePlay.SkillScripts.MonsterSkill.202603_WisdomSkill")
local bs_203203 = class("bs_203203", bs_202603)
local base = bs_202603
bs_203203.config = {effectIdline = 10581, effectIdmiao = 10582, effectId = 10583, effectIdtrail = 10584}
bs_203203.config = setmetatable(bs_203203.config, {__index = base.config})
bs_203203.ctor = function(self)
  -- function num : 0_0
end

bs_203203.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_203203.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203203

