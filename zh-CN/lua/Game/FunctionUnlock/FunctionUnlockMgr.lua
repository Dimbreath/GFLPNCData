FunctionUnlockMgr = {}
local UnlockFunc = require("Game.FunctionUnlock.UnlockFunc")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local NoticeData = require("Game.Notice.NoticeData")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
-- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'

FunctionUnlockMgr.ResetUnlockData = function(self)
  -- function num : 0_0
  self.unlockTalbe = {}
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

FunctionUnlockMgr.__InitFuncListener = function(self)
  -- function num : 0_1
  self.unlockListener = {}
  self:InitListener()
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

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
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1] = UnlockFunc.onUnlockSectorBuilding
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi] = UnlockFunc.onUnlockTaskUI
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask] = UnlockFunc.onUnlockDailyAndWeeklyTaskUI
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
  -- DECOMPILER ERROR at PC129: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn] = UnlockFunc.onUnlockSignIn
  -- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan] = UnlockFunc.onUnlockHeroTask
  -- DECOMPILER ERROR at PC139: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_HeroInformation] = UnlockFunc.onUnlockHeroInfo
  -- DECOMPILER ERROR at PC144: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_GiftCode] = UnlockFunc.onUnlockCDK
  -- DECOMPILER ERROR at PC149: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_SectorTask] = UnlockFunc.onUnlockSectorTask
  -- DECOMPILER ERROR at PC154: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_QuickJump] = UnlockFunc.onUnlockNavigation
  -- DECOMPILER ERROR at PC159: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation] = UnlockFunc.onUnlockCommanderInformation
  -- DECOMPILER ERROR at PC164: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Skin] = UnlockFunc.onUnlockSkin
  -- DECOMPILER ERROR at PC169: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Backpack_ui] = UnlockFunc.onUnlockWarehouse
  -- DECOMPILER ERROR at PC174: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_ChangeUserInfo] = UnlockFunc.onUnlockChangeUserInfo
  -- DECOMPILER ERROR at PC179: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Chat] = UnlockFunc.onUnlockWorldChat
  -- DECOMPILER ERROR at PC184: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_Friend] = UnlockFunc.onUnlockFriend
  -- DECOMPILER ERROR at PC189: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon] = UnlockFunc.OnUnlockDailyDungeon
  -- DECOMPILER ERROR at PC194: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.unlockListener)[proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge] = UnlockFunc.OnUnlockWeeklyChallenge
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

FunctionUnlockMgr.AddUnlockFunction = function(self, fid, isFirst)
  -- function num : 0_3 , upvalues : _ENV, NoticeData, CheckerTypeId
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.unlockTalbe)[fid] = true
  if isFirst then
    return 
  end
  if (self.unlockListener)[fid] ~= nil then
    ((self.unlockListener)[fid])(self)
  end
  MsgCenter:Broadcast(eMsgEventId.UnlockFunc, fid)
  if (ConfigData.system_open)[fid] == nil then
    error("not exist functionOpenCfg with functionId:" .. tostring(fid))
  else
    if ((ConfigData.system_open)[fid]).is_push then
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).FunctionUnlock, nil, {(LanguageUtil.GetLocaleText)(((ConfigData.system_open)[fid]).name)}, nil))
    end
  end
  MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.FunctionUnlock)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

FunctionUnlockMgr.RemoveUnlockFunction = function(self, fid)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.unlockTalbe)[fid] = nil
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC38: Confused about usage of register: R6 in 'UnsetPending'

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
                local sectorShowId = ConfigData:GetSectorIdShow(stageCfg.sector)
                local newDesc = (string.format)(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(sectorShowId), tostring(sectorShowId), tostring(stageCfg.num), diffstr)
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
                    else
                      do
                        do
                          local lockReason = (CheckCondition.GetUnlockInfoLua)({pre_condition}, {pre_para1}, {pre_para1})
                          descStr = __AddDecription(descStr, lockReason, lineWrap)
                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC246: LeaveBlock: unexpected jumping out IF_STMT

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
    end
  end
  return descStr
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

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

-- DECOMPILER ERROR at PC44: Confused about usage of register: R6 in 'UnsetPending'

FunctionUnlockMgr.BenchUnlock = function(benchId, GetUnlockDescription)
  -- function num : 0_9 , upvalues : _ENV
  local sysFuncId = proto_csmsg_SystemFunctionID["SystemFunctionID_bench" .. tostring(benchId)]
  local unlock = (FunctionUnlockMgr:ValidateUnlock(sysFuncId))
  -- DECOMPILER ERROR at PC11: Overwrote pending register: R4 in 'AssignReg'

  local lockStr, stageCfg = .end, nil
  if not unlock and GetUnlockDescription then
    stageCfg = FunctionUnlockMgr:GetFuncUnlockStageCfg(sysFuncId)
  end
  if stageCfg ~= nil then
    local sectorShowId = ConfigData:GetSectorIdShow(stageCfg.sector)
    lockStr = (string.format)(ConfigData:GetTipContent(161), tostring(sectorShowId), tostring(stageCfg.num))
  else
    do
      lockStr = ""
      return unlock, lockStr
    end
  end
end

FunctionUnlockMgr:__InitFuncListener()

