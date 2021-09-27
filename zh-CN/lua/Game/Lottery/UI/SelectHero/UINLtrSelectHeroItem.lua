local UINLtrSelectHeroItem = class("UINLtrSelectHeroItem", UIBaseNode)
local base = UIBaseNode
UINLtrSelectHeroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).tog_Root, self, self._OnClickRoot)
end

UINLtrSelectHeroItem.InitLtrSelectHeroItem = function(self, heroId, selectFunc, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.heroId = heroId
  self.selectFunc = selectFunc
  local heroCfg = (ConfigData.hero_data)[heroId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(heroId))
    return 
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(heroCfg.name)
  local careerCfg = (ConfigData.career)[heroCfg.career]
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Career).sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  local resCfg = skinCtr:GetResModel(heroId, 0)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).enabled = false
  resLoader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(resCfg.res_Name), function(texture)
    -- function num : 0_1_0 , upvalues : _ENV, self
    if IsNull(self.transform) or IsNull(texture) then
      return 
    end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).texture = texture
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Pic).enabled = true
  end
)
  ;
  ((self.ui).isOwned):SetActive((PlayerDataCenter.heroDic)[heroId] ~= nil)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINLtrSelectHeroItem.SetLtrSelectHeroItemIsOn = function(self, heroId)
  -- function num : 0_2 , upvalues : _ENV
  local isOn = heroId == self.heroId
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  if not isOn or not (self.ui).color_selectBlack then
    ((self.ui).img_Career).color = Color.white
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    if not isOn or not (self.ui).color_selectBlack then
      ((self.ui).tex_Name).color = Color.white
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

      if not isOn or not Color.white then
        ((self.ui).img_NameBg).color = (self.ui).color_selectBlack
        ;
        ((self.ui).img_Sel):SetIndex(isOn and 1 or 0)
        -- DECOMPILER ERROR: 9 unprocessed JMP targets
      end
    end
  end
end

UINLtrSelectHeroItem._OnClickRoot = function(self)
  -- function num : 0_3
  if self.selectFunc ~= nil then
    (self.selectFunc)(self.heroId)
  end
end

UINLtrSelectHeroItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrSelectHeroItem

