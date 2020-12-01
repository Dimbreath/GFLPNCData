-- params : ...
-- function num : 0 , upvalues : _ENV
local UIN3DFormation = class("UIN3DFormation", UIBaseNode)
local base = UIBaseNode
local UINFmtPlatform = require("Game.Formation.UI.3DFormation.UINFmtPlatform")
UIN3DFormation.ctor = function(self, fmtCtrl)
  -- function num : 0_0
  self.fmtCtrl = fmtCtrl
end

UIN3DFormation.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINFmtPlatform
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  self.platformDic = {}
  for fmtIndex,go in ipairs((self.ui).platform) do
    local isBench = (ConfigData.game_config).max_stage_hero < fmtIndex
    local unlock, lockStr = nil, nil
    do
      if isBench then
        local benchId = fmtIndex - (ConfigData.game_config).max_stage_hero
        unlock = (fmtCtrl.BenchUnlock)(benchId, true)
      end
      do
        local plat = (UINFmtPlatform.New)()
        plat:Init(go)
        plat:InitFmtPlatform(fmtIndex, isBench, lockStr)
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.platformDic)[fmtIndex] = plat
        -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIN3DFormation.Init3DFormation = function(self)
  -- function num : 0_2
end

UIN3DFormation.Refresh3DFmt = function(self, formationData)
  -- function num : 0_3 , upvalues : _ENV
  self.formationData = formationData
  local totalFtPower = 0
  local campCountDic = (table.GetDefaulValueTable)(0)
  for index,platItem in pairs(self.platformDic) do
    local heroId = (formationData.data)[index]
    local heroData = nil
    if heroId ~= nil then
      heroData = PlayerDataCenter:GetHeroData(heroId)
      if heroData ~= nil then
        local campId = heroData.camp
        campCountDic[campId] = campCountDic[campId] + 1
      end
    end
    do
      do
        totalFtPower = platItem:RefreshUIFmtPlatform(heroData) + totalFtPower
        -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  local dynPlayerFtPower = ((((((CS.BattleConsts).BattleDynPlayerFightPowerFormula).battleFormula):BindOption(((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):BindArgData(((CS.FormulaOperand).OperandValue)(totalFtPower))):GetValue(self, self)):AsLong()
  totalFtPower = totalFtPower + dynPlayerFtPower
  local window = UIManager:GetWindow(UIWindowTypeID.Formation)
  if window ~= nil then
    window:RefreshFmtInfoUI(totalFtPower, campCountDic)
  end
end

UIN3DFormation.GetFmtPlatformUI = function(self, fmtIndex)
  -- function num : 0_4 , upvalues : _ENV
  local platform = (self.platformDic)[fmtIndex]
  if platform == nil then
    warn("Can\'t get FmtPlatformUI, fmtIndex = " .. tostring(fmtIndex))
  end
  return platform
end

UIN3DFormation.RefreshFmtPlatformUI = function(self, fmtIndex)
  -- function num : 0_5 , upvalues : _ENV
  local platform = self:GetFmtPlatformUI(fmtIndex)
  if platform == nil then
    return 
  end
  local heroId = ((self.formationData).data)[fmtIndex]
  local heroData = nil
  if heroId ~= nil then
    heroData = PlayerDataCenter:GetHeroData(heroId)
  end
  platform:RefreshUIFmtPlatform(heroData)
end

UIN3DFormation.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UIN3DFormation

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIN3DFormation = class("UIN3DFormation", UIBaseNode)
local base = UIBaseNode
local UINFmtPlatform = require("Game.Formation.UI.3DFormation.UINFmtPlatform")
UIN3DFormation.ctor = function(self, fmtCtrl)
    -- function num : 0_0
    self.fmtCtrl = fmtCtrl
end

UIN3DFormation.OnInit = function(self)
    -- function num : 0_1 , upvalues : _ENV, UINFmtPlatform
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
    self.platformDic = {}
    for fmtIndex, go in ipairs((self.ui).platform) do
        local isBench = (ConfigData.game_config).max_stage_hero < fmtIndex
        local unlock, lockStr = nil, nil
        do
            if isBench then
                local benchId = fmtIndex -
                                    (ConfigData.game_config).max_stage_hero
                unlock = (fmtCtrl.BenchUnlock)(benchId, true)
            end
            do
                local plat = (UINFmtPlatform.New)()
                plat:Init(go)
                plat:InitFmtPlatform(fmtIndex, isBench, lockStr) -- DECOMPILER ERROR at PC48: Confused about usage of register: R11 in 'UnsetPending'
                ;
                (self.platformDic)[fmtIndex] = plat
                -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIN3DFormation.Init3DFormation = function(self)
    -- function num : 0_2
end

UIN3DFormation.Refresh3DFmt = function(self, formationData)
    -- function num : 0_3 , upvalues : _ENV
    self.formationData = formationData
    local totalFtPower = 0
    local campCountDic = (table.GetDefaulValueTable)(0)
    for index, platItem in pairs(self.platformDic) do
        local heroId = (formationData.data)[index]
        local heroData = nil
        if heroId ~= nil then
            heroData = PlayerDataCenter:GetHeroData(heroId)
            if heroData ~= nil then
                local campId = heroData.camp
                campCountDic[campId] = campCountDic[campId] + 1
            end
        end
        do
            do
                totalFtPower = platItem:RefreshUIFmtPlatform(heroData) +
                                   totalFtPower
                -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    local dynPlayerFtPower =
        ((((((CS.BattleConsts).BattleDynPlayerFightPowerFormula).battleFormula):BindOption(
            ((CS.BattleFormula).eFormationOption).ReplaceHpWithMaxHp)):BindArgData(
            ((CS.FormulaOperand).OperandValue)(totalFtPower))):GetValue(self,
                                                                        self)):AsLong()
    totalFtPower = totalFtPower + dynPlayerFtPower
    local window = UIManager:GetWindow(UIWindowTypeID.Formation)
    if window ~= nil then window:RefreshFmtInfoUI(totalFtPower, campCountDic) end
end

UIN3DFormation.GetFmtPlatformUI = function(self, fmtIndex)
    -- function num : 0_4 , upvalues : _ENV
    local platform = (self.platformDic)[fmtIndex]
    if platform == nil then
        warn("Can\'t get FmtPlatformUI, fmtIndex = " .. tostring(fmtIndex))
    end
    return platform
end

UIN3DFormation.RefreshFmtPlatformUI = function(self, fmtIndex)
    -- function num : 0_5 , upvalues : _ENV
    local platform = self:GetFmtPlatformUI(fmtIndex)
    if platform == nil then return end
    local heroId = ((self.formationData).data)[fmtIndex]
    local heroData = nil
    if heroId ~= nil then heroData = PlayerDataCenter:GetHeroData(heroId) end
    platform:RefreshUIFmtPlatform(heroData)
end

UIN3DFormation.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UIN3DFormation

