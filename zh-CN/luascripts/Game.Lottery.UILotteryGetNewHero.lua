-- params : ...
-- function num : 0 , upvalues : _ENV
local UILotteryGetNewHero = class("UILotteryGetNewHero", UIBaseWindow)
local base = UIBaseWindow
UILotteryGetNewHero.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).close_btn, self, self.OnclickCloseBtn)
  ;
  ((self.ui).img_Star):SetActive(false)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).stars = {}
  for i = 1, (ConfigData.hero_rank).maxStar do
    local go = ((self.ui).img_Star):Instantiate()
    go:SetActive(true)
    ;
    (table.insert)((self.ui).stars, go)
  end
end

UILotteryGetNewHero.InitUILotteryGetNewHero = function(self, heroCfg, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  if not heroCfg then
    error("未传入heroCfg")
  end
  local heroRankCfg = (ConfigData.hero_rank)[heroCfg.rank]
  if heroRankCfg == nil then
    error("Can\'t find heroRankCfg, id = " .. tostring(heroCfg.rank))
    return 
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_HeroName).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_NameEn).text = (LanguageUtil.GetLocaleText)(heroCfg.name_en)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Career).sprite = CRH:GetSprite(((ConfigData.career)[heroCfg.career]).icon, CommonAtlasType.CareerCamp)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Camp).text = (LanguageUtil.GetLocaleText)(((ConfigData.camp)[heroCfg.camp]).name)
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Introduce).text = (LanguageUtil.GetLocaleText)(heroCfg.talk)
  local star = heroRankCfg.star
  for i = 1, star do
    (((self.ui).stars)[i]):SetActive(true)
  end
  for i = star + 1, #(self.ui).stars do
    (((self.ui).stars)[i]):SetActive(false)
  end
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_HeroColor).color = HeroRareColor[heroRankCfg.rare]
  local go = (resLoader:LoadABAsset(PathConsts:GetCharacterBigImgPrefabPath(((ConfigData.resource_model)[heroCfg.src_id]).res_Name))):Instantiate()
  ;
  (go.transform):SetParent(((self.ui).Parent_HerolPicNode).transform, false)
  -- DECOMPILER ERROR at PC120: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_HeroPic).texture = (go:GetComponent("RawImage")).texture
end

UILotteryGetNewHero.OnclickCloseBtn = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:Delete()
  MsgCenter:Broadcast(eMsgEventId.UIGetHeroClose)
end

return UILotteryGetNewHero

