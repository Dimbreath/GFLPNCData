-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonBase = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonBase")
local UIATHDungeon = class("UIATHDungeon", UIDungeonBase)
local base = UIDungeonBase
local UIATHDungeonItem = require("Game.ATHDungeon.UI.UIATHDungeonItem")
local UIATHChapterItem = require("Game.ATHDungeon.UI.UIATHChapterItem")
local UIATHSuitDetailNode = require("Game.ATHDungeon.UI.UIATHSuitDetailNode")
local UIATHSuitItem = require("Game.ATHDungeon.UI.UIATHSuitItem")
local cs_MessageCommon = CS.MessageCommon
local eAthExtraType = {ExtraArea = 1, ExtraSuit = 2}
local eAthAreaType = {AreaA = 1, AreaB = 2, AreaC = 3, AreaAll = 4}
UIATHDungeon.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV, UIATHSuitItem, UIATHSuitDetailNode
  (base.OnInit)(self)
  self.onChapterItemClick = BindCallback(self, self.__loadExtraShowUI)
  self.onSuitItemClick = BindCallback(self, self._onSuitItemClick)
  self.SuitItemPool = (UIItemPool.New)(UIATHSuitItem, (self.ui).obj_SuitNode)
  ;
  ((self.ui).obj_SuitNode):SetActive(false)
  self.suitEffectNode = (UIATHSuitDetailNode.New)()
  ;
  (self.suitEffectNode):Init((self.ui).obj_SuitEffect)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Info, self, self.__OnClickBtnInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_DropInfoBg, self, self.__OnClickCloseBtnInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_DropInfoClose, self, self.__OnClickCloseBtnInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_dropAllSuit, self, self._OnClickDropAll)
end

UIATHDungeon.InitDungeonType = function(self, dungeonTypeData, selectItemId, onBackCallback)
  -- function num : 0_1 , upvalues : _ENV, base
  self.dungeonTypeUIEnum = UIWindowTypeID.ATHDungeon
  ;
  (base.InitDungeonType)(self, dungeonTypeData, selectItemId, onBackCallback)
end

UIATHDungeon.InitDungeonList = function(self)
  -- function num : 0_2 , upvalues : base, UIATHDungeonItem
  (base.InitDungeonList)(self, UIATHDungeonItem)
end

UIATHDungeon.InitDungeonStages = function(self, dungeonData)
  -- function num : 0_3 , upvalues : base, UIATHChapterItem, _ENV
  (base.InitDungeonStages)(self, dungeonData, UIATHChapterItem)
  for _,item in ipairs((self.dungeonStageItemPool).listItem) do
    item:SetAthStageClickEvent(self.onChapterItemClick)
    if item == (self.chaptersUI).selectChapterItem then
      (self.onChapterItemClick)(item)
    end
  end
end

UIATHDungeon.ShowDungeonDetail = function(self, item)
  -- function num : 0_4 , upvalues : _ENV, base
  local dungeonCfg = (item.dungeonData):GetDungeonCfg()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryName).text = (LanguageUtil.GetLocaleText)(dungeonCfg.name)
  self.double = (item.dungeonData):GetDungeonDoubleWithLimit()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_StoryBg).texture = item.bannerTexture
  ;
  (base.ShowDungeonDetail)(self, item)
end

UIATHDungeon.OnBattleStart = function(self)
  -- function num : 0_5 , upvalues : base
  local ATHRewardInfo = {}
  ATHRewardInfo.double = self.double
  ATHRewardInfo.haveDouble = self.haveDouble or 0
  ;
  (base.OnBattleStart)(self, ATHRewardInfo)
end

UIATHDungeon.EnterFormation = function(self, ...)
  -- function num : 0_6 , upvalues : _ENV, base, cs_MessageCommon
  local EnterFunc = BindCallback(self, base.EnterFormation, ...)
  if (ConfigData.game_config).athMaxNum - (ConfigData.game_config).athSpaceNotEnoughNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
    (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(145), EnterFunc, nil)
  else
    EnterFunc()
  end
end

UIATHDungeon.__loadExtraShowUI = function(self, stageItem)
  -- function num : 0_7 , upvalues : UIATHDungeon, eAthExtraType, _ENV
  local dungeonStageCfg = (stageItem.dungeonStageData):GetDungeonStageCfg()
  local extraType = dungeonStageCfg.day_extra_type
  local extraShow = UIATHDungeon:GetATHExtraCfgData(dungeonStageCfg.day_extra_type, dungeonStageCfg.day_extra_show)
  ;
  (self.SuitItemPool):HideAll()
  ;
  (((self.ui).btn_dropAllSuit).gameObject):SetActive(false)
  ;
  (((self.ui).btn_dropAllArea).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Info).gameObject):SetActive(true)
  if extraType == eAthExtraType.ExtraArea then
    (((self.ui).btn_dropAllArea).gameObject):SetActive(true)
    ;
    (((self.ui).btn_Info).gameObject):SetActive(false)
    return 
  end
  if extraType == eAthExtraType.ExtraSuit then
    if #extraShow >= 10 then
      (((self.ui).btn_dropAllSuit).gameObject):SetActive(true)
    else
      for index = 1, #extraShow do
        local item = (self.SuitItemPool):GetOne()
        item:InitATHSuitItem(extraShow[index], self.resLoader)
        item.clickEvent = self.onSuitItemClick
      end
      ;
      (self.suitEffectNode):SetCoulClickThroughGos((self.SuitItemPool).listItem)
    end
    return 
  end
  error("day_extra_type err:" .. tostring(extraType))
end

UIATHDungeon.GetATHExtraCfgData = function(self, cfgType, cfgShow)
  -- function num : 0_8 , upvalues : _ENV
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local weekNum = timePassCtrl:GetLogicWeekNum()
  local list = (string.split)(cfgShow, "|")
  local dataList = {}
  for k,v in ipairs(list) do
    local tmpList = (string.split)(v, "=")
    if #tmpList >= 2 and tonumber(tmpList[1]) == weekNum then
      dataList = (CommonUtil.SplitStrToNumber)(tmpList[2], "_")
      return dataList
    end
  end
  error("day_extra_show err this day:" .. weekNum)
  return dataList
end

UIATHDungeon._onSuitItemClick = function(self, suitItem)
  -- function num : 0_9
  (self.suitEffectNode):InitSuitDetailNode(suitItem.athSuitId, self.resLoader)
  ;
  (self.suitEffectNode):Show()
end

UIATHDungeon._OnClickDropAll = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.ATH_Dungeon_All_Area_Extra_Msg))
end

UIATHDungeon.__OnClickBtnInfo = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (UIUtil.HideTopStatus)()
  ;
  (((self.ui).obj_DropInfo).gameObject):SetActive(true)
end

UIATHDungeon.__OnClickCloseBtnInfo = function(self)
  -- function num : 0_12 , upvalues : _ENV
  (UIUtil.ReShowTopStatus)()
  ;
  (((self.ui).obj_DropInfo).gameObject):SetActive(false)
end

UIATHDungeon.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHDungeon

