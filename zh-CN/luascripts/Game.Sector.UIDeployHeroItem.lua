-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDeployHeroItem = class("UIDeployHeroItem", UIBaseNode)
local base = UIBaseNode
UIDeployHeroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Hero, self, self.OnClickButton)
  ;
  ((self.ui).star):SetActive(false)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).stars = {}
  for i = 1, (ConfigData.hero_rank).maxStar do
    local go = ((self.ui).star):Instantiate()
    go:SetActive(true)
    ;
    (table.insert)((self.ui).stars, go)
  end
end

UIDeployHeroItem.InitHeroData = function(self, index, heroData, resloader, clickEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.posIndex = index
  self.heroData = heroData
  local isNull = heroData == nil
  ;
  ((self.ui).img_Add):SetActive(isNull)
  ;
  ((self.ui).heroContent):SetActive(not isNull)
  self.clickEvent = clickEvent
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  if isNull then
    ((self.ui).img_Hero).texture = nil
  else
    resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroData:GetResName()), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self, heroData
    if IsNull(self.transform) then
      return 
    end
    if self.heroData ~= heroData then
      return 
    end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).texture = texture
  end
)
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite((heroData:GetCareerCfg()).icon, CommonAtlasType.CareerCamp)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = heroData:GetName()
    self:SetStarUI(heroData.star)
    ;
    ((self.ui).tex_Level):SetIndex(0, tostring(heroData.level))
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIDeployHeroItem.SetStarUI = function(self, star)
  -- function num : 0_2
  for i = 1, star do
    (((self.ui).stars)[i]):SetActive(true)
  end
  for i = star + 1, #(self.ui).stars do
    (((self.ui).stars)[i]):SetActive(false)
  end
end

UIDeployHeroItem.SetRedDotActive = function(self, active)
  -- function num : 0_3
  ((self.ui).redDotHero):SetActive(active)
end

UIDeployHeroItem.OnClickButton = function(self)
  -- function num : 0_4
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UIDeployHeroItem.SetSelectState = function(self, active)
  -- function num : 0_5
  self.onSelect = active
  ;
  (((self.ui).img_OnSelect).gameObject):SetActive(active)
end

UIDeployHeroItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)()
end

return UIDeployHeroItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDeployHeroItem = class("UIDeployHeroItem", UIBaseNode)
local base = UIBaseNode
UIDeployHeroItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Hero, self, self.OnClickButton);
    ((self.ui).star):SetActive(false) -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.ui).stars = {}
    for i = 1, (ConfigData.hero_rank).maxStar do
        local go = ((self.ui).star):Instantiate()
        go:SetActive(true);
        (table.insert)((self.ui).stars, go)
    end
end

UIDeployHeroItem.InitHeroData = function(self, index, heroData, resloader,
                                         clickEvent)
    -- function num : 0_1 , upvalues : _ENV
    self.posIndex = index
    self.heroData = heroData
    local isNull = heroData == nil;
    ((self.ui).img_Add):SetActive(isNull);
    ((self.ui).heroContent):SetActive(not isNull)
    self.clickEvent = clickEvent
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    if isNull then
        ((self.ui).img_Hero).texture = nil
    else
        resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(
                                       heroData:GetResName()), function(texture)
            -- function num : 0_1_0 , upvalues : _ENV, self, heroData
            if IsNull(self.transform) then return end
            if self.heroData ~= heroData then return end -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
            
            ((self.ui).img_Hero).texture = texture
        end) -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((self.ui).img_Career).sprite = CRH:GetSprite(
                                            (heroData:GetCareerCfg()).icon,
                                            CommonAtlasType.CareerCamp) -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = heroData:GetName()
        self:SetStarUI(heroData.star);
        ((self.ui).tex_Level):SetIndex(0, tostring(heroData.level))
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIDeployHeroItem.SetStarUI = function(self, star)
    -- function num : 0_2
    for i = 1, star do (((self.ui).stars)[i]):SetActive(true) end
    for i = star + 1, #(self.ui).stars do
        (((self.ui).stars)[i]):SetActive(false)
    end
end

UIDeployHeroItem.SetRedDotActive = function(self, active)
    -- function num : 0_3
    ((self.ui).redDotHero):SetActive(active)
end

UIDeployHeroItem.OnClickButton = function(self)
    -- function num : 0_4
    if self.clickEvent ~= nil then (self.clickEvent)(self) end
end

UIDeployHeroItem.SetSelectState = function(self, active)
    -- function num : 0_5
    self.onSelect = active;
    (((self.ui).img_OnSelect).gameObject):SetActive(active)
end

UIDeployHeroItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)()
end

return UIDeployHeroItem

