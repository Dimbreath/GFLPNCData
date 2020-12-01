-- params : ...
-- function num : 0 , upvalues : _ENV
local ShieldSkillBase = {}
ShieldSkillBase.ShieldBaseFunc = function(hurt, shieldRole, shieldKey)
  -- function num : 0_0
  local retHurt = hurt
  do
    if (shieldRole.recordTable)[shieldKey] > 0 then
      local shield = (shieldRole.recordTable)[shieldKey] - hurt
      if shield <= 0 then
        retHurt = hurt - (shieldRole.recordTable)[shieldKey]
        -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (shieldRole.recordTable)[shieldKey] = 0
        shieldRole:UpdateShieldView(shieldKey, 0)
      else
        retHurt = 0
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (shieldRole.recordTable)[shieldKey] = shield
        shieldRole:UpdateShieldView(shieldKey, shield)
      end
    end
    return retHurt
  end
end

ShieldSkillBase.UpdateShieldView = function(shieldRole, shieldKey, value)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (shieldRole.recordTable)[shieldKey] = value
  shieldRole:UpdateShieldView(shieldKey, value)
end

ShieldSkillBase.ClearShieldType = function(shieldRole, shieldKey)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (shieldRole.recordTable)[shieldKey] = 0
  shieldRole:UpdateShieldView(shieldKey, 0)
end

return ShieldSkillBase

-- params : ...
-- function num : 0 , upvalues : _ENV
local ShieldSkillBase = {}
ShieldSkillBase.ShieldBaseFunc = function(hurt, shieldRole, shieldKey)
    -- function num : 0_0
    local retHurt = hurt
    do
        if (shieldRole.recordTable)[shieldKey] > 0 then
            local shield = (shieldRole.recordTable)[shieldKey] - hurt
            if shield <= 0 then
                retHurt = hurt - (shieldRole.recordTable)[shieldKey] -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'
                ;
                (shieldRole.recordTable)[shieldKey] = 0
                shieldRole:UpdateShieldView(shieldKey, 0)
            else
                retHurt = 0 -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'
                ;
                (shieldRole.recordTable)[shieldKey] = shield
                shieldRole:UpdateShieldView(shieldKey, shield)
            end
        end
        return retHurt
    end
end

ShieldSkillBase.UpdateShieldView = function(shieldRole, shieldKey, value)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

    (shieldRole.recordTable)[shieldKey] = value
    shieldRole:UpdateShieldView(shieldKey, value)
end

ShieldSkillBase.ClearShieldType = function(shieldRole, shieldKey)
    -- function num : 0_2
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (shieldRole.recordTable)[shieldKey] = 0
    shieldRole:UpdateShieldView(shieldKey, 0)
end

return ShieldSkillBase

