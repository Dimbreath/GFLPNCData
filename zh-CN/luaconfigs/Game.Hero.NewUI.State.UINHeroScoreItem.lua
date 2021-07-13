-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroScoreItem = class("UINHeroScoreItem", UIBaseNode)
local base = UIBaseNode
UINHeroScoreItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHeroScoreItem.initScoreItem = function(self, cfg, growthNum, newGrowthNum)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(cfg.attribute_name)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Rate).fillAmount = growthNum / cfg.upper_limit
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  if newGrowthNum ~= nil then
    ((self.ui).img_RateUpgrade).fillAmount = growthNum / cfg.upper_limit
  end
  for index,value in ipairs(cfg.score) do
    if (newGrowthNum ~= nil and value <= newGrowthNum) or value <= growthNum then
      ((self.ui).tex_Grade):SetIndex(index)
      break
    end
  end
end

UINHeroScoreItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroScoreItem

