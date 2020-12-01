-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMatDungeonItem = class("UIMatDungeonItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UIMatDungeonItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.isLock = false
  ;
  (((self.ui).state_lock).gameObject):SetActive(false)
  ;
  (UIUtil.AddButtonListener)((self.ui).tog_DungeonItem, self, self.__onClick)
  ;
  ((self.ui).img_Select):SetActive(false)
  self.clickEvent = nil
end

UIMatDungeonItem.InitWithData = function(self, data, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)("CommonDungeon", data.itemIcon, resLoader)
  local path = PathConsts:GetMaterialDungeonBGIconPath(data.itemIcon)
  if not (string.IsNullOrEmpty)(path) then
    self.iconTexture = resLoader:LoadABAsset(path)
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(data.itemName)
  local enName = (LanguageUtil.GetLocaleText)(data.itemNameEn)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = enName
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.gameObject).name = enName
  self:UpdateDailyLimit()
  if not data.moduelUnlock then
    ((self.ui).state_lock):SetActive(true)
    self.isLock = true
  end
  path = PathConsts:GetMaterailDungeonPicPath(data.itemBgImg)
  if not (string.IsNullOrEmpty)(path) then
    self.bannerTexture = resLoader:LoadABAsset(path)
  end
end

UIMatDungeonItem.UpdateDailyLimit = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).tex_CompleteNum):SetIndex(0, tostring((self.data).totalDailyLimit - (self.data).usedDailyLimit), tostring((self.data).totalDailyLimit))
  self:IsDouble()
end

UIMatDungeonItem.__onClick = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon
  if self.isLock then
    (cs_MessageCommon.ShowMessageTips)((self.data).moduelUnlockDes)
    return 
  end
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UIMatDungeonItem.OnSelectDisplay = function(self, isShow)
  -- function num : 0_4
  ((self.ui).img_Select):SetActive(isShow)
end

UIMatDungeonItem.IsDouble = function(self)
  -- function num : 0_5
  ((self.ui).obj_double):SetActive((self.data):IsDouble())
end

UIMatDungeonItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIMatDungeonItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIMatDungeonItem = class("UIMatDungeonItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UIMatDungeonItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.isLock = false;
    (((self.ui).state_lock).gameObject):SetActive(false);
    (UIUtil.AddButtonListener)((self.ui).tog_DungeonItem, self, self.__onClick);
    ((self.ui).img_Select):SetActive(false)
    self.clickEvent = nil
end

UIMatDungeonItem.InitWithData = function(self, data, resLoader)
    -- function num : 0_1 , upvalues : _ENV
    self.data = data -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)(
                                      "CommonDungeon", data.itemIcon, resLoader)
    local path = PathConsts:GetMaterialDungeonBGIconPath(data.itemIcon)
    if not (string.IsNullOrEmpty)(path) then
        self.iconTexture = resLoader:LoadABAsset(path)
    end -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(data.itemName)
    local enName = (LanguageUtil.GetLocaleText)(data.itemNameEn) -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).tex_ENName).text = enName -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (self.gameObject).name = enName
    self:UpdateDailyLimit()
    if not data.moduelUnlock then
        ((self.ui).state_lock):SetActive(true)
        self.isLock = true
    end
    path = PathConsts:GetMaterailDungeonPicPath(data.itemBgImg)
    if not (string.IsNullOrEmpty)(path) then
        self.bannerTexture = resLoader:LoadABAsset(path)
    end
end

UIMatDungeonItem.UpdateDailyLimit = function(self)
    -- function num : 0_2 , upvalues : _ENV
    ((self.ui).tex_CompleteNum):SetIndex(0, tostring(
                                             (self.data).totalDailyLimit -
                                                 (self.data).usedDailyLimit),
                                         tostring((self.data).totalDailyLimit))
    self:IsDouble()
end

UIMatDungeonItem.__onClick = function(self)
    -- function num : 0_3 , upvalues : cs_MessageCommon
    if self.isLock then
        (cs_MessageCommon.ShowMessageTips)((self.data).moduelUnlockDes)
        return
    end
    if self.clickEvent ~= nil then (self.clickEvent)(self) end
end

UIMatDungeonItem.OnSelectDisplay = function(self, isShow)
    -- function num : 0_4
    ((self.ui).img_Select):SetActive(isShow)
end

UIMatDungeonItem.IsDouble = function(self)
    -- function num : 0_5
    ((self.ui).obj_double):SetActive((self.data):IsDouble())
end

UIMatDungeonItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UIMatDungeonItem

