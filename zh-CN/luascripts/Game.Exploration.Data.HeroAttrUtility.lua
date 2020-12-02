-- params : ...
-- function num : 0 , upvalues : _ENV
local HeroAttrUtility = {ExtraPropertyEnd = 100, BasePropertyStart = 100, BasePropertyEnd = 200, RatioPropertyStart = 200, RatioPropertyEnd = 300}
HeroAttrUtility.OffsetAttrFromDynHero = function(role, property, value)
  -- function num : 0_0 , upvalues : HeroAttrUtility
  if property < HeroAttrUtility.ExtraPropertyEnd then
    role:SetExtraAttr(property, role:GetExtraAttr(property) + value)
  else
    if property < HeroAttrUtility.BasePropertyEnd then
      local newPropNum = property - HeroAttrUtility.BasePropertyStart
      role:SetBaseAttr(newPropNum, role:GetBaseAttr(newPropNum) + value)
    else
      do
        if property < HeroAttrUtility.RatioPropertyEnd then
          local newPropNum = property - HeroAttrUtility.RatioPropertyStart
          role:SetRatioAttr(newPropNum, role:GetRatioAttr(newPropNum) + value)
        end
      end
    end
  end
end

HeroAttrUtility.OffsetAttrFormDynPlayer = function(dynPlayerData, property, value)
  -- function num : 0_1 , upvalues : HeroAttrUtility
  if property < HeroAttrUtility.ExtraPropertyEnd then
    dynPlayerData:SetExtraAttr(property, dynPlayerData:GetExtraAttr(property) + value)
  else
    if property < HeroAttrUtility.BasePropertyEnd then
      local newPropNum = property - HeroAttrUtility.BasePropertyStart
      dynPlayerData:SetBaseAttr(newPropNum, dynPlayerData:GetBaseAttr(newPropNum) + value)
    else
      do
        if property < HeroAttrUtility.RatioPropertyEnd then
          local newPropNum = property - HeroAttrUtility.RatioPropertyStart
          dynPlayerData:SetRatioAttr(newPropNum, dynPlayerData:GetRatioAttr(newPropNum) + value)
        end
      end
    end
  end
end

return HeroAttrUtility

