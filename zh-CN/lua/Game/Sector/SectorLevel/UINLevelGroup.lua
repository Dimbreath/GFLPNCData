local UINLevelGroup = class("UINLevelGroup", UIBaseNode)
local base = UIBaseNode
local UINLevelItem = require("Game.Sector.SectorLevel.UINLevelItem")
local UINLevelAvgMain = require("Game.Sector.SectorLevel.UINLevelAvgMain")
local UINLevelAvgSub = require("Game.Sector.SectorLevel.UINLevelAvgSub")
local UINLevelLine = require("Game.Sector.SectorLevel.UINLevelLine")
local eLevelLineType = require("Game.Sector.Enum.eLevelLineType")
local UICanvasBg = require("Game.Sector.SectorLevel.UIDiffLevelCanvasBg")
UINLevelGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLevelItem, UINLevelAvgMain, UINLevelAvgSub, UINLevelLine, UICanvasBg
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).levelItem):SetActive(false)
  self.levelItemPool = (UIItemPool.New)(UINLevelItem, (self.ui).levelItem)
  ;
  ((self.ui).plotItem):SetActive(false)
  self.lAvgMainItemPool = (UIItemPool.New)(UINLevelAvgMain, (self.ui).plotItem)
  ;
  ((self.ui).subPlotItem):SetActive(false)
  self.lAvgSubItemPool = (UIItemPool.New)(UINLevelAvgSub, (self.ui).subPlotItem)
  ;
  ((self.ui).lineItem):SetActive(false)
  self.levelLineItem = (UIItemPool.New)(UINLevelLine, (self.ui).lineItem)
  self.UICanvasBg = (UICanvasBg.New)()
  ;
  (self.UICanvasBg):Init(((self.ui).rectBg).gameObject)
end

