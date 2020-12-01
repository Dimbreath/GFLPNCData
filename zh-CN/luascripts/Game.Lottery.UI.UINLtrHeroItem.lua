-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrHeroItem = class("UINLtrHeroItem", UIBaseNode)
local base = UIBaseNode
UINLtrHeroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (((self.ui).img_star).gameObject):SetActive(false)
  self.starItemList = {}
end

UINLtrHeroItem.InitLtrHeroItem = function(self, heroId, resLoader, heroPara)
  -- function num : 0_1 , upvalues : _ENV
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return 
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
  ;
  ((self.ui).img_Carrer):SetIndex(heroCfg.career - 1)
  local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
  end
  self:__HideAllStar()
  self:__UpdateStar(rankCfg.star)
  local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
  if resCfg == nil then
    error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
    return 
  end
  DestroyUnityObject(self.bigImgGameObject)
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resCfg.res_Name), function(prefab)
    -- function num : 0_1_0 , upvalues : self, _ENV
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local comPerspHandle = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    comPerspHandle:SetPosType("HeroList")
  end
)
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).heroHolder).anchoredPosition3D = (Vector3.New)(heroPara[1], heroPara[2], heroPara[3])
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).heroHolder).localScale = (Vector3.New)(heroPara[4], heroPara[5], heroPara[6])
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).heroInfo).anchoredPosition3D = (Vector3.New)(heroPara[7], heroPara[8], heroPara[9])
end

UINLtrHeroItem.__UpdateStar = function(self, starCount)
  -- function num : 0_2
  local twoStarCount = starCount // 2
  local oneStarCount = starCount % 2
  for i = 1, twoStarCount do
    local starItem = self:__GetStar(i)
    starItem:SetIndex(0)
  end
  if oneStarCount ~= 0 then
    local starItem = self:__GetStar(twoStarCount + 1)
    starItem:SetIndex(1)
  end
end

UINLtrHeroItem.__GetStar = function(self, index)
  -- function num : 0_3
  local starItem = (self.starItemList)[index]
  if starItem == nil then
    starItem = ((self.ui).img_star):Instantiate()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.starItemList)[index] = starItem
  end
  ;
  (starItem.gameObject):SetActive(true)
  return starItem
end

UINLtrHeroItem.__HideAllStar = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(self.starItemList) do
    (v.gameObject):SetActive(false)
  end
end

UINLtrHeroItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrHeroItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrHeroItem = class("UINLtrHeroItem", UIBaseNode)
local base = UIBaseNode
UINLtrHeroItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).img_star).gameObject):SetActive(false)
    self.starItemList = {}
end

UINLtrHeroItem.InitLtrHeroItem = function(self, heroId, resLoader, heroPara)
    -- function num : 0_1 , upvalues : _ENV
    local heroCfg = (ConfigData.hero_data)[heroId]
    if heroCfg == nil then
        error("hero cfg is null,id:" .. tostring(heroId))
        return
    end -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'
    
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(heroCfg.name);
    ((self.ui).img_Carrer):SetIndex(heroCfg.career - 1)
    local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
    if rankCfg == nil then
        error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
    end
    self:__HideAllStar()
    self:__UpdateStar(rankCfg.star)
    local resCfg = (ConfigData.resource_model)[heroCfg.src_id]
    if resCfg == nil then
        error("resource model Cfg is null,id:" .. tostring(heroCfg.src_id))
        return
    end
    DestroyUnityObject(self.bigImgGameObject)
    resLoader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(
                                   resCfg.res_Name), function(prefab)
        -- function num : 0_1_0 , upvalues : self, _ENV
        self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
        local comPerspHandle = (self.bigImgGameObject):FindComponent(
                                   eUnityComponentID.CommonPicController)
        comPerspHandle:SetPosType("HeroList")
    end) -- DECOMPILER ERROR at PC76: Confused about usage of register: R7 in 'UnsetPending'
    ;
    ((self.ui).heroHolder).anchoredPosition3D =
        (Vector3.New)(heroPara[1], heroPara[2], heroPara[3]) -- DECOMPILER ERROR at PC85: Confused about usage of register: R7 in 'UnsetPending'
    ;
    ((self.ui).heroHolder).localScale = (Vector3.New)(heroPara[4], heroPara[5],
                                                      heroPara[6]) -- DECOMPILER ERROR at PC94: Confused about usage of register: R7 in 'UnsetPending'
    ;
    ((self.ui).heroInfo).anchoredPosition3D =
        (Vector3.New)(heroPara[7], heroPara[8], heroPara[9])
end

UINLtrHeroItem.__UpdateStar = function(self, starCount)
    -- function num : 0_2
    local twoStarCount = starCount // 2
    local oneStarCount = starCount % 2
    for i = 1, twoStarCount do
        local starItem = self:__GetStar(i)
        starItem:SetIndex(0)
    end
    if oneStarCount ~= 0 then
        local starItem = self:__GetStar(twoStarCount + 1)
        starItem:SetIndex(1)
    end
end

UINLtrHeroItem.__GetStar = function(self, index)
    -- function num : 0_3
    local starItem = (self.starItemList)[index]
    if starItem == nil then
        starItem = ((self.ui).img_star):Instantiate() -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.starItemList)[index] = starItem
    end
    (starItem.gameObject):SetActive(true)
    return starItem
end

UINLtrHeroItem.__HideAllStar = function(self)
    -- function num : 0_4 , upvalues : _ENV
    for k, v in pairs(self.starItemList) do (v.gameObject):SetActive(false) end
end

UINLtrHeroItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINLtrHeroItem

