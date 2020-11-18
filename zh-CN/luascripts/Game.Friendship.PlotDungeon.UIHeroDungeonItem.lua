-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroDungeonItem = class("UIHeroDungeonItem", UIBaseNode)
local base = UIBaseNode
UIHeroDungeonItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).button_HeroItem, self, self.OnItemClick)
end

UIHeroDungeonItem.InjectResLoaderAndClickEvent = function(self, resLoader, clickEvent)
  -- function num : 0_1
  self.resLoader = resLoader
  self.clickEvent = clickEvent
end

UIHeroDungeonItem.OnItemClick = function(self)
  -- function num : 0_2
  if self.clickEvent ~= nil then
    (self.clickEvent)()
  end
end

UIHeroDungeonItem.OnUpdateWithData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self.data = data
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(data.itemName)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = (LanguageUtil.GetLocaleText)(data.itemNameEn)
  do
    if self.resLoader ~= nil then
      local path = PathConsts:GetFriendshipDungeonPicPath(data.itemBgImg)
      if not (string.IsNullOrEmpty)(path) then
        self.img_StoryBg = (self.resLoader):LoadABAsset(path)
      end
      path = PathConsts:GetCharacterPicPath(data.itemIcon)
      if not (string.IsNullOrEmpty)(path) then
        (self.resLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_3_0 , upvalues : self
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).img_Hero).texture = texture
  end
)
      end
    end
    self:UpdateAndSetProgress(data.totalProgress)
  end
end

UIHeroDungeonItem.UpdateAndSetProgress = function(self, progress)
  -- function num : 0_4 , upvalues : _ENV
  ((self.ui).tex_CompleteNum):SetIndex(0, tostring(progress))
end

UIHeroDungeonItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroDungeonItem

