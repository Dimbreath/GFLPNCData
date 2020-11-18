-- params : ...
-- function num : 0 , upvalues : _ENV
local UINBattleDPSItem = class("UINBattleDPSItem", UIBaseNode)
local base = UIBaseWindow
local CareerToColor = {[0] = (Color.New)(1, 1, 1, 0.3), [1] = (Color.New)(0.54, 0.67, 1, 0.3), [2] = (Color.New)(1, 0.39, 0.43, 0.3), [3] = (Color.New)(1, 0.68, 0.42, 0.3), [4] = (Color.New)(0.84, 0.62, 1, 0.3), [5] = (Color.New)(0.75, 1, 0.78, 0.3)}
UINBattleDPSItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.damage = 0
  self.heroID = 0
end

UINBattleDPSItem.InitDPSItem = function(self, id, damage, maxDamage)
  -- function num : 0_1 , upvalues : _ENV, CareerToColor
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  if not ConfigData:GetTipContent(TipContent.CommanderDPSName) then
    ((self.ui).tex_Name).text = id ~= 0 or "Commander"
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite("career_commander", CommonAtlasType.CareerCamp)
    self.damage = damage
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Bar).color = CareerToColor[0]
    self:RefreshDamage(maxDamage)
    do return  end
    local heroCfg = (ConfigData.hero_data)[id]
    if heroCfg == nil then
      error("read heroCfg error id" .. id)
    end
    local careerCfg = (ConfigData.career)[heroCfg.career]
    if careerCfg == nil then
      error("read careerCfg error id" .. heroCfg.career)
    end
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
    self.damage = damage
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_Bar).color = CareerToColor[careerCfg.id]
    self:RefreshDamage(maxDamage)
  end
end

UINBattleDPSItem.AddDamage = function(self, damage, maxDamage)
  -- function num : 0_2
  self.damage = damage
  self:RefreshDamage(maxDamage)
end

UINBattleDPSItem.RefreshDamage = function(self, maxDamage)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Percent).text = tostring(self.damage)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Bar).fillAmount = self.damage / maxDamage
end

UINBattleDPSItem.Clean = function(self)
  -- function num : 0_4
  self.damage = 0
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Percent).text = 0
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Bar).fillAmount = 0
end

UINBattleDPSItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINBattleDPSItem

