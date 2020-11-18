-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampFetterItem = class("UINCampFetterItem", UIBaseNode)
UINCampFetterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_FetterItem, self, self.OnBtnFetterClicked)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).image_CompanyIcon = (self.transform):FindComponent("Img_Icon", eUnityComponentID.Image)
end

UINCampFetterItem.InitFetterItem = function(self, campId, heroCount, clickAction)
  -- function num : 0_1 , upvalues : _ENV
  self.campId = campId
  local campCfg = (ConfigData.camp)[campId]
  if campCfg == nil then
    error("camp cfg is null,id:" .. tostring(campId))
    return 
  end
  self.campCfg = campCfg
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).image_CompanyIcon).sprite = CRH:GetSprite(campCfg.icon, CommonAtlasType.CareerCamp)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_FetterInfo).text = tostring(heroCount)
  self.clickAction = clickAction
  self.fetters_num = heroCount
end

UINCampFetterItem.OnBtnFetterClicked = function(self)
  -- function num : 0_2
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

return UINCampFetterItem

