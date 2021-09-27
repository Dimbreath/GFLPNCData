local UIDailyDungeonMain = class("UIDailyDungeonMain", UIBaseWindow)
local base = UIBaseWindow
local UINDailyLevelDifItem = require("Game.DailyDungeon.UI.LevelSelect.UINDailyLevelDifItem")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local cs_MessageCommon = CS.MessageCommon
UIDailyDungeonMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDailyLevelDifItem
  self.lvDifItemList = {}
  for k,holder in ipairs((self.ui).lvDifItemPosList) do
    local lvDifItem = (UINDailyLevelDifItem.New)()
    local go = ((self.ui).lvDifItem):Instantiate(holder)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (go.transform).anchoredPosition = Vector2.zero
    lvDifItem:Init(go)
    ;
    (table.insert)(self.lvDifItemList, lvDifItem)
  end
  ;
  ((self.ui).lvDifItem):SetActive(false)
  self._OnSelectDiffFunc = BindCallback(self, self._OnSelectDiff)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Shop, self, self.__OnClickDailyShop)
  ;
  (((self.ui).tex_RefreshTime).gameObject):SetActive(false)
  ;
  (UIUtil.SetTopStatus)(self, self._OnClickBack)
end

UIDailyDungeonMain.InitDailyDungeonMain = function(self, dailyDgCtrl, openCurDiff)
  -- function num : 0_1 , upvalues : _ENV
  self.dailyDgCtrl = dailyDgCtrl
  local dungeonDyncElem = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonDyncData()
  self.dungeonDyncElem = dungeonDyncElem
  local isNew = dungeonDyncElem.isDailyDungeonNew
  self._isNewStart = isNew
  ;
  ((self.ui).tex_Count):SetIndex(isNew and 1 or 0)
  self:_UpdItem(openCurDiff)
end

UIDailyDungeonMain._UpdItem = function(self, openCurDiff)
  -- function num : 0_2 , upvalues : _ENV, eDungeonEnum
  local dungeonUITypeDic = (ConfigData.material_dungeon).dungeonUITypeDic
  local dungeonIdList = dungeonUITypeDic[(eDungeonEnum.eDungeonType).DailyDungeon]
  if dungeonIdList == nil then
    error("Cant get dungeonUITypeDic, eDungeonEnum.eDungeonType.DailyDungeon")
    return 
  end
  for k,dungeonId in ipairs(dungeonIdList) do
    local matDungeonCfg = (ConfigData.material_dungeon)[dungeonId]
    local dungeonDyncElem = nil
    if not self._isNewStart and (self.dungeonDyncElem).moduleId == dungeonId then
      dungeonDyncElem = self.dungeonDyncElem
      if openCurDiff then
        self:_OnSelectDiff(matDungeonCfg)
      end
    end
    local lvDifItem = (self.lvDifItemList)[k]
    if lvDifItem ~= nil then
      lvDifItem:InitDailyLevelDifItem(k, matDungeonCfg, self._OnSelectDiffFunc, dungeonDyncElem)
    end
  end
end

UIDailyDungeonMain.UpdDailyDgMainTime = function(self, dInt, hStr, mStr, sStr)
  -- function num : 0_3 , upvalues : _ENV
  (((self.ui).tex_RefreshTime).gameObject):SetActive(true)
  if dInt > 0 then
    ((self.ui).tex_RefreshTime):SetIndex(0, tostring(dInt), hStr, mStr, sStr)
  else
    ;
    ((self.ui).tex_RefreshTime):SetIndex(1, hStr, mStr, sStr)
  end
end

UIDailyDungeonMain._OnSelectDiff = function(self, matDungeonCfg)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  if not self._isNewStart and matDungeonCfg.id ~= (self.dungeonDyncElem).moduleId then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2901))
    return 
  end
  local unlock = FunctionUnlockMgr:ValidateUnlock(matDungeonCfg.id)
  do
    if not unlock then
      local tips = FunctionUnlockMgr:GetFuncUnlockDecription(matDungeonCfg.id)
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(tips)
      return 
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.DailyDungeonLevel, function(win)
    -- function num : 0_4_0 , upvalues : self, matDungeonCfg
    if win == nil then
      return 
    end
    win:InitDailyDungeonLevel(self.dailyDgCtrl, matDungeonCfg, self._isNewStart, self.dungeonDyncElem)
  end
)
  end
end

UIDailyDungeonMain._OnClickBack = function(self, toHome)
  -- function num : 0_5
  (self.dailyDgCtrl):ExitDailyDungeon(toHome)
end

UIDailyDungeonMain.__OnClickDailyShop = function(self)
  -- function num : 0_6
  (self.dailyDgCtrl):OpenDailyDungeonShop()
end

UIDailyDungeonMain.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  for k,v in ipairs(self.lvDifItemList) do
    v:Delete()
  end
  UIManager:DeleteWindow(UIWindowTypeID.DailyDungeonLevel)
  ;
  (base.OnDelete)(self)
end

return UIDailyDungeonMain

