-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideManager = {}
local GuideEnum = require("Game.Guide.GuideEnum")
local GuideConditionChecker = require("Game.Guide.GuideConditionChecker")
local GuideType_Normal = require("Game.Guide.GuideType.GuideType_Normal")
local GuideType_NormalTrigger = require("Game.Guide.GuideType.GuideType_NormalTrigger")
local GuideType_Tips = require("Game.Guide.GuideType.GuideType_Tips")
local skipGuide = (GR.SkipGameGuide)()
local FirstBattleGuideCtrl = require("Game.Guide.FristBattleGuideCtrl")
GuideManager.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV, FirstBattleGuideCtrl, GuideType_Normal, GuideType_NormalTrigger
  self:__SetInGuide(false)
  self.resloader = ((CS.ResLoader).Create)()
  self.firstBattleGuideCtrl = FirstBattleGuideCtrl
  self.__normalGuideCtrl = (GuideType_Normal.New)()
  self.__triggerGuideCtrl = (GuideType_NormalTrigger.New)()
  self.__triggerGuideComplete = nil
  self.__allTriggerGuideComplete = false
  self:__InitTriggerEvent()
  self.__curGuideCtrl = nil
end

GuideManager.__SetInGuide = function(self, active)
  -- function num : 0_1 , upvalues : _ENV
  self.inGuide = active
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  GR.InGuide = active
end

GuideManager.InitCompleteTriggerGuide = function(self, completeDic)
  -- function num : 0_2 , upvalues : _ENV, GuideConditionChecker
  self.__triggerGuideUnfinished = {}
  local isAllCompelete = true
  for _,guideId in pairs((ConfigData.guide).trigger_guide_list) do
    if not completeDic[guideId] then
      local guideCfg = (ConfigData.guide)[guideId]
      if guideCfg == nil then
        error("guide cfg is null,id:" .. tostring(guideCfg.id))
        return false
      end
      if (GuideConditionChecker.CheckTriggerGuideCondition)(guideCfg.guide_condition, guideCfg.guide_arg) then
        local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R11 in 'UnsetPending'

        if not (self.__triggerGuideUnfinished)[cfgCondition] then
          do
            do
              (self.__triggerGuideUnfinished)[cfgCondition] = {}
              -- DECOMPILER ERROR at PC43: Confused about usage of register: R11 in 'UnsetPending'

              ;
              ((self.__triggerGuideUnfinished)[cfgCondition])[guideId] = guideCfg
              isAllCompelete = false
              -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  if not isAllCompelete then
    self.__triggerGuideComplete = completeDic
    MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
    MsgCenter:AddListener(eMsgEventId.UnlockFunc, self.__onUnlockFunc)
  end
  self.__allTriggerGuideComplete = isAllCompelete
end

GuideManager.__InitTriggerEvent = function(self)
  -- function num : 0_3 , upvalues : _ENV, GuideEnum
  self.__onSectorStageStateChange = function(data)
    -- function num : 0_3_0 , upvalues : _ENV, self, GuideEnum
    for stageId,_ in pairs(data) do
      if (PlayerDataCenter.sectorStage):IsStageComplete(stageId) then
        self:HandleTriggerGuide((GuideEnum.TriggerGuideCondition).SectorStage, stageId)
      end
    end
  end

  self.__onUnlockFunc = function(fid)
    -- function num : 0_3_1 , upvalues : self, GuideEnum
    self:HandleTriggerGuide((GuideEnum.TriggerGuideCondition).FuncUnlock, fid)
  end

end

GuideManager.AddCompleteTriggerGuide = function(self, guideId)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__triggerGuideComplete)[guideId] = true
  local guideCfg = (ConfigData.guide)[guideId]
  local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.__triggerGuideUnfinished)[cfgCondition])[guideId] = nil
end

GuideManager.HandleTriggerGuide = function(self, conditionType, conditionArg)
  -- function num : 0_5 , upvalues : _ENV, GuideConditionChecker
  if self.__allTriggerGuideComplete then
    return 
  end
  local guideTypeGroup = ((ConfigData.guide).trigger_guide_group)[conditionType]
  if guideTypeGroup == nil then
    return 
  end
  local guideGroup = guideTypeGroup[conditionArg]
  if guideGroup == nil then
    return 
  end
  local completeDic = self.__triggerGuideComplete
  for _,guideId in pairs(guideGroup) do
    if not completeDic[guideId] then
      local guideCfg = (ConfigData.guide)[guideId]
      if (GuideConditionChecker.CheckTriggerGuideCondition)(guideCfg.guide_condition, guideCfg.guide_arg) then
        local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R14 in 'UnsetPending'

        if not (self.__triggerGuideUnfinished)[cfgCondition] then
          do
            (self.__triggerGuideUnfinished)[cfgCondition] = {}
            -- DECOMPILER ERROR at PC43: Confused about usage of register: R14 in 'UnsetPending'

            ;
            ((self.__triggerGuideUnfinished)[cfgCondition])[guideId] = guideCfg
            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

