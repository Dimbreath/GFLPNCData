local BattleResultAftertTeatmentCtrl = class("BattleResultAftertTeatmentCtrl", ControllerBase)
local base = ControllerBase
BattleResultAftertTeatmentCtrl.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__TryShowExtraReward = BindCallback(self, self._TryShowExtraReward)
  self.__TryShowDungeonAutoFightReward = BindCallback(self, self._TryShowDungeonAutoFightReward)
  self.processTable = {self.__TryShowDungeonAutoFightReward, self.__TryShowExtraReward}
end

BattleResultAftertTeatmentCtrl.AddShowReward = function(self, rewardDic)
  -- function num : 0_1 , upvalues : _ENV
  if rewardDic == nil or (table.count)(rewardDic) == 0 then
    return 
  end
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1) then
    return 
  end
  if not self.extraShowRwardDic then
    self.extraShowRwardDic = {}
    for id,count in pairs(rewardDic) do
      local oriCount = (self.extraShowRwardDic)[id] or 0
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.extraShowRwardDic)[id] = oriCount + count
    end
  end
end

BattleResultAftertTeatmentCtrl.AddDungeonAutoFightReward = function(self, rewardDic, athRewardDic, dungeonCfg, battleCount)
  -- function num : 0_2 , upvalues : _ENV
  if not self.dungeonAutoFightTable then
    self.dungeonAutoFightTable = {dungeonCfg = dungeonCfg, count = battleCount, 
reward = {}
, 
ath = {}
}
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self.dungeonAutoFightTable).count = battleCount
    if rewardDic ~= nil and (table.count)(rewardDic) > 0 then
      for id,count in pairs(rewardDic) do
        local oriCount = ((self.dungeonAutoFightTable).reward)[id] or 0
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R11 in 'UnsetPending'

        ;
        ((self.dungeonAutoFightTable).reward)[id] = oriCount + count
      end
    end
    do
      if athRewardDic ~= nil and (table.count)(athRewardDic) then
        for _,uid in pairs(athRewardDic) do
          -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

          ((self.dungeonAutoFightTable).ath)[uid] = uid
        end
      end
    end
  end
end

BattleResultAftertTeatmentCtrl.TeatmentBengin = function(self)
  -- function num : 0_3
  self:_NextContinue(true)
end

BattleResultAftertTeatmentCtrl._TryShowExtraReward = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.extraShowRwardDic == nil or (table.count)(self.extraShowRwardDic) == 0 then
    self:_NextContinue()
    return 
  end
  local ShowWinFunc = function(window)
    -- function num : 0_4_0 , upvalues : _ENV, self
    local rewardIds = {}
    local rewardNums = {}
    for id,num in pairs(self.extraShowRwardDic) do
      (table.insert)(rewardIds, id)
      ;
      (table.insert)(rewardNums, num)
    end
    window:InitRewardsItem(rewardIds, rewardNums)
    window:BindCommonRewardExit(function()
      -- function num : 0_4_0_0 , upvalues : self
      self:_NextContinue()
    end
)
  end

  local rewardWin = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if rewardWin ~= nil then
    ShowWinFunc(rewardWin)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_4_1 , upvalues : ShowWinFunc
    if window == nil then
      return 
    end
    ShowWinFunc(window)
  end
)
  end
end

BattleResultAftertTeatmentCtrl._TryShowDungeonAutoFightReward = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.dungeonAutoFightTable == nil then
    self:_NextContinue()
    return 
  end
  UIManager:CreateWindowAsync(UIWindowTypeID.BattleAutoMode, function(window)
    -- function num : 0_5_0 , upvalues : self
    window:InitDungeonAutoRes((self.dungeonAutoFightTable).dungeonCfg, (self.dungeonAutoFightTable).count, (self.dungeonAutoFightTable).reward, (self.dungeonAutoFightTable).ath, function()
      -- function num : 0_5_0_0 , upvalues : self
      self:_NextContinue()
    end
)
  end
)
end

BattleResultAftertTeatmentCtrl._NextContinue = function(self, isFirst)
  -- function num : 0_6
  if isFirst then
    self.processIndex = 0
  end
  self.processIndex = self.processIndex + 1
  if #self.processTable < self.processIndex then
    self:Delete()
    return 
  end
  ;
  ((self.processTable)[self.processIndex])()
end

BattleResultAftertTeatmentCtrl.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return BattleResultAftertTeatmentCtrl

