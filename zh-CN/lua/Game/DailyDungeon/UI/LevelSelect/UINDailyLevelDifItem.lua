local UINDailyLevelDifItem = class("UINDailyLevelDifItem", UIBaseNode)
local base = UIBaseNode
UINDailyLevelDifItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINDailyLevelDifItem.InitDailyLevelDifItem = function(self, index, matDungeonCfg, clickFunc, dungeonDyncElem)
  -- function num : 0_1 , upvalues : _ENV
  self.clickFunc = clickFunc
  self.matDungeonCfg = matDungeonCfg
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_LevelName).text = (LanguageUtil.GetLocaleText)(matDungeonCfg.name)
  ;
  ((self.ui).tex_SubName):SetIndex(0, (string.format)("%02d", index))
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Tag).color = ((self.ui).diffColor)[index]
  ;
  ((self.ui).tex_Tag):SetIndex(index - 1)
  ;
  ((self.ui).tex_Traget):SetIndex(index - 1)
  local unlock = FunctionUnlockMgr:ValidateUnlock(matDungeonCfg.id)
  ;
  ((self.ui).unlockCondition):SetActive(not unlock)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

  if not unlock then
    ((self.ui).tex_Unlock).text = FunctionUnlockMgr:GetFuncUnlockDecription(matDungeonCfg.id)
  end
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local enterNum = timePassCtrl:GetCounterModuleDungeonEnter(matDungeonCfg.id)
  local isNew = not unlock or enterNum == 0
  ;
  ((self.ui).isNew):SetActive(isNew)
  local dropRangeCfg = matDungeonCfg.drop_range
  if #dropRangeCfg ~= 3 then
    error("matDungeonCfg.drop_range num error, id:" .. tostring(matDungeonCfg.id))
  else
    local itemId = dropRangeCfg[1]
    local itemCfg = (ConfigData.item)[itemId]
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.ui).img_Drop).sprite = CRH:GetSpriteByItemConfig(itemCfg)
    ;
    ((self.ui).tex_DropRange):SetIndex(0, tostring(dropRangeCfg[2]), tostring(dropRangeCfg[3]))
  end
  local inBattle = dungeonDyncElem ~= nil
  ;
  ((self.ui).process):SetActive(inBattle)
  ;
  ((self.ui).unProcess):SetActive(not inBattle)
  if inBattle then
    local allNum = #matDungeonCfg.stage_id
    local curNum = dungeonDyncElem.idx
    local progress = (math.floor)(curNum / allNum * 100)
    ;
    ((self.ui).tex_Process):SetIndex(0, tostring(progress))
    local profSex = (PlayerDataCenter.inforData):GetSex()
    local index = profSex == true and 1 or 0
    ;
    ((self.ui).img_ProfHead):SetIndex(index)
  end
  if not inBattle or not (self.ui).col_inBattleCol then
    local titltCol = Color.white
  end
  -- DECOMPILER ERROR at PC164: Confused about usage of register: R12 in 'UnsetPending'

  ;
  ((self.ui).img_title).color = titltCol
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

UINDailyLevelDifItem._OnClickRoot = function(self)
  -- function num : 0_2
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.matDungeonCfg)
  end
end

UINDailyLevelDifItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINDailyLevelDifItem

