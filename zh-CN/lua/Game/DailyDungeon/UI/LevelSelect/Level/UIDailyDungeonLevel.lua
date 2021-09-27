local UIDailyDungeonLevel = class("UIDailyDungeonLevel", UIBaseWindow)
local base = UIBaseWindow
local UINDailyDgLvList = require("Game.DailyDungeon.UI.LevelSelect.Level.UINDailyDgLvList")
local FmtEnum = require("Game.Formation.FmtEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UIDailyDungeonLevel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINDailyDgLvList, cs_ResLoader
  (UIUtil.AddButtonListener)((self.ui).btn_Shop, self, self.__OnClickDailyShop)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_HeroFmt, self, self.__OnClickEnterFmt)
  self.dailyDgList = (UINDailyDgLvList.New)()
  ;
  (self.dailyDgList):Init((self.ui).levelScroll)
  self._clickLevelFunc = BindCallback(self, self._OnClickLevel)
  self.resloader = (cs_ResLoader.Create)()
  ;
  (((self.ui).tex_Time).gameObject):SetActive(false)
end

UIDailyDungeonLevel.InitDailyDungeonLevel = function(self, dailyDgCtrl, matDungeonCfg, isNewStart, dungeonDyncElem)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self._OnClickBack)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Title).text = (LanguageUtil.GetLocaleText)(matDungeonCfg.name)
  self.isNewStart = isNewStart
  self.dungeonDyncElem = dungeonDyncElem
  self.matDungeonCfg = matDungeonCfg
  local levelNum = #matDungeonCfg.stage_id
  local inDungeon = false
  local curLvIdx = 0
  if not isNewStart and dungeonDyncElem.moduleId == matDungeonCfg.id then
    curLvIdx = dungeonDyncElem.idx
    inDungeon = true
  end
  self.dailyDgCtrl = dailyDgCtrl
  ;
  (self.dailyDgList):InitDailyDgLvList(levelNum, curLvIdx, inDungeon, matDungeonCfg, self.resloader, self._clickLevelFunc)
  local progress = (math.floor)(curLvIdx / levelNum * 100)
  ;
  ((self.ui).tex_Process):SetIndex(0, tostring(progress))
  local profSex = (PlayerDataCenter.inforData):GetSex()
  local index = profSex == true and 1 or 0
  ;
  ((self.ui).img_ProfHead):SetIndex(index)
end

UIDailyDungeonLevel.UpdDailyDgLevelTime = function(self, dInt, hStr, mStr, sStr)
  -- function num : 0_2 , upvalues : _ENV
  (((self.ui).tex_Time).gameObject):SetActive(true)
  if dInt > 0 then
    ((self.ui).tex_Time):SetIndex(0, tostring(dInt), hStr, mStr, sStr)
  else
    ;
    ((self.ui).tex_Time):SetIndex(1, hStr, mStr, sStr)
  end
end

UIDailyDungeonLevel._OnClickLevel = function(self, levelIndex)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  if not self.isNewStart and (self.dungeonDyncElem).moduleId ~= (self.matDungeonCfg).id then
    return 
  end
  if levelIndex <= (self.dungeonDyncElem).idx then
    return 
  end
  if (self.dungeonDyncElem).idx + 1 < levelIndex then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(2902))
    return 
  end
  local enterFunc = function()
    -- function num : 0_3_0 , upvalues : self, levelIndex
    if not self.active then
      return 
    end
    local stageId = ((self.matDungeonCfg).stage_id)[levelIndex]
    ;
    (self.dailyDgCtrl):ReqEnterDailyDungeon(stageId)
  end

  if self.isNewStart then
    local name = (LanguageUtil.GetLocaleText)((self.matDungeonCfg).name)
    local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    msgWindow:ShowTextBoxWithYesAndNo((string.format)(ConfigData:GetTipContent(2900), name), enterFunc)
  else
    do
      enterFunc()
    end
  end
end

UIDailyDungeonLevel.__OnClickDailyShop = function(self)
  -- function num : 0_4
  (self.dailyDgCtrl):OpenDailyDungeonShop()
end

UIDailyDungeonLevel.__OnClickEnterFmt = function(self)
  -- function num : 0_5 , upvalues : _ENV, FmtEnum
  local enterFunc = function()
    -- function num : 0_5_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.DailyDungeonMain)
    UIManager:HideWindow(UIWindowTypeID.DailyDungeonLevel)
    UIManager:HideWindow(UIWindowTypeID.Sector)
  end

  local exitFunc = function(fmtId)
    -- function num : 0_5_1 , upvalues : _ENV
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    saveUserData:SetLastDailyFormationId(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.DailyDungeonMain, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.DailyDungeonLevel, true)
    UIManager:ShowWindowOnly(UIWindowTypeID.Sector, true)
  end

  local fmtCtrl = (ControllerManager:GetController(ControllerTypeId.Formation, true))
  -- DECOMPILER ERROR at PC8: Overwrote pending register: R4 in 'AssignReg'

  local stageId, startBattleFunc = .end, nil
  local lastFmtId = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastDailyFormationId()
  fmtCtrl:InitFromationCtrl((FmtEnum.eFmtFromModule).DailyDungeonLevel, stageId, enterFunc, exitFunc, startBattleFunc, nil, lastFmtId, nil, nil)
end

UIDailyDungeonLevel._OnClickBack = function(self)
  -- function num : 0_6
  self:Hide()
end

UIDailyDungeonLevel.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.dailyDgList):Delete()
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  ;
  (base.OnDelete)(self)
end

return UIDailyDungeonLevel

