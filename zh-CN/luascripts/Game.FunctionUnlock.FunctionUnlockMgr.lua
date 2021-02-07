-- params : ...
-- function num : 0 , upvalues : _ENV
FunctionUnlockMgr = {}
local UnlockFunc = require("Game.FunctionUnlock.UnlockFunc")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
-- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

FunctionUnlockMgr.ResetUnlockData = function(self)
  -- function num : 0_0
  self.unlockTalbe = {}
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

FunctionUnlockMgr.__InitFuncListener = function(self)
  -- function num : 0_1
  self.unlockListener = {}
  self:InitListener()
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

FunctionUnlockMgr.InitListener = function(self)
  -- function num : 0_2 , upvalues : _ENV, UnlockFunc
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Store] = UnlockFunc.onUnlockShop
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Factory] = UnlockFunc.onUnlockFactory
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Building] = UnlockFunc.onUnlockOasis
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration] = UnlockFunc.onUnlockSector
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup] = UnlockFunc.onUnlockHeroList
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery] = UnlockFunc.onUnlockLottery
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Training] = UnlockFunc.onUnlockTraining
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Social] = UnlockFunc.onUnlockSocial
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter] = UnlockFunc.onUnlockHeroEnter
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_EnemyDetail] = UnlockFunc.onUnlockEnemyDetail
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm] = UnlockFunc.onUnlockDorm
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Random] = UnlockFunc.onUnlockRandom
  -- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill] = UnlockFunc.onUnlockCommanderSkill
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui] = UnlockFunc.onUnlockCommanderSkillUI
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank] = UnlockFunc.onUnlockStarUp
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding] = UnlockFunc.onUnlockSectorBuilding
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi] = UnlockFunc.onUnlockTaskUI
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask] = UnlockFunc.onUnlockDailyAndWeeklyTaskUI
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeName] = UnlockFunc.onUnlockChangeName
  -- DECOMPILER ERROR at PC99: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Endless] = UnlockFunc.onUnlockEndlss
  -- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Hard] = UnlockFunc.onUnlockEndlss
  -- DECOMPILER ERROR at PC109: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement] = UnlockFunc.onUnlockAchievement
  -- DECOMPILER ERROR at PC114: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_friendship] = UnlockFunc.onUnlockFriendShip
  -- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge] = UnlockFunc.onUnlockPeriodicChanllenge
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Mail] = UnlockFunc.onUnlockMial
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

FunctionUnlockMgr.AddUnlockFunction = function(self, fid, isFirst)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.unlockTalbe)[fid] = true
  if isFirst then
    return 
  end
  if (self.unlockListener)[fid] ~= nil then
    ((self.unlockListener)[fid])(self)
  end
  MsgCenter:Broadcast(eMsgEventId.UnlockFunc, fid)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

FunctionUnlockMgr.RemoveUnlockFunction = function(self, fid)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.unlockTalbe)[fid] = nil
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

FunctionUnlockMgr.ValidateUnlock = function(self, fid)
  -- function num : 0_5
  local isUnlock = false
  if (self.unlockTalbe)[fid] then
    isUnlock = true
  end
  return isUnlock
end

local __AddDecription = function(oldDesc, newDesc, lineWrap)
  -- function num : 0_6 , upvalues : _ENV
  if (string.IsNullOrEmpty)(oldDesc) then
    return newDesc
  end
  if lineWrap then
    oldDesc = oldDesc .. ",\n" .. newDesc
  else
    oldDesc = oldDesc .. "," .. newDesc
  end
  return oldDesc
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

FunctionUnlockMgr.GetFuncUnlockDecription = function(self, fid, lineWrap)
  -- function num : 0_7 , upvalues : _ENV, __AddDecription, ExplorationEnum
  local sysOpenCfg = (ConfigData.system_open)[fid]
  if sysOpenCfg == nil then
    error("Can\'t find system_open cfg, id = " .. tostring(fid))
    return 
  end
  local descStr = nil
  for k,pre_condition in ipairs(sysOpenCfg.pre_condition) do
    local pre_para1 = (sysOpenCfg.pre_para1)[k]
    local pre_para2 = nil
    if sysOpenCfg.pre_para2 ~= nil then
      pre_para2 = (sysOpenCfg.pre_para2)[k]
    end
    if pre_condition == 1 then
      local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Level), tostring(pre_para1))
      descStr = __AddDecription(descStr, newDesc, lineWrap)
    else
      do
        if pre_condition == 2 then
          local taskCfg = (ConfigData.task)[pre_para1]
          if taskCfg == nil then
            error("Cant\'t find taskCfg,id = " .. tostring(pre_para1))
          else
            local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Task), (LanguageUtil.GetLocaleText)(taskCfg.name))
            descStr = __AddDecription(descStr, newDesc, lineWrap)
          end
        else
          do
            if pre_condition == 3 then
              local stageCfg = (ConfigData.sector_stage)[pre_para1]
              if stageCfg == nil then
                error("Cant\'t find sector_stage cfg,id = " .. tostring(pre_para1))
              else
                local diffstr = nil
                local difficult = stageCfg.difficulty
                if difficult == (ExplorationEnum.eDifficultType).Normal then
                  diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_1)
                else
                  if difficult == (ExplorationEnum.eDifficultType).Hard then
                    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_2)
                  else
                    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_3)
                  end
                end
                local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(stageCfg.sector), tostring(stageCfg.sector), tostring(stageCfg.num), diffstr)
                descStr = __AddDecription(descStr, newDesc, lineWrap)
              end
            else
              do
                if pre_condition == 4 then
                  local buildingCfg = (ConfigData.building)[pre_para1]
                  if buildingCfg == nil then
                    error("Cant\'t find buildingCfg,id = " .. tostring(pre_para1))
                  else
                    local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Building), (LanguageUtil.GetLocaleText)(buildingCfg.name), tostring(pre_para2))
                    descStr = __AddDecription(descStr, newDesc, lineWrap)
                  end
                else
                  do
                    if pre_condition == 5 then
                      local heroCfg = (ConfigData.hero_data)[pre_para1]
                      if heroCfg == nil then
                        error("Cant\'t find heroCfg,id = " .. tostring(pre_para1))
                      else
                        local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Friendship), (LanguageUtil.GetLocaleText)(heroCfg.name), tostring(pre_para2))
                        descStr = __AddDecription(descStr, newDesc, lineWrap)
                      end
                    end
                    do
                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC223: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return descStr
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

FunctionUnlockMgr.GetFuncUnlockStageCfg = function(self, fid)
  -- function num : 0_8 , upvalues : _ENV
  local sysOpenCfg = (ConfigData.system_open)[fid]
  if sysOpenCfg == nil then
    error("Can\'t find system_open cfg, id = " .. tostring(fid))
    return 
  end
  local stageCfg = nil
  for k,pre_condition in ipairs(sysOpenCfg.pre_condition) do
    local pre_para1 = (sysOpenCfg.pre_para1)[k]
    if pre_condition == 3 then
      stageCfg = (ConfigData.sector_stage)[pre_para1]
      if stageCfg == nil then
        error("Cant\'t find sector_stage cfg,id = " .. tostring(pre_para1))
      end
    end
  end
  return stageCfg
end

FunctionUnlockMgr:__InitFuncListener()

