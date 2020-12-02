-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFmtPlatform = class("UINFmtPlatform", UIBaseNode)
local base = UIBaseNode
UINFmtPlatform.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFmtPlatform.InitFmtPlatform = function(self, fmtIndex, isBench, lockStr)
  -- function num : 0_1
  self.fmtIndex = fmtIndex
  self.isBench = isBench
  self.lockStr = lockStr
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  if not isBench then
    ((self.ui).img_SelectHero).color = (self.ui).selectHeroColor
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_SelectHero).color = (self.ui).selectHeroColor
  end
end

UINFmtPlatform.RefreshUIFmtPlatform = function(self, heroData)
  -- function num : 0_2 , upvalues : _ENV
  local fightingPower = 0
  ;
  ((self.ui).haveHero):SetActive(false)
  ;
  ((self.ui).selectHero):SetActive(false)
  ;
  ((self.ui).benchHero):SetActive(false)
  ;
  ((self.ui).lock):SetActive(false)
  ;
  ((self.ui).power):SetActive(false)
  if not (string.IsNullOrEmpty)(self.lockStr) then
    ((self.ui).lock):SetActive(true)
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Condition).text = self.lockStr
  else
    if heroData == nil then
      ((self.ui).selectHero):SetActive(true)
    else
      local campSprite = CRH:GetSprite((heroData:GetCampCfg()).icon, CommonAtlasType.CareerCamp)
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

      if self.isBench then
        ((self.ui).img_Bench_Camp).sprite = campSprite
        ;
        ((self.ui).benchHero):SetActive(true)
      else
        -- DECOMPILER ERROR at PC72: Confused about usage of register: R4 in 'UnsetPending'

        ;
        ((self.ui).img_Camp).sprite = campSprite
        ;
        ((self.ui).haveHero):SetActive(true)
      end
      fightingPower = heroData:GetFightingPower()
      ;
      ((self.ui).power):SetActive(true)
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Power).text = tostring(fightingPower)
    end
  end
  do
    self._fightingPower = fightingPower
    return fightingPower
  end
end

UINFmtPlatform.GetFmtPlatHeroFtPower = function(self)
  -- function num : 0_3
  return self._fightingPower
end

UINFmtPlatform.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINFmtPlatform

