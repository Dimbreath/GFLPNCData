-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFmtEvaluation = class("UIFmtEvaluation", UIBaseNode)
local base = UIBaseNode
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local UIEvaluationItem = require("Game.Formation.UI.FormationEvaluation.UIFmtEvaluationItem")
UIFmtEvaluation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIEvaluationItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.evaluationItemPool = (UIItemPool.New)(UIEvaluationItem, (self.ui).evaluationItem)
end

UIFmtEvaluation.InitializeAdvantageConfig = function(self, sectorStageId, fromModuel)
  -- function num : 0_1 , upvalues : eFmtFromModule, _ENV
  self.careerDataDict = {}
  local stage = nil
  if fromModuel == eFmtFromModule.SectorLevel then
    stage = (ConfigData.sector_stage)[sectorStageId]
  else
    if fromModuel == eFmtFromModule.Infinity then
      local endlessLevel = ((ConfigData.endless).levelDic)[sectorStageId]
      if endlessLevel == nil then
        return 
      end
      stage = ((ConfigData.endless)[endlessLevel.sectorId])[endlessLevel.index]
    end
  end
  do
    if stage == nil then
      return 
    end
    for _,v in ipairs(stage.sup_career) do
      if (self.careerDataDict)[v] ~= nil then
        error("优劣势配置重复,关卡id:" .. sectorStageId)
      end
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.careerDataDict)[v] = true
    end
    for _,v in ipairs(stage.inf_career) do
      if (self.careerDataDict)[v] ~= nil then
        error("优劣势配置重复,关卡id:" .. sectorStageId)
      end
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.careerDataDict)[v] = false
    end
  end
end

UIFmtEvaluation.AnalysisFormation = function(self, formationDict)
  -- function num : 0_2 , upvalues : _ENV
  if self.evaluationItemPool ~= nil then
    (self.evaluationItemPool):HideAll()
  end
  self:__setCurFmtEvaluation(false)
  self.formationDict = formationDict
  self.careerDisAdvList = {}
  local careerDisAdvDict = {}
  local showAdvDic = {}
  for k,v in pairs(self.careerDataDict) do
    if v then
      showAdvDic[k] = false
    end
  end
  for k,v in pairs(self.formationDict) do
    if v ~= nil then
      local heroData = (PlayerDataCenter.heroDic)[v]
      if heroData ~= nil then
        local career = heroData.career
        if (self.careerDataDict)[career] == true then
          showAdvDic[career] = true
        else
          if (self.careerDataDict)[career] == false then
            careerDisAdvDict[career] = true
          end
        end
      end
    end
  end
  for k,v in pairs(careerDisAdvDict) do
    (table.insert)(self.careerDisAdvList, k)
  end
  if #self.careerDisAdvList > 0 then
    self:__setCurFmtEvaluation(true)
    ;
    (table.sort)(self.careerDisAdvList)
  end
  local advList = {}
  for k,v in pairs(showAdvDic) do
    (table.insert)(advList, k)
  end
  if #advList > 0 then
    (table.sort)(advList, function(a, b)
    -- function num : 0_2_0 , upvalues : showAdvDic
    if showAdvDic[a] ~= showAdvDic[b] then
      return showAdvDic[a]
    end
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  for _,v in ipairs(advList) do
    self:__generateEvaluationItem(v, true, showAdvDic[v])
  end
  for _,v in ipairs(self.careerDisAdvList) do
    self:__generateEvaluationItem(v, false, true)
  end
end

UIFmtEvaluation.IsFmtDisadvantage = function(self)
  -- function num : 0_3
  return self.__containDisadvantage
end

UIFmtEvaluation.GetDisadvantageDescribe = function(self)
  -- function num : 0_4 , upvalues : _ENV
  do
    if #self.careerDisAdvList > 0 then
      local content = nil
      for _,v in ipairs(self.careerDisAdvList) do
        local careerCfg = (ConfigData.career)[v]
        if careerCfg ~= nil then
          local nameStr = (LanguageUtil.GetLocaleText)(careerCfg.name)
          if content == nil then
            content = nameStr
          else
            content = content .. "、" .. nameStr
          end
        else
          do
            do
              error("找不到指定职业配置，职业id:" .. tostring(v))
              -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      return content
    end
    return nil
  end
end

UIFmtEvaluation.__generateEvaluationItem = function(self, careerId, isAdvantage, contains)
  -- function num : 0_5
  if self.evaluationItemPool == nil then
    return 
  end
  local item = (self.evaluationItemPool):GetOne()
  local textColor = (self.ui).disadvTextColor
  local bgColor = (self.ui).disadvBgColor
  if isAdvantage then
    if not contains then
      contains = false
    end
    if not contains or not (self.ui).advContainsTextColor then
      textColor = (self.ui).advTextColor
    end
    if not contains or not (self.ui).advContainsBgColor then
      bgColor = (self.ui).advBgColor
    end
  end
  item:UpdateItemDisplay(careerId, isAdvantage, textColor, bgColor)
end

UIFmtEvaluation.__setCurFmtEvaluation = function(self, isContainDisadvantage)
  -- function num : 0_6
  self.__containDisadvantage = isContainDisadvantage
end

UIFmtEvaluation.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIFmtEvaluation

