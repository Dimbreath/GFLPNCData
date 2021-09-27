local UIHeroDungeonItem = class("UIHeroDungeonItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_text = ((CS.UnityEngine).UI).Text
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
  do
    if not (self.data):UnlockAndHasStageOpen() then
      local cfg = (self.data):GetDungeonCfg()
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.PlotDungeon_DungeonLocked))
      return 
    end
    if self.clickEvent ~= nil then
      (self.clickEvent)()
    end
  end
end

UIHeroDungeonItem.OnUpdateWithData = function(self, dungeonData)
  -- function num : 0_3 , upvalues : _ENV, cs_text
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
    local friendshipHeroCfg = (ConfigData.friendship_hero)[dungeonData.itemId]
    if friendshipHeroCfg == nil then
      error("can\'t reda friendshipHeroCfg with HeroId:" .. tostring(dungeonData.itemId))
    else
      local path = PathConsts:GetFriendshipDungeonPicPath(friendshipHeroCfg.dungeon_img)
      do
        if not (string.IsNullOrEmpty)(path) then
          do
            self.img_StoryBg = (self.resLoader):LoadABAsset(path)
            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC43: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    path = PathConsts:GetCharacterPicPath(((dungeonData:GetDungeonHeroData()).resCfg).res_Name)
    if not (string.IsNullOrEmpty)(path) then
      local itemData = self.data
      ;
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
  do
    if not (self.data):UnlockAndHasStageOpen() then
      if self.blackCover == nil then
        self.blackCover = ((self.ui).obj_HeroItemLock):Instantiate()
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (self.ui).tex_Condition = ((self.blackCover).transform):GetComponentInChildren(typeof(cs_text))
      end
      ;
      ((self.blackCover).transform):SetParent(self.transform)
      -- DECOMPILER ERROR at PC95: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.blackCover).transform).anchoredPosition = Vector2.zero
      ;
      ((self.blackCover).gameObject):SetActive(true)
      local stageCfg = (self.data):GetNewLockStage()
      -- DECOMPILER ERROR at PC114: Confused about usage of register: R5 in 'UnsetPending'

      if stageCfg ~= nil then
        ((self.ui).tex_Condition).text = (CheckCondition.GetUnlockInfoLua)(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
      end
    else
      do
        if self.blackCover ~= nil then
          ((self.blackCover).gameObject):SetActive(false)
        end
        self:UpdateAndSetProgress(dungeonData)
      end
    end
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

UIHeroDungeonItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeroDungeonItem

