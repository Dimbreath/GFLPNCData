-- params : ...
-- function num : 0 , upvalues : _ENV
local ShieldSkillBase = {}
ShieldSkillBase.ShieldBaseFunc = function(self, hurt, shieldRole)
  -- function num : 0_0
  local retHurt = hurt
  do
    if (shieldRole.recordTable)[(self.config).shieldKey] > 0 then
      local shield = (shieldRole.recordTable)[(self.config).shieldKey] - hurt
      if shield <= 0 then
        retHurt = hurt - (shieldRole.recordTable)[(self.config).shieldKey]
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (shieldRole.recordTable)[(self.config).shieldKey] = 0
      else
        retHurt = 0
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (shieldRole.recordTable)[(self.config).shieldKey] = shield
      end
    end
    return retHurt
  end
end

return ShieldSkillBase

