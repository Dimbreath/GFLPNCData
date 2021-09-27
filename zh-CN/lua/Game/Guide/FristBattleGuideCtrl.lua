local FristBattleGuideCtrl = {}
local TaskEnum = require("Game.Task.TaskEnum")
local FormationData = require("Game.PlayerData.FormationData")
local FirstBattleConfig = require("Game.Guide.FirstBattleConfig")
FristBattleGuideCtrl.__Init = function(self)
  -- function num : 0_0
  self.guideDungeonId = nil
  self.battleGuideType = nil
  self.lastbattleGuide = false
end

FristBattleGuideCtrl.ResetData = function(self)
  -- function num : 0_1
  self:__Init()
end

FristBattleGuideCtrl.TryStartFirstBattleGuide = function(self, taskList)
  -- function num : 0_2 , upvalues : _ENV, TaskEnum, FirstBattleConfig, FormationData
  if not taskList then
    taskList = (PlayerDataCenter.allTaskData).specialTaskDatas
  end
  for k,taskData in pairs(taskList) do
    if (taskData.stcData).special_type == (TaskEnum.eSpecialType).FirstBattleGuide1 then
      self.battleGuideType = (taskData.stcData).special_type
      self.guideDungeonId = ((taskData.stcData).special_param)[1]
      local firstBattle1Config = FirstBattleConfig.firstBattle1
      local formation = (FormationData.FromCustomData)(1, firstBattle1Config.formHeroList, firstBattle1Config.csTreeId, firstBattle1Config.formCSList)
      ;
      (NetworkManager:GetNetwork(NetworkTypeID.Hero)):SendFormationFresh(1, formation.data)
      BattleDungeonManager:SaveFormation(formation)
      BattleDungeonManager:RequestEnterDungeon(self.guideDungeonId, formation)
      ;
      (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.black, false)
      self.lastbattleGuide = true
      return true
    else
      do
        if (taskData.stcData).special_type == (TaskEnum.eSpecialType).FirstBattleGuide2 then
          self.battleGuideType = (taskData.stcData).special_type
          self.guideDungeonId = ((taskData.stcData).special_param)[1]
          local firstBattle2Config = FirstBattleConfig.firstBattle2
          local formHeroList = {}
          for k,v in pairs(firstBattle2Config.formHeroList) do
            formHeroList[k] = v
          end
          local formation = (FormationData.FromCustomData)(1, formHeroList, firstBattle2Config.csTreeId, firstBattle2Config.formCSList)
          ;
          (NetworkManager:GetNetwork(NetworkTypeID.Hero)):SendFormationFresh(1, formation.data)
          BattleDungeonManager:SaveFormation(formation)
          BattleDungeonManager:RequestEnterDungeon(self.guideDungeonId, formation)
          ;
          (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.black, false)
          self.lastbattleGuide = true
          return true
        else
          do
            if (taskData.stcData).special_type == (TaskEnum.eSpecialType).QuckEnterExploration then
              self.guideExplorationId = ((taskData.stcData).special_param)[1]
              local has, dungeonId, moduleId = ExplorationManager:HasUncompletedEp()
              if has then
                ExplorationManager:ContinueLastExploration()
              else
                ExplorationManager:ReqEnterExploration(self.guideExplorationId, 1, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, false, callBack)
              end
              self.lastbattleGuide = true
              return true
            end
            do
              -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC154: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  return false
end

FristBattleGuideCtrl.GetFirstBattleConfig = function(self)
  -- function num : 0_3 , upvalues : TaskEnum, FirstBattleConfig
  if self.battleGuideType == (TaskEnum.eSpecialType).FirstBattleGuide1 then
    return FirstBattleConfig.firstBattle1
  else
    if self.battleGuideType == (TaskEnum.eSpecialType).FirstBattleGuide2 then
      return FirstBattleConfig.firstBattle2
    end
  end
  return nil
end

return FristBattleGuideCtrl

