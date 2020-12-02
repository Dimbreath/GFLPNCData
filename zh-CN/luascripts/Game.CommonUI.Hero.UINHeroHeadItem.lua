-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroHeadItem = class("UINHeroHeadItem", UIBaseNode)
local base = UIBaseNode
UINHeroHeadItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRoot)
end

UINHeroHeadItem.InitHeroHeadItem = function(self, heroData, resloader, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.heroData = heroData
  self.clickEvent = clickEvent
  local path = PathConsts:GetCharacterPicPath(heroData:GetResName())
  resloader:LoadABAssetAsync(path, function(texture)
    -- function num : 0_1_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_Pic).texture = texture
  end
)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Career).sprite = CRH:GetSprite((heroData:GetCareerCfg()).icon, CommonAtlasType.CareerCamp)
end

UINHeroHeadItem.TransparentHeroHeadItem = function(self, transparent)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = transparent and (self.ui).transparentValue or 1
end

UINHeroHeadItem.__OnClickRoot = function(self)
  -- function num : 0_3
  if self.clickEvent ~= nil then
    (self.clickEvent)(self.heroData)
  end
end

UINHeroHeadItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroHeadItem

