-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisEditor = class("UIOasisEditor", UIBaseWindow)
local base = UIBaseWindow
local BuildingTypeData = require("Game.Oasis.Data.BuildingTypeData")
local UIOasisBuildItem = require("Game.Oasis.UI.Editor.UIOasisBuildItem")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local UINBuildLogicLvPreview = require("Game.StrategyOverview.UI.BuildLogicLvPreview.UINBuildLogicLvPreview")
local cs_ResLoader = CS.ResLoader
local sortStateDic = {[4] = 1, [1] = 2, [3] = 3, [2] = 4, max = 5}
UIOasisEditor.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIOasisBuildItem, cs_ResLoader, UINBuildLogicLvPreview
  ((self.ui).buildingItem):SetActive(false)
  self.buildItemPool = (UIItemPool.New)(UIOasisBuildItem, (self.ui).buildingItem)
  self.resLoader = (cs_ResLoader.Create)()
  self.newBuildingFunc = BindCallback(self, self._OnClickNewBuilding)
  self.previewBuildFunc = BindCallback(self, self._OnClickPreview)
  self.buildEditPreviewNode = (UINBuildLogicLvPreview.New)()
  ;
  (self.buildEditPreviewNode):Init((self.ui).logicPreviewNode)
  ;
  (self.buildEditPreviewNode):Hide()
end

UIOasisEditor.InitOasisEditor = function(self, oasisCtrl)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.__ExitEditor)
  self.oasisCtrl = oasisCtrl
  self:RefreshOasisEditSideBar()
  ;
  ((self.ui).adapter):SetActive(true)
  self:ShowOasisEditorSideTween(true)
end

UIOasisEditor.RefreshOasisEditSideBar = function(self)
  -- function num : 0_2 , upvalues : BuildingTypeData, _ENV
  local buildTypeDataList = (BuildingTypeData.CreateAllBuildTypeData)()
  self.buildTypeDataList = buildTypeDataList
  ;
  (table.sort)(buildTypeDataList, self.__SortBuildTypeDataFunc)
  ;
  (self.buildItemPool):HideAll()
  for k,buildTypeData in ipairs(buildTypeDataList) do
    local buildItem = (self.buildItemPool):GetOne()
    buildItem:InitOasisBuildItem(buildTypeData, self.resLoader, self.newBuildingFunc, self.previewBuildFunc)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (buildItem.gameObject).name = tostring(k)
  end
end

UIOasisEditor.__SortBuildTypeDataFunc = function(a, b)
  -- function num : 0_3 , upvalues : sortStateDic, UIOasisEditor
  local buildTypeA = a:GetBuildTypeState()
  local buildTypeB = b:GetBuildTypeState()
  local sortIdA = sortStateDic[buildTypeA] or sortStateDic.max
  local sortIdB = sortStateDic[buildTypeB] or sortStateDic.max
  local buildDataA = a:GetNextUnlockBuildData()
  local buildDataB = b:GetNextUnlockBuildData()
  if sortIdA == sortIdB then
    if buildTypeA == 1 or buildTypeB == 3 then
      local stateIdA, mainBuildLvA = (UIOasisEditor.__GetStageIdAndBuildingLevel)(buildDataA)
      local stateIdB, mainBuildLvB = (UIOasisEditor.__GetStageIdAndBuildingLevel)(buildDataB)
      if mainBuildLvA == mainBuildLvB then
        if buildDataA.id >= buildDataB.id then
          do
            do return stateIdA ~= stateIdB end
            do return mainBuildLvA < mainBuildLvB end
            do return stateIdA < stateIdB end
            do return buildDataA.id < buildDataB.id end
            do return sortIdA < sortIdB end
            -- DECOMPILER ERROR: 10 unprocessed JMP targets
          end
        end
      end
    end
  end
end

UIOasisEditor.__GetStageIdAndBuildingLevel = function(buildingData)
  -- function num : 0_4 , upvalues : _ENV, CheckerTypeId
  local lv1Cfg = (buildingData.levelConfig)[1]
  local completeStateId = 999999
  local mainBuildingLv = 999999
  for k,conditionId in ipairs(lv1Cfg.pre_condition) do
    if conditionId == CheckerTypeId.CompleteStage then
      completeStateId = (lv1Cfg.pre_para1)[k]
    else
      if conditionId == CheckerTypeId.BuildingLevel and (lv1Cfg.pre_para1)[k] == eBuildingId.OasisMainBuilding then
        mainBuildingLv = (lv1Cfg.pre_para2)[k]
      end
    end
  end
  return completeStateId, mainBuildingLv
end

UIOasisEditor.ShowOasisEditorSideTween = function(self, show)
  -- function num : 0_5 , upvalues : _ENV
  if self.sideIsShow == show then
    return 
  end
  self.sideIsShow = show
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if show then
    ((self.ui).scrollRect).verticalNormalizedPosition = 1
    ;
    ((self.ui).sideTween):DORestart()
    AudioManager:PlayAudioById(1001)
  else
    ;
    ((self.ui).sideTween):DOPlayBackwards()
    AudioManager:PlayAudioById(1002)
  end
end

UIOasisEditor._OnClickNewBuilding = function(self, buildItem)
  -- function num : 0_6
  (self.oasisCtrl):NewBuilding(buildItem.buildingData)
  self:ShowOasisEditorSideTween(false)
end

UIOasisEditor._OnClickPreview = function(self, buildingData)
  -- function num : 0_7
  (self.buildEditPreviewNode):Show()
  ;
  (self.buildEditPreviewNode):InitBuildLogicLvPreview(buildingData, true)
end

UIOasisEditor.__ExitEditor = function(self)
  -- function num : 0_8
  (self.oasisCtrl):ExitEditMode()
  ;
  ((self.ui).adapter):SetActive(false)
  self:ShowOasisEditorSideTween(false)
end

UIOasisEditor.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.buildItemPool):DeleteAll()
  ;
  (self.buildEditPreviewNode):Delete()
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIOasisEditor

