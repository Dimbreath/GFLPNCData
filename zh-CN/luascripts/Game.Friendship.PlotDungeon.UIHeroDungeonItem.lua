-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroDungeonItem = class("UIHeroDungeonItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
UIHeroDungeonItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.index = nil
  ;
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
  -- function num : 0_2 , upvalues : cs_MessageCommon, _ENV
  if not (self.data):GetIsUnlock() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.PlotDungeon_DungeonLocked))
    return 
  end
  if self.clickEvent ~= nil then
    (self.clickEvent)()
  end
end

UIHeroDungeonItem.OnUpdateWithData = function(self, dungeonData)
  -- function num : 0_3 , upvalues : _ENV
  self.data = dungeonData
  local name, name_en = dungeonData:GetDungeonName()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = name
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_ENName).text = name_en
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.gameObject).name = name_en
  if self.resLoader ~= nil then
    local path = PathConsts:GetFriendshipDungeonPicPath(((ConfigData.friendship_hero)[dungeonData.itemId]).dungeon_img)
    if not (string.IsNullOrEmpty)(path) then
      self.img_StoryBg = (self.resLoader):LoadABAsset(path)
    end
    path = PathConsts:GetCharacterPicPath(((dungeonData:GetDungeonHeroData()).resCfg).res_Name)
    if not (string.IsNullOrEmpty)(path) then
      local itemData = self.data
      do
        (self.resLoader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_3_0 , upvalues : itemData, self
    if itemData ~= self.data then
      return 
    end
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Hero).texture = texture
  end
)
      end
    end
  end
  do
    if not (self.data):GetIsUnlock() then
      if self.blackCover == nil then
        self.blackCover = ((self.ui).obj_HeroItemLock):Instantiate()
      end
      ;
      ((self.blackCover).transform):SetParent(self.transform)
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.blackCover).transform).anchoredPosition = Vector2.zero
      ;
      ((self.blackCover).gameObject):SetActive(true)
    else
      if self.blackCover ~= nil then
        ((self.blackCover).gameObject):SetActive(false)
      end
    end
    self:UpdateAndSetProgress(dungeonData)
    self:UpdateDoubleReward()
  end
end

UIHeroDungeonItem.UpdateAndSetProgress = function(self, dungeonData)
  -- function num : 0_4 , upvalues : _ENV
  if not (self.data):GetIsUnlock() then
    (((((self.ui).tex_CompleteNum).transform).parent).gameObject):SetActive(false)
    return 
  else
    ;
    (((((self.ui).tex_CompleteNum).transform).parent).gameObject):SetActive(true)
  end
  local progress = dungeonData:GetDungeonStageCompletedCount() * 100 // dungeonData:GetDungeonStageCount()
  ;
  ((self.ui).tex_CompleteNum):SetIndex(0, tostring(progress))
end

UIHeroDungeonItem.UpdateDoubleReward = function(self)
  -- function num : 0_5
  if not (self.data):GetIsUnlock() then
    ((self.ui).obj_double):SetActive(false)
    return 
  end
  ;
  ((self.ui).obj_double):SetActive((self.data):GetIsDungeonDouble())
end

UIHeroDungeonItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroDungeonItem

