-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonBase = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonBase")
local UIMaterialDungeon = class("UIMaterialDungeon", UIDungeonBase)
local base = UIDungeonBase
local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
local UIMatDungeonItem = require("Game.MaterialDungeon.UI.UIMatDungeonItem")
local UIMatStageItemItem = require("Game.MaterialDungeon.UI.UIMatStageItemItem")
local UINMatDungeonSubTitle = require("Game.MaterialDungeon.UI.UINMatDungeonSubTitle")
UIMaterialDungeon.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV, UINMatDungeonSubTitle
  (base.OnInit)(self)
  self.subTitleDic = {}
  self.subTitlePool = (UIItemPool.New)(UINMatDungeonSubTitle, (self.ui).obj_SubTile)
  ;
  ((self.ui).obj_SubTile):SetActive(false)
end

UIMaterialDungeon.InitDungeonType = function(self, dungeonTypeData, selectItemId, onBackCallback)
  -- function num : 0_1 , upvalues : _ENV, base
  self.dungeonTypeUIEnum = UIWindowTypeID.MaterialDungeon
  ;
  (base.InitDungeonType)(self, dungeonTypeData, selectItemId, onBackCallback)
  local subTitleId = (self.selectDungeonData):GetSubTitleId()
  if subTitleId ~= nil and (self.subTitleDic)[subTitleId] ~= nil then
    ((self.subTitleDic)[subTitleId]):OnClickTitle()
  end
end

UIMaterialDungeon.InitDungeonList = function(self)
  -- function num : 0_2 , upvalues : _ENV, UIMatDungeonItem
  if self.dungeonItemPool == nil then
    self.dungeonItemPool = (UIItemPool.New)(UIMatDungeonItem, (self.ui).tog_DungeonItem)
    ;
    ((self.ui).tog_DungeonItem):SetActive(false)
  else
    ;
    (self.dungeonItemPool):HideAll()
  end
  if self.smallDungeonItemPool == nil then
    self.smallDungeonItemPool = (UIItemPool.New)(UIMatDungeonItem, (self.ui).tog_SmallDungeonItem)
    ;
    ((self.ui).tog_SmallDungeonItem):SetActive(false)
  else
    ;
    (self.smallDungeonItemPool):HideAll()
  end
  local topDungeonDatas = {}
  local subDungeonDataDic = {}
  for _,dungeonData in ipairs(self.dungeonDataList) do
    local subTtielId = dungeonData:GetSubTitleId()
    if subTtielId ~= nil then
      local list = subDungeonDataDic[subTtielId]
      if list == nil then
        list = {}
        subDungeonDataDic[subTtielId] = list
      end
      ;
      (table.insert)(list, dungeonData)
    else
      do
        do
          ;
          (table.insert)(topDungeonDatas, dungeonData)
          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC65: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for _,dungeonData in ipairs(topDungeonDatas) do
    local item = (self.dungeonItemPool):GetOne()
    item:InitDungeonItem(dungeonData, self.resLoader, self.__onItemClick)
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.dungeonItemDic)[dungeonData] = item
  end
  ;
  (self.subTitlePool):HideAll()
  self.subTitleDic = {}
  local subTitleIdList = (ConfigData.material_dungeon).subTitleIdList
  for _,subTitleId in ipairs(subTitleIdList) do
    local subTitleItem = (self.subTitlePool):GetOne()
    subTitleItem:SetSubTitleInfo((ConfigData.dungeonSubInfo)[subTitleId], self.resLoader, false, BindCallback(self, self.SubListShowState))
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.subTitleDic)[subTitleId] = subTitleItem
  end
  for key,value in pairs(subDungeonDataDic) do
    local subTitleItem = (self.subTitleDic)[key]
    for _,dungeonData in ipairs(value) do
      local item = (self.smallDungeonItemPool):GetOne()
      item:InitDungeonItem(dungeonData, self.resLoader, self.__onItemClick)
      -- DECOMPILER ERROR at PC132: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (self.dungeonItemDic)[dungeonData] = item
      ;
      (item.transform):SetParent(subTitleItem.transform, false)
      ;
      ((item.transform).gameObject):SetActive(false)
    end
  end
end

UIMaterialDungeon.InitDungeonStages = function(self, dungeonData)
  -- function num : 0_3 , upvalues : base, UIMatStageItemItem
  (base.InitDungeonStages)(self, dungeonData, UIMatStageItemItem)
end

UIMaterialDungeon.ShowDungeonDetail = function(self, item)
  -- function num : 0_4 , upvalues : _ENV, base
  local dungeonCfg = (item.dungeonData):GetDungeonCfg()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryName).text = (LanguageUtil.GetLocaleText)(dungeonCfg.name)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryDescr).text = (LanguageUtil.GetLocaleText)(dungeonCfg.des_info)
  local leftNum, playLimit, playedNums = (item.dungeonData):GetDungeonPlayLeftLimitNum()
  if leftNum == -1 then
    (((((self.ui).tex_LimitCount).transform).parent).gameObject):SetActive(false)
  else
    ;
    (((((self.ui).tex_LimitCount).transform).parent).gameObject):SetActive(true)
    ;
    ((self.ui).tex_LimitCount):SetIndex(0, tostring(leftNum), tostring(playLimit))
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Bg).texture = item.bannerTexture
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).texture = item.iconTexture
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_IconWidget).color = ((self.ui).bannerColor)[dungeonCfg.dungeon_img + 1]
  ;
  (base.ShowDungeonDetail)(self, item)
end

UIMaterialDungeon.SubListShowState = function(self, subId, isShowList)
  -- function num : 0_5 , upvalues : _ENV, CS_LayoutRebuilder
  for key,value in pairs(self.subTitleDic) do
    if key ~= subId then
      value.isShowOpen = false
      value:RefreshState()
    end
  end
  for k,v in pairs(self.dungeonItemDic) do
    if k:GetSubTitleId() == subId then
      (v.gameObject):SetActive(isShowList)
    else
      if k:GetSubTitleId() ~= nil then
        (v.gameObject):SetActive(false)
      end
    end
  end
  if isShowList then
    AudioManager:PlayAudioById(1069)
  end
  ;
  (CS_LayoutRebuilder.ForceRebuildLayoutImmediate)(((self.ui).scrollRoll).transform)
  ;
  ((self.ui).scrollRoll):RollToEnd()
end

UIMaterialDungeon.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIMaterialDungeon

