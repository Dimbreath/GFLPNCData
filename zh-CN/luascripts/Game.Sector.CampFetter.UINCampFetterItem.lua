-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampFetterItem = class("UINCampFetterItem", UIBaseNode)
UINCampFetterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local btn = (self.transform):FindComponent(eUnityComponentID.Button)
  ;
  (UIUtil.AddButtonListener)(btn, self, self.OnBtnClicked)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.ui).tex_FetterInfo = (self.transform):FindComponent("Tex_FetterInfo", eUnityComponentID.Text)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.ui).image_CompanyIcon = (self.transform):FindComponent("Img_Icon", eUnityComponentID.Image)
end

UINCampFetterItem.InitFetterItem = function(self, campId, count, clickAction)
  -- function num : 0_1 , upvalues : _ENV
  self.clickAction = clickAction
  -- DECOMPILER ERROR at PC7: Overwrote pending register: R5 in 'AssignReg'

  local campCfg = (ConfigData.camp)[count]
  if campCfg == nil then
    error("camp cfg is null:ID:" .. tostring(self.campId))
    return 
  end
  self.campCfg = campCfg
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_FetterInfo).text = (string.format)("%s *%d", (LanguageUtil.GetLocaleText)(campCfg.name), self.fetters_num)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).image_CompanyIcon).sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
end

UINCampFetterItem.OnBtnClicked = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

return UINCampFetterItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampFetterItem = class("UINCampFetterItem", UIBaseNode)
UINCampFetterItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    local btn = (self.transform):FindComponent(eUnityComponentID.Button);
    (UIUtil.AddButtonListener)(btn, self, self.OnBtnClicked) -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.ui).tex_FetterInfo = (self.transform):FindComponent("Tex_FetterInfo",
                                                              eUnityComponentID.Text) -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.ui).image_CompanyIcon = (self.transform):FindComponent("Img_Icon",
                                                                 eUnityComponentID.Image)
end

UINCampFetterItem.InitFetterItem = function(self, campId, count, clickAction)
    -- function num : 0_1 , upvalues : _ENV
    self.clickAction = clickAction
    -- DECOMPILER ERROR at PC7: Overwrote pending register: R5 in 'AssignReg'

    local campCfg = (ConfigData.camp)[count]
    if campCfg == nil then
        error("camp cfg is null:ID:" .. tostring(self.campId))
        return
    end
    self.campCfg = campCfg -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).tex_FetterInfo).text = (string.format)("%s *%d",
                                                      (LanguageUtil.GetLocaleText)(
                                                          campCfg.name),
                                                      self.fetters_num) -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).image_CompanyIcon).sprite =
        CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
end

UINCampFetterItem.OnBtnClicked = function(self)
    -- function num : 0_2
    if self.clickAction ~= nil then (self.clickAction)(self) end
end

return UINCampFetterItem