UINLevelGroup.InitLevelGroup = function(self, levelGroupData, lastEpStateCfg, arrangeCfg, lineHolder, bgHolder, stageCount, levelItemClickEvent, levelAvgMainClickEvent, lAvgSubClickEvent, resLoader, sectorLevelTipsGuides, isLastGroup)
  -- function num : 0_1 , upvalues : _ENV, eLevelLineType
  self.arrangeCfg = arrangeCfg
  self.lastEpStateCfg = lastEpStateCfg
  self.levelItemClickEvent = levelItemClickEvent
  self.lAvgMainClickEvent = levelAvgMainClickEvent
  self.lAvgSubClickEvent = lAvgSubClickEvent
  self.resLoader = resLoader
  self.sectorLevelTipsGuides = sectorLevelTipsGuides
  self:DesyroyLastTipsGuide()
  local lastCfg = arrangeCfg[#levelGroupData]
  if #lastCfg.pos ~= 2 then
    error((string.format)("levelArrange cfg pos error, typeId:%s, id:%s", lastCfg.typeId, lastCfg.id))
    return 
  end
  local isFirstGroup = levelGroupData.startIndex == 1
  local startIsLeft = false
  local isVertical = lastCfg.vertical
  self.isVertical = isVertical
  local width = 0
  local height = 0
  if isVertical then
    if not isLastGroup or not (self.ui).lastPadding then
      height = (math.abs)((lastCfg.pos)[2]) + (self.ui).padding
      local halfWidth = 0
      for k,v in ipairs(arrangeCfg) do
        local value = (math.abs)((v.pos)[1])
        halfWidth = (math.max)(halfWidth, value)
      end
      width = halfWidth + (self.ui).storyLineLength + (self.ui).padding
      do
        local parentWidth = ((((self.transform).parent).parent).rect).width
        width = (math.max)(width, parentWidth)
        startIsLeft = ((arrangeCfg[2]).pos)[1] - ((arrangeCfg[1]).pos)[1] > 0
        local halfHeight = 0
        for k,v in ipairs(arrangeCfg) do
          local value = (math.abs)((v.pos)[2])
          halfHeight = (math.max)(halfHeight, value)
        end
        height = halfHeight + (self.ui).storyLineLength + (self.ui).padding
        local parentHeight = ((((self.transform).parent).parent).rect).height
        height = (math.max)(height, parentHeight)
        if not isLastGroup or not (self.ui).lastPadding then
          do
            width = (math.abs)((lastCfg.pos)[1]) + (self.ui).padding
            startIsLeft = ((arrangeCfg[2]).pos)[2] - ((arrangeCfg[1]).pos)[2] > 0
            -- DECOMPILER ERROR at PC159: Confused about usage of register: R19 in 'UnsetPending'

            ;
            ((self.ui).layoutElement).preferredWidth = width
            -- DECOMPILER ERROR at PC162: Confused about usage of register: R19 in 'UnsetPending'

            ;
            ((self.ui).layoutElement).preferredHeight = height
            local sizeDelta = (Vector2.New)(width, height)
            -- DECOMPILER ERROR at PC169: Confused about usage of register: R20 in 'UnsetPending'

            ;
            (self.transform).sizeDelta = sizeDelta
            -- DECOMPILER ERROR at PC172: Confused about usage of register: R20 in 'UnsetPending'

            ;
            ((self.ui).lineList).sizeDelta = sizeDelta
            ;
            (self.levelItemPool):HideAll()
            ;
            (self.lAvgMainItemPool):HideAll()
            ;
            (self.lAvgSubItemPool):HideAll()
            ;
            (self.levelLineItem):HideAll()
            local lastPos = nil
            self.itemConnectedLineDic = {}
            self.lAvgSubItemDic = {}
            self.__itemList = {}
            local sectorLevelWindow = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
            if sectorLevelWindow == nil then
              return 
            end
            local selectedLvId = sectorLevelWindow:GetSelectedStageId()
            local selectedLAvgMainId = sectorLevelWindow:GetSelectedLAvgMainId()
            for k,v in ipairs(levelGroupData) do
              local startPos = nil
              local randomSeed = 0
              local tempItem = {levelItem = nil, lAvgMainItem = nil}
              if v.stageCfg ~= nil then
                local stageCfg = v.stageCfg
                local levelItem = (self.levelItemPool):GetOne()
                tempItem.levelItem = levelItem
                levelItem:InitSectorLevelItem(stageCfg, arrangeCfg[k], self.levelItemClickEvent, resLoader)
                if self.lastEpStateCfg ~= nil then
                  if (self.lastEpStateCfg).num == stageCfg.num then
                    levelItem:OnClickLevelItem()
                    levelItem:LevelItemShowContinue(true)
                  else
                    levelItem:DisableSelectLevelItem(true)
                  end
                end
                if selectedLvId == stageCfg.id then
                  levelItem:SeletedLevelItem(true, false)
                end
                startPos = (levelItem.transform).localPosition
                randomSeed = stageCfg.id
                self:__ShowLAvgSubItem(levelItem, isVertical)
                -- DECOMPILER ERROR at PC259: Confused about usage of register: R34 in 'UnsetPending'

                ;
                (self.__itemList)[k] = levelItem
                self:SectorLevelTryTipsGuide(levelItem, stageCfg.id, false)
              elseif v.avgCfg ~= nil then
                local avgCfg = v.avgCfg
                local lAvgMainItem = (self.lAvgMainItemPool):GetOne()
                tempItem.lAvgMainItem = lAvgMainItem
                lAvgMainItem:InitLAvgMain(avgCfg, arrangeCfg[k], self.lAvgMainClickEvent, resLoader)
                startPos = (lAvgMainItem.transform).localPosition
                randomSeed = avgCfg.id
                -- DECOMPILER ERROR at PC284: Confused about usage of register: R34 in 'UnsetPending'

                ;
                (self.__itemList)[k] = lAvgMainItem
                if selectedLAvgMainId == avgCfg.id then
                  lAvgMainItem:SelectedLAvgMain(true)
                end
                self:SectorLevelTryTipsGuide(lAvgMainItem, avgCfg.id, true)
              else
                error("levelGroupData error")
              end
              local angle = 0
              local length, lineType = nil, nil
              local isFirstStage = not isFirstGroup or k == 1
              if not isVertical or not 90 then
                angle = not isFirstStage or 180
              end
              length = (self.ui).padding
              lineType = eLevelLineType.BetweenLevelFull
              if k == 1 then
                lastPos = (Vector3.New)(startPos.x, startPos.y, startPos.z)
                if isVertical then
                  lastPos.y = lastPos.y - (math.abs)(((arrangeCfg[1]).pos)[2]) - (self.ui).padding
                  lastPos.x = lastPos.x + (((arrangeCfg[#arrangeCfg]).pos)[1] - ((arrangeCfg[1]).pos)[1])
                else
                  lastPos.x = lastPos.x - (math.abs)(((arrangeCfg[1]).pos)[1]) - (self.ui).padding
                  lastPos.y = lastPos.y + (((arrangeCfg[#arrangeCfg]).pos)[2] - ((arrangeCfg[1]).pos)[2])
                end
              end
              length = (Vector3.Distance)(lastPos, startPos)
              do
                local dirVector = lastPos - startPos
                angle = (Vector3.Angle)(Vector3.right, dirVector)
                if not isVertical and dirVector.y < 0 then
                  angle = angle * -1
                end
                if v.stageCfg ~= nil and (PlayerDataCenter.sectorStage):IsStageComplete((v.stageCfg).id) then
                  lineType = eLevelLineType.BetweenLevelFull
                elseif v.avgCfg ~= nil and (ControllerManager:GetController(ControllerTypeId.AvgPlay)):IsAvgPlayed((v.avgCfg).id) then
                  lineType = eLevelLineType.BetweenLevelFull
                else
                  lineType = eLevelLineType.BetweenLevel
                end
                local lineItem = (self.levelLineItem):GetOne()
                lineItem:InitLevelLine(lineType, startPos, angle, length)
                -- DECOMPILER ERROR at PC440: Confused about usage of register: R37 in 'UnsetPending'

                if not isFirstStage then
                  (self.itemConnectedLineDic)[tempItem] = lineItem
                end
                lineType = eLevelLineType.Decorate
                ;
                (math.randomseed)(randomSeed)
                local isLeft = self:__IsOuNumber(levelGroupData.startIndex + k)
                if not startIsLeft then
                  isLeft = not isLeft
                end
                local isLastStage = stageCount == levelGroupData.startIndex + k - 1
                angle = self:__GetDecorateLineAngle(isVertical, isFirstStage, isLastStage, 1, isLeft)
                local lineItem = (self.levelLineItem):GetOne()
                lineItem:InitLevelLine(lineType, startPos, angle)
                angle = self:__GetDecorateLineAngle(isVertical, isFirstStage, isLastStage, 2, isLeft)
                do
                  local lineItem = (self.levelLineItem):GetOne()
                  lineItem:InitLevelLine(lineType, startPos, angle)
                  lastPos = startPos
                  -- DECOMPILER ERROR at PC493: LeaveBlock: unexpected jumping out DO_STMT

                end
              end
            end
            ;
            ((self.ui).lineList):SetParent(lineHolder)
            ;
            (self.UICanvasBg):SetCanvasBgParent(bgHolder, sizeDelta)
            ;
            (self.UICanvasBg):PlayBgAnima()
            -- DECOMPILER ERROR: 34 unprocessed JMP targets
          end
        end
      end
    end
  end
end

UINLevelGroup.DesyroyLastTipsGuide = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.lastSectorTipsGuide ~= nil then
    for k,v in pairs(self.lastSectorTipsGuide) do
      DestroyUnityObject(v.gameObject)
    end
    self.lastSectorTipsGuide = nil
  end
end

UINLevelGroup.SectorLevelTryTipsGuide = function(self, item, id, isAvg)
  -- function num : 0_3 , upvalues : _ENV
  if (self.sectorLevelTipsGuides)[isAvg] ~= nil then
    local tipsGuideDic = (self.sectorLevelTipsGuides)[isAvg]
    if tipsGuideDic[id] ~= nil then
      local show_dir = tipsGuideDic[id]
      do
        (self.resLoader):LoadABAssetAsync(PathConsts:GetUIPrefabPath(GuideUtil.TipsGuidePrefabName), function(guidePrefab)
    -- function num : 0_3_0 , upvalues : _ENV, item, show_dir, self
    local guideItem = (GuideUtil.ShowTipsGuide)(item.transform, guidePrefab, show_dir)
    if not self.lastSectorTipsGuide then
      self.lastSectorTipsGuide = {}
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.lastSectorTipsGuide)[item] = guideItem
    end
  end
)
      end
    end
  end
end

UINLevelGroup.SectorLevelClearTipsGuide = function(self, item)
  -- function num : 0_4 , upvalues : _ENV
  if IsNull(item.gameObject) then
    return 
  end
  local tipsGuideNodeName = (GuideUtil.GetTipsGuideNodeName)((item.gameObject).name)
  local tipsGuideNode = (item.transform):Find(tipsGuideNodeName)
  if not IsNull(tipsGuideNode) then
    DestroyUnityObject(tipsGuideNode.gameObject)
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  if self.lastSectorTipsGuide ~= nil then
    (self.lastSectorTipsGuide)[item] = nil
  end
end

UINLevelGroup.__ShowLAvgSubItem = function(self, levelItem, isVertical)
  -- function num : 0_5 , upvalues : _ENV, eLevelLineType
  local stageCfg = levelItem:GetLevelStageData()
  if not (PlayerDataCenter.sectorStage):IsStageComplete(stageCfg.id) then
    return 
  end
  if (self.lAvgSubItemDic)[levelItem] ~= nil then
    return 
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.SubAvg, stageCfg.id, nil)
  if avgCfg == nil then
    return 
  end
  if not avgPlayCtrl:IsAvgUnlock(avgCfg.id) then
    return 
  end
  local startPos = (levelItem.transform).localPosition
  local offset = isVertical and 0 or -90
  ;
  (math.randomseed)(stageCfg.id)
  local angle = (math.random)((self.ui).range_subAvg_angleA + offset, (self.ui).range_subAvg_angleB + offset)
  local length = (math.random)((self.ui).range_subAvg_lengthA, (self.ui).range_subAvg_lengthB)
  local rad = (math.rad)(angle)
  local y = (math.sin)(rad) * length + startPos.y
  local x = (math.cos)(rad) * length + startPos.x
  local endPos = (Vector3.New)(x, y, startPos.z)
  local lineItem = (self.levelLineItem):GetOne()
  lineItem:InitLevelLine(eLevelLineType.BetweenLevel, startPos, angle, length)
  local lAvgSubItem = (self.lAvgSubItemPool):GetOne()
  lAvgSubItem:InitLAvgSub(endPos, avgCfg, self.lAvgSubClickEvent)
  -- DECOMPILER ERROR at PC105: Confused about usage of register: R16 in 'UnsetPending'

  ;
  (self.lAvgSubItemDic)[levelItem] = lAvgSubItem
end

UINLevelGroup.GetLevelItemByIndex = function(self, index)
  -- function num : 0_6
  return (self.__itemList)[index]
end

UINLevelGroup.__GetDecorateLineAngle = function(self, isVertical, isFirstStage, isLastStage, lineIndex, isLeft)
  -- function num : 0_7 , upvalues : _ENV
  local angle = nil
  local offset = isVertical and 0 or 90
  if isFirstStage then
    if lineIndex == 1 then
      angle = (math.random)((self.ui).range_start1A + offset, (self.ui).range_start1B + offset)
    else
      angle = (math.random)((self.ui).range_start2A + offset, (self.ui).range_start2B + offset)
    end
  else
    if isLastStage then
      if lineIndex == 1 then
        angle = (math.random)((self.ui).range_end1A + offset, (self.ui).range_end1B + offset)
      else
        angle = (math.random)((self.ui).range_end2A + offset, (self.ui).range_end2B + offset)
      end
    else
      if isLeft then
        if lineIndex == 1 then
          angle = (math.random)((self.ui).range_left1A + offset, (self.ui).range_left1B + offset)
        else
          angle = (math.random)((self.ui).range_left2A + offset, (self.ui).range_left2B + offset)
        end
      else
        if lineIndex == 1 then
          angle = (math.random)((self.ui).range_right1A + offset, (self.ui).range_right1B + offset)
        else
          angle = (math.random)((self.ui).range_right2A + offset, (self.ui).range_right2B + offset)
        end
      end
    end
  end
  return angle
end

UINLevelGroup.__IsOuNumber = function(self, num)
  -- function num : 0_8 , upvalues : _ENV
  local num1, num2 = (math.modf)(num / 2)
  if num2 == 0 then
    return true
  else
    return false
  end
end

UINLevelGroup.RefreshUncompletedEp = function(self, lastEpStateCfg)
  -- function num : 0_9 , upvalues : _ENV
  self.lastEpStateCfg = lastEpStateCfg
  for k,levelItem in ipairs((self.levelItemPool).listItem) do
    if lastEpStateCfg == nil then
      levelItem:DisableSelectLevelItem(false)
      levelItem:LevelItemShowContinue(false)
    else
      if lastEpStateCfg.num == (levelItem:GetLevelStageData()).num then
        levelItem:OnClickLevelItem()
        levelItem:LevelItemShowContinue(true)
      else
        levelItem:DisableSelectLevelItem(true)
      end
    end
  end
end

UINLevelGroup.RefreshLevelItemState = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in ipairs((self.levelItemPool).listItem) do
    v:RefreshLevelState()
    self:__ShowLAvgSubItem(v, self.isVertical)
  end
  for k,v in ipairs((self.lAvgMainItemPool).listItem) do
    v:RefreshLAvgMainState()
  end
  self:RefreshLevelConnectLineState()
end

UINLevelGroup.RefreshLevelConnectLineState = function(self)
  -- function num : 0_11 , upvalues : _ENV, eLevelLineType
  for k,lineItem in pairs(self.itemConnectedLineDic) do
    if k.levelItem ~= nil then
      local stageCfg = (k.levelItem):GetLevelStageData()
      if (PlayerDataCenter.sectorStage):IsStageComplete(stageCfg.id) then
        lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevelFull)
      else
        lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevel)
      end
    else
      do
        if k.lAvgMainItem ~= nil then
          local avgCfg = (k.lAvgMainItem):GetLAvgMainCfg()
          local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
          if avgPlayCtrl:IsAvgPlayed(avgCfg.id) then
            lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevelFull)
          else
            lineItem:RefreshLevelLineState(eLevelLineType.BetweenLevel)
          end
        end
        do
          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UINLevelGroup.OnReturnLevelGroup = function(self)
  -- function num : 0_12 , upvalues : _ENV
  ((self.ui).lineList):SetParent((self.ui).lineRoot)
  ;
  (self.UICanvasBg):SetCanvasBgParent((self.ui).BgRoot)
  for k,v in ipairs((self.levelItemPool).listItem) do
    v:OnReturnLevelItem()
  end
  for k,v in ipairs((self.lAvgMainItemPool).listItem) do
    v:OnReturnLAvgMainItem()
  end
end

UINLevelGroup.OnDelete = function(self)
  -- function num : 0_13 , upvalues : base
  (self.levelItemPool):DeleteAll()
  ;
  (self.lAvgMainItemPool):DeleteAll()
  ;
  (self.lAvgSubItemPool):DeleteAll()
  ;
  (self.levelLineItem):DeleteAll()
  ;
  (self.UICanvasBg):Delete()
  ;
  (base.OnDelete)(self)
end

return UINLevelGroup

