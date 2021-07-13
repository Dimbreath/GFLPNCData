-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFmtEvaluation = class("UIFmtEvaluation", UIBaseNode)
local base = UIBaseNode
local FmtEnum = require("Game.Formation.FmtEnum")
local FmtEnum = require("Game.Formation.FmtEnum")
local UIEvaluationItem = require("Game.Formation.UI.FormationEvaluation.UIFmtEvaluationItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UIFmtEvaluation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIEvaluationItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.evaluationItemPool = (UIItemPool.New)(UIEvaluationItem, (self.ui).evaluationItem)
  ;
  ((self.ui).evaluationItem):SetActive(false)
  self._onEvaluationItemPress = BindCallback(self, self._OnEvaluationItemPress)
  self._onEvaluationItemPressUp = BindCallback(self, self._OnEvaluationItemPressUp)
end

UIFmtEvaluation.InitializeAdvantageConfig = function(self, sectorStageId, fromModuel)
  -- function num : 0_1 , upvalues : FmtEnum, _ENV
  self.advTypeDic = {}
  local stage = nil
  if fromModuel == (FmtEnum.eFmtFromModule).SectorLevel then
    stage = (ConfigData.sector_stage)[sectorStageId]
  else
    if fromModuel == (FmtEnum.eFmtFromModule).Infinity then
      local endlessLevel = ((ConfigData.endless).levelDic)[sectorStageId]
      if endlessLevel == nil then
        return 
      end
      stage = ((ConfigData.endless)[endlessLevel.sectorId])[endlessLevel.index]
    else
      do
        if fromModuel == (FmtEnum.eFmtFromModule).MaterialDungeon or fromModuel == (FmtEnum.eFmtFromModule).ATHDungeon or fromModuel == (FmtEnum.eFmtFromModule).FriendshipDungeon then
          stage = (ConfigData.battle_dungeon)[sectorStageId]
        end
        if stage == nil then
          return 
        end
        for _,v in ipairs(stage.sup_career) do
          if (self.advTypeDic)[v] ~= nil then
            error("优劣势配置重复,关卡id:" .. sectorStageId)
          end
          -- DECOMPILER ERROR at PC61: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self.advTypeDic)[v] = true
        end
        for _,v in ipairs(stage.inf_career) do
          if (self.advTypeDic)[v] ~= nil then
            error("优劣势配置重复,关卡id:" .. sectorStageId)
          end
          -- DECOMPILER ERROR at PC78: Confused about usage of register: R9 in 'UnsetPending'

          ;
          (self.advTypeDic)[v] = false
        end
        self.stageCfg = stage
      end
    end
  end
end

UIFmtEvaluation.AnalysisFormation = function(self, formationDic)
  -- function num : 0_2 , upvalues : _ENV
  if self.evaluationItemPool ~= nil then
    (self.evaluationItemPool):HideAll()
  end
  self:__setCurFmtEvaluation(false)
  self.careerDisAdvList = {}
  local validAdvDic = self:__GetFormationAdvState(formationDic)
  for advTypeId,_ in pairs(validAdvDic) do
    if not (self.advTypeDic)[advTypeId] then
      (table.insert)(self.careerDisAdvList, advTypeId)
    end
  end
  if #self.careerDisAdvList > 0 then
    self:__setCurFmtEvaluation(true)
    ;
    (table.sort)(self.careerDisAdvList)
  end
  local advList = {}
  for advTypeId,isAdv in pairs(self.advTypeDic) do
    if isAdv then
      (table.insert)(advList, advTypeId)
    end
  end
  if #advList > 0 then
    (table.sort)(advList, function(a, b)
    -- function num : 0_2_0 , upvalues : validAdvDic
    if validAdvDic[a] ~= validAdvDic[b] then
      return validAdvDic[a]
    end
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  for index,advTypeId in ipairs(advList) do
    self:__generateEvaluationItem(advTypeId, true, validAdvDic[advTypeId])
  end
  for index,advTypeId in ipairs(self.careerDisAdvList) do
    self:__generateEvaluationItem(advTypeId, false, true)
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

UIFmtEvaluation.__generateEvaluationItem = function(self, advTypeId, isAdvantage, contains)
  -- function num : 0_5 , upvalues : FmtEnum
  if self.evaluationItemPool == nil then
    return 
  end
  local item = (self.evaluationItemPool):GetOne()
  local textColor = (self.ui).disadvTextColor
  local eColorType = (FmtEnum.eFmtEvaluationAdvant).inferior
  if isAdvantage then
    if not contains then
      contains = false
    end
    if not contains or not (self.ui).advContainsTextColor then
      textColor = (self.ui).advTextColor
    end
    if not contains or not (FmtEnum.eFmtEvaluationAdvant).advContain then
      eColorType = (FmtEnum.eFmtEvaluationAdvant).advantage
    end
  end
  item:UpdateItemDisplay(advTypeId, isAdvantage, textColor, eColorType)
  item:SetEvaluationItemClickAct(self._onEvaluationItemPress, self._onEvaluationItemPressUp)
end

UIFmtEvaluation._OnEvaluationItemPress = function(self, transform, advTypeId, isAdvantage)
  -- function num : 0_6 , upvalues : _ENV, HAType, VAType
  if isAdvantage ~= true or not (self.stageCfg).sup_career then
    local idList = (self.stageCfg).inf_career
  end
  if isAdvantage ~= true or not (self.stageCfg).sup_carrer_info then
    local infoIdList = (self.stageCfg).inf_carrer_info
  end
  if idList == nil or infoIdList == nil then
    return 
  end
  local advIndex = nil
  for index,id in ipairs(idList) do
    if id == advTypeId then
      advIndex = index
      break
    end
  end
  do
    if advIndex == nil then
      error("Cant find index by:" .. advTypeId)
      return 
    end
    local infoId = infoIdList[advIndex]
    if infoId == nil then
      return 
    end
    local sectorCareerInfoCfg = (ConfigData.sector_career_info)[infoId]
    local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
    win:SetTitleAndContext(nil, (LanguageUtil.GetLocaleText)(sectorCareerInfoCfg.info))
    win:FloatTo(transform, HAType.right, VAType.up, 0, 0.71, nil)
  end
end

UIFmtEvaluation._OnEvaluationItemPressUp = function(self)
  -- function num : 0_7
  self:_HideEvaluationItemInfo()
end

UIFmtEvaluation._HideEvaluationItemInfo = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

UIFmtEvaluation.__setCurFmtEvaluation = function(self, isContainDisadvantage)
  -- function num : 0_9
  self.__containDisadvantage = isContainDisadvantage
end

UIFmtEvaluation.__GetFormationAdvState = function(self, formationDic)
  -- function num : 0_10 , upvalues : _ENV
  local validAdvDic = {}
  for fmtIndex,heroId in pairs(formationDic) do
    local heroCfg = (ConfigData.hero_data)[heroId]
    local careerId = heroCfg.career
    local isRemote = heroCfg.range > 1
    if (self.advTypeDic)[careerId] ~= nil then
      validAdvDic[careerId] = true
    end
    -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

    if isRemote and (self.advTypeDic)[101] ~= nil then
      validAdvDic[101] = true
    end
    if (self.advTypeDic)[100] ~= nil then
      validAdvDic[100] = true
    end
  end
  do return validAdvDic end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIFmtEvaluation.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  self:_HideEvaluationItemInfo()
  ;
  (base.OnDelete)(self)
end

return UIFmtEvaluation

