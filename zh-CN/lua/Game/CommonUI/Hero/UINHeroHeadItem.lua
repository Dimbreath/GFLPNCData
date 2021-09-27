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
  self:SetHeroHeadIcon(heroData.heroCfg, heroData.skinId)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Career).sprite = CRH:GetSprite((heroData:GetCareerCfg()).icon, CommonAtlasType.CareerCamp)
end

UINHeroHeadItem.InitHeroHeadItemWithId = function(self, heroId, clickEvent)
  -- function num : 0_2 , upvalues : _ENV
  self.heroData = nil
  self.heroId = heroId
  self.clickEvent = clickEvent
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("heroCfg is NULL   id:" .. tostring(heroId))
  end
  self:SetHeroHeadIcon(heroCfg)
  local careerCfg = (ConfigData.career)[heroCfg.career]
  if careerCfg == nil then
    error("can\'t read careerCfg with id: " .. tostring(heroCfg.career))
    return 
  end
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Career).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
end

UINHeroHeadItem.TransparentHeroHeadItem = function(self, transparent)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = transparent and (self.ui).transparentValue or 1
end

UINHeroHeadItem.SetHeroHeadIcon = function(self, heroCfg, skinId)
  -- function num : 0_4 , upvalues : _ENV
  local resName = nil
  do
    if skinId or 0 ~= 0 then
      local skinCfg = (ConfigData.skin)[skinId]
      if skinCfg ~= nil and not (string.IsNullOrEmpty)(skinCfg.src_id_icon) then
        resName = skinCfg.src_id_icon
      end
    end
    do
      if (string.IsNullOrEmpty)(resName) and heroCfg.fragment ~= nil then
        local itemCfg = (ConfigData.item)[heroCfg.fragment]
        if itemCfg ~= nil then
          resName = itemCfg.icon
        end
      end
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

      if (string.IsNullOrEmpty)(resName) ~= nil then
        ((self.ui).img_Pic).sprite = CRH:GetSprite(resName, CommonAtlasType.HeroHeadIcon)
      end
    end
  end
end

UINHeroHeadItem.__OnClickRoot = function(self)
  -- function num : 0_5
  if self.clickEvent ~= nil then
    if self.heroData ~= nil then
      (self.clickEvent)(self.heroData)
    else
      if self.heroId ~= nil then
        (self.clickEvent)(self.heroId)
      end
    end
  end
end

UINHeroHeadItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroHeadItem

