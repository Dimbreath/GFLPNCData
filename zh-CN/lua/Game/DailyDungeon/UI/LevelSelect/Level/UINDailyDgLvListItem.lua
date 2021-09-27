local UINDailyDgLvListItem = class("UINDailyDgLvListItem", UIBaseNode)
local base = UIBaseNode
local UINDailyDgListItemBossTag = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgListItemBossTag")
UINDailyDgLvListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINDailyDgLvListItem.InitDailyDgLvListItem = function(self, lvIndex, isComplete, isLock, isCurrent, bossId, resloader, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.lvIndex = lvIndex
  self.clickFunc = clickFunc
  self.resloader = resloader
  ;
  ((self.ui).isComplete):SetActive(isComplete)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = (string.format)("%02d", lvIndex)
  ;
  ((self.ui).lineItem):SetActive(lvIndex ~= 1)
  ;
  ((self.ui).img_LineItem):SetIndex(isLock and 1 or 0)
  ;
  ((self.ui).isLock):SetActive(isLock)
  if isLock then
    if lvIndex == 1 then
      ((self.ui).tex_Unlcok):SetIndex(1)
    else
      ((self.ui).tex_Unlcok):SetIndex(0, tostring(lvIndex - 1))
    end
  end
  ;
  ((self.ui).isCurStage):SetActive(isCurrent)
  local alpha = isCurrent and 1 or 0.2
  local col = (Color.New)(1, 1, 1, alpha)
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).img_title).color = col
  if bossId ~= nil then
    self:_InitBoss(bossId)
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

UINDailyDgLvListItem._InitBoss = function(self, bossId)
  -- function num : 0_2 , upvalues : _ENV, UINDailyDgListItemBossTag
  local monsterCfg = (ConfigData.monster)[bossId]
  if monsterCfg == nil then
    error("neutral Cfg is null,id:" .. tostring(bossId))
    return 
  end
  local resCfg = (ConfigData.resource_model)[monsterCfg.src_id]
  if resCfg == nil then
    error("resource model cfg is null,id:" .. tostring(monsterCfg.src_id))
    return 
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_BossName).text = (LanguageUtil.GetLocaleText)(monsterCfg.name)
  local path = nil
  if (string.IsNullOrEmpty)(resCfg.boss_lpic) then
    path = PathConsts:GetCharacterPicPath(resCfg.res_Name)
  else
    path = PathConsts:GetCharacterTexturePath(resCfg.boss_lpic)
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Boss).enabled = false
  ;
  (self.resloader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if IsNull(texture) then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Boss).texture = texture
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Boss).enabled = true
  end
)
  ;
  ((self.ui).bossTagItem):SetActive(false)
  if self.bossTagItemPool == nil then
    self.bossTagItemPool = (UIItemPool.New)(UINDailyDgListItemBossTag, (self.ui).bossTagItem)
  end
  ;
  (self.bossTagItemPool):HideAll()
  for k,tagId in ipairs(monsterCfg.monster_tag) do
    local tagCfg = (ConfigData.monster_tag)[tagId]
    if tagCfg == nil then
      error("Can\'t find tagCfg id=" .. tostring(tagId))
    else
      local bossItem = (self.bossTagItemPool):GetOne()
      bossItem:InitDailyDgListItemBossTag(tagCfg)
    end
  end
end

UINDailyDgLvListItem._OnClickRoot = function(self)
  -- function num : 0_3
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.lvIndex)
  end
end

UINDailyDgLvListItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  if self.bossTagItemPool ~= nil then
    (self.bossTagItemPool):DeleteAll()
  end
  ;
  (base.OnDelete)(self)
end

return UINDailyDgLvListItem