GuideManager.TryTriggerGuide = function(self, condition_Type, taskList, lastGuideId)
  -- function num : 0_6 , upvalues : skipGuide, _ENV, GuideEnum, GuideConditionChecker, GuideManager
  if skipGuide or self.inGuide then
    return false
  end
  if not taskList then
    local taskList = (PlayerDataCenter.allTaskData).guideTaskDatas
  end
  local guideList = {}
  local guideDic = {}
  local guideTaskDic = {}
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  for _,taskData in pairs(taskList) do
    if lastGuideId == nil or not (table.contain)((taskData.stcData).guide_id, lastGuideId) or saveUserData:ContainSkipGuideTask(taskData.id) then
      for _,guideId in pairs((taskData.stcData).guide_id) do
        if not guideDic[guideId] then
          local guideCfg = (ConfigData.guide)[guideId]
          if guideCfg == nil then
            error("guide cfg is null,id:" .. tostring(guideCfg.id))
            return false
          end
          -- DECOMPILER ERROR at PC77: Unhandled construct in 'MakeBoolean' P1

          if guideCfg.guide_type == (GuideEnum.GuideType).TipsGuide and (condition_Type == nil or condition_Type > 100) then
            for _,tipsGuideId in pairs(guideCfg.step_list) do
              self:StartNewTipsGuide(tipsGuideId, condition_Type)
            end
          end
        end
        do
          do
            local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
            if (condition_Type == nil or cfgCondition == condition_Type) and (GuideConditionChecker.CheckGuideCondition)(cfgCondition, cfgConditionArg) then
              guideDic[guideId] = guideCfg.priority
              guideTaskDic[guideId] = taskData.id
              ;
              (table.insert)(guideList, guideId)
            end
            -- DECOMPILER ERROR at PC106: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
      -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  if #guideList == 0 then
    return self:TryStartTriggerTypeGuide(condition_Type, lastGuideId)
  end
  ;
  (table.sort)(guideList, function(x1, x2)
    -- function num : 0_6_0 , upvalues : guideDic
    do return guideDic[x2] < guideDic[x1] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local guideId = guideList[1]
  GuideManager:StartNewGuide(guideId, nil, guideTaskDic[guideId])
  return true
end

GuideManager.TryStartTriggerTypeGuide = function(self, condition_Type)
  -- function num : 0_7 , upvalues : _ENV, GuideConditionChecker
  if self.__allTriggerGuideComplete then
    return 
  end
  if condition_Type == nil then
    return false
  end
  local triggerGuideDic = (self.__triggerGuideUnfinished)[condition_Type]
  if triggerGuideDic == nil or (table.count)(triggerGuideDic) <= 0 then
    return false
  end
  local guideList = {}
  local guideDic = {}
  for guideId,guideCfg in pairs(triggerGuideDic) do
    if (GuideConditionChecker.CheckTriggerGuideCondition)(guideCfg.extra_condition, guideCfg.extra_arg) then
      local cfgCondition, cfgConditionArg = guideCfg:GetFirstCondition()
      if (GuideConditionChecker.CheckGuideCondition)(cfgCondition, cfgConditionArg) then
        guideDic[guideId] = guideCfg.priority
        ;
        (table.insert)(guideList, guideId)
      end
    end
  end
  if #guideList == 0 then
    return false
  end
  ;
  (table.sort)(guideList, function(x1, x2)
    -- function num : 0_7_0 , upvalues : guideDic
    do return guideDic[x2] < guideDic[x1] end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local guideId = guideList[1]
  self:StartNewTriggerGuide(guideId)
  return true
end

GuideManager.__CheckTriggerGuideCondition = function(self, condition_type, condition_arg)
  -- function num : 0_8
end

GuideManager.StartNewTriggerGuide = function(self, id, endAction)
  -- function num : 0_9 , upvalues : _ENV
  if self.inGuide then
    return 
  end
  local guideCfg = (ConfigData.guide)[id]
  self:__SetInGuide(true)
  self.endAction = endAction
  self.guideid = id
  self.guideCfg = guideCfg
  self.__curGuideCtrl = self.__triggerGuideCtrl
  ;
  (self.__curGuideCtrl):StartGuide(self.guideCfg)
end

GuideManager.StartNewTipsGuide = function(self, id, condition_Type)
  -- function num : 0_10 , upvalues : _ENV, GuideConditionChecker, GuideType_Tips
  local tipsGuideCfg = (ConfigData.tips_guide)[id]
  if tipsGuideCfg == nil then
    error("tips_guide Cfg is null,id:" .. tostring(id))
    return 
  end
  if condition_Type ~= nil and condition_Type ~= tipsGuideCfg.condition then
    return 
  end
  if not (GuideConditionChecker.CheckGuideCondition)(tipsGuideCfg.condition, tipsGuideCfg.condition_arg) then
    return 
  end
  local tipsGuideCtrl = (GuideType_Tips.New)()
  tipsGuideCtrl:StartGuide(tipsGuideCfg)
end

GuideManager.StartNewGuide = function(self, id, endAction, taskId)
  -- function num : 0_11 , upvalues : _ENV
  if self.inGuide then
    return 
  end
  local guideCfg = (ConfigData.guide)[id]
  if guideCfg == nil then
    error("guide Cfg is null,id:" .. tostring(id))
    return 
  end
  self:__SetInGuide(true)
  self.endAction = endAction
  self.guideid = id
  self.guideCfg = guideCfg
  self.__curGuideCtrl = self.__normalGuideCtrl
  ;
  (self.__curGuideCtrl):StartGuide(self.guideCfg, taskId)
end

GuideManager.SetEndAction = function(self, endAction)
  -- function num : 0_12
  if not self.inGuide then
    return 
  end
  self.endAction = endAction
end

GuideManager.SkipGuide = function(self)
  -- function num : 0_13
  if not self.inGuide then
    return 
  end
  ;
  (self.__curGuideCtrl):EndGuide(false)
end

GuideManager.BreakSkipGuide = function(self)
  -- function num : 0_14
  if not self.inGuide then
    return 
  end
  ;
  (self.__curGuideCtrl):BreakEndGuide()
end

GuideManager.OnEndGuide = function(self, success)
  -- function num : 0_15 , upvalues : _ENV
  local lastGuideId = self.guideid
  self.__curGuideCtrl = nil
  GuideUtil:ClearData()
  self:__SetInGuide(false)
  if self.endAction ~= nil then
    (self.endAction)(success)
    self.endAction = nil
  end
  if success then
    self:TryTriggerGuide(nil, nil, lastGuideId)
  end
end

GuideManager.GetCurGuideCtrl = function(self)
  -- function num : 0_16
  return self.__curGuideCtrl
end

GuideManager.OnGuideTaskDelete = function(self, taskList)
  -- function num : 0_17 , upvalues : GuideManager, _ENV, GuideEnum, GuideType_Tips
  local isInGuideFirstStep = not GuideManager.inGuide or (GuideManager:GetCurGuideCtrl()).guideIndex == 1
  for _,taskData in pairs(taskList) do
    for _,guideId in pairs((taskData.stcData).guide_id) do
      if isInGuideFirstStep and guideId == GuideManager.guideid then
        GuideManager:SkipGuide()
        break
      end
      local guideCfg = (ConfigData.guide)[guideId]
      if guideCfg == nil then
        error("guide cfg is null,id:" .. tostring(guideCfg.id))
        return 
      end
      if guideCfg.guide_type == (GuideEnum.GuideType).TipsGuide then
        for _,tipsGuideId in pairs(guideCfg.step_list) do
          (GuideType_Tips.TryClearTipsGuide)(tipsGuideId)
        end
      end
    end
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

GuideManager.AddGuideFeature = function(self, feature)
  -- function num : 0_18
  if self.__curGuideCtrl ~= nil then
    (self.__curGuideCtrl):AddGuideFeature(feature)
  end
end

GuideManager.RemoveGuideFeature = function(self, feature)
  -- function num : 0_19
  if self.__curGuideCtrl ~= nil then
    (self.__curGuideCtrl):RemoveGuideFeature(feature)
  end
end

GuideManager.HasGuideFeature = function(self, feature)
  -- function num : 0_20
  if self.__curGuideCtrl ~= nil then
    return (self.__curGuideCtrl):HasGuideFeature(feature)
  end
  return false
end

GuideManager.UncompleteCollectResGuide = function(self, uncomplete)
  -- function num : 0_21
  self.collectResGuideUnComplete = uncomplete
end

GuideManager.OnQuitAndClear = function(self)
  -- function num : 0_22 , upvalues : _ENV
  (self.firstBattleGuideCtrl):ResetData()
  self:BreakSkipGuide()
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
  MsgCenter:RemoveListener(eMsgEventId.UnlockFunc, self.__onUnlockFunc)
end

GuideManager:Init()
return GuideManager

