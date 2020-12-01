-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpBuffShowItem = class("UIEpBuffShowItem")
UIEpBuffShowItem.ctor = function(self)
  -- function num : 0_0
end

UIEpBuffShowItem.InitEpBuffShowItem = function(self, iconObj, nameObj, buffCfg)
  -- function num : 0_1 , upvalues : _ENV
  self.img_Icon = iconObj:FindComponent(eUnityComponentID.Image)
  self.tex_Name = nameObj:FindComponent(eUnityComponentID.ExText)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.img_Icon).sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.tex_Name).text = (LanguageUtil.GetLocaleText)(buffCfg.name)
end

return UIEpBuffShowItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpBuffShowItem = class("UIEpBuffShowItem")
UIEpBuffShowItem.ctor = function(self)
    -- function num : 0_0
end

UIEpBuffShowItem.InitEpBuffShowItem = function(self, iconObj, nameObj, buffCfg)
    -- function num : 0_1 , upvalues : _ENV
    self.img_Icon = iconObj:FindComponent(eUnityComponentID.Image)
    self.tex_Name = nameObj:FindComponent(eUnityComponentID.ExText) -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.img_Icon).sprite = CRH:GetSprite(buffCfg.icon,
                                           CommonAtlasType.ExplorationIcon) -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.tex_Name).text = (LanguageUtil.GetLocaleText)(buffCfg.name)
end

return UIEpBuffShowItem

