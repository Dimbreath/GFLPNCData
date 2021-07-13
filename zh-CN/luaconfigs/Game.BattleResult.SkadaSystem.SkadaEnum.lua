-- params : ...
-- function num : 0 , upvalues : _ENV
local SkadaEnum = {}
SkadaEnum.eSkadaType = {Damage = 1, TakeDamage = 2, Heal = 3}
SkadaEnum.MaxSkadaTypeNum = 3
SkadaEnum.SkadaSortFunc = {[(SkadaEnum.eSkadaType).Damage] = function(skada1, skada2)
  -- function num : 0_0 , upvalues : SkadaEnum
  local damage1 = ((skada1.detail)[(SkadaEnum.eSkadaType).Damage]).value
  local damage2 = ((skada2.detail)[(SkadaEnum.eSkadaType).Damage]).value
  if damage2 >= damage1 then
    do return damage1 == damage2 end
    do return skada1.id < skada2.id end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end
, [(SkadaEnum.eSkadaType).TakeDamage] = function(skada1, skada2)
  -- function num : 0_1 , upvalues : SkadaEnum
  local takeDamage1 = ((skada1.detail)[(SkadaEnum.eSkadaType).TakeDamage]).value
  local takeDamage2 = ((skada2.detail)[(SkadaEnum.eSkadaType).TakeDamage]).value
  if takeDamage2 >= takeDamage1 then
    do return takeDamage1 == takeDamage2 end
    do return skada1.id < skada2.id end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end
, [(SkadaEnum.eSkadaType).Heal] = function(skada1, skada2)
  -- function num : 0_2 , upvalues : SkadaEnum
  local heal1 = ((skada1.detail)[(SkadaEnum.eSkadaType).Heal]).value
  local heal2 = ((skada2.detail)[(SkadaEnum.eSkadaType).Heal]).value
  if heal2 >= heal1 then
    do return heal1 == heal2 end
    do return skada1.id < skada2.id end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end
}
return SkadaEnum

