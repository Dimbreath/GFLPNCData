-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHSuitAreaItem = class("UIATHSuitAreaItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitAreaItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIATHSuitAreaItem.InitWithData = function(self, data, resLoader, suitId)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  self.suitId = suitId
  self.resLoader = resLoader
  local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[suitId]
  if suitParamCfg ~= nil then
    (self.resLoader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
    -- function num : 0_1_0 , upvalues : self, suitParamCfg
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(suitParamCfg.icon)
  end
)
  end
  local areaCfg = (ConfigData.ath_area)[data]
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(areaCfg.name2)
  ;
  ((self.ui).tex_Area):SetIndex(0, areaCfg.name1)
end

UIATHSuitAreaItem.OnHide = function(self)
  -- function num : 0_2
  self.data = nil
  self.suitId = nil
end

UIATHSuitAreaItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHSuitAreaItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHSuitAreaItem = class("UIATHSuitAreaItem", UIBaseNode)
local base = UIBaseNode
UIATHSuitAreaItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIATHSuitAreaItem.InitWithData = function(self, data, resLoader, suitId)
    -- function num : 0_1 , upvalues : _ENV
    self.data = data
    self.suitId = suitId
    self.resLoader = resLoader
    local suitParamCfg = ((ConfigData.ath_suit).suitParamDic)[suitId]
    if suitParamCfg ~= nil then
        (self.resLoader):LoadABAssetAsync(
            PathConsts:GetAtlasAssetPath("AthSuitIcon"), function(spriteAtlas)
                -- function num : 0_1_0 , upvalues : self, suitParamCfg
                if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'
                
                ((self.ui).img_Icon).sprite =
                    spriteAtlas:GetSprite(suitParamCfg.icon)
            end)
    end
    local areaCfg = (ConfigData.ath_area)[data] -- DECOMPILER ERROR at PC26: Confused about usage of register: R6 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(areaCfg.name2);
    ((self.ui).tex_Area):SetIndex(0, areaCfg.name1)
end

UIATHSuitAreaItem.OnHide = function(self)
    -- function num : 0_2
    self.data = nil
    self.suitId = nil
end

UIATHSuitAreaItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UIATHSuitAreaItem

