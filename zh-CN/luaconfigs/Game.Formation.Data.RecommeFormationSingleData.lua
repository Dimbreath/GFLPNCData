-- params : ...
-- function num : 0 , upvalues : _ENV
local RecommeFormationSingleData = class("RecommeFormationSingleData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local ChipData = require("Game.PlayerData.Item.ChipData")
local CommanderSkillTreeData = require("Game.CommanderSkill.CommanderSkillTreeData")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
RecommeFormationSingleData.ctor = function(self)
  -- function num : 0_0
  self.recommanHeroDic = {}
  self.chipList = {}
  self.slotSkillList = {}
end

RecommeFormationSingleData.CreateData = function(data)
  -- function num : 0_1 , upvalues : RecommeFormationSingleData, _ENV, CommanderSkillData, CommanderSkillTreeData, ChipData
  local res = RecommeFormationSingleData:New()
  res.playerId = data.uid
  res.playerName = data.name
  res.playerLevel = data.level
  res.mvpHeroId = data.mvp
  if (data.cst).treeId > 0 then
    res.treeCfg = (ConfigData.commander_skill)[(data.cst).treeId]
    res.treeLevel = (data.cst).treeLevel
    if (data.cst).saving ~= nil then
      res.slotSkillList = (data.cst).saving
    else
      if (data.cst).skillGroup ~= nil and (table.count)((data.cst).skillGroup) > 0 then
        res.slotSkillList = {}
        local placeMax = 0
        for skillId,_ in pairs((data.cst).skillGroup) do
          local skillCfg = res:GetSkillById(skillId, (data.cst).treeId)
          -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

          if skillCfg.skill_type == (CommanderSkillData.skillType).active then
            (res.slotSkillList)[skillCfg.place] = skillId
            if skillCfg.place >= placeMax or not placeMax then
              placeMax = skillCfg.place
            end
          end
        end
        for i = 1, placeMax do
          -- DECOMPILER ERROR at PC81: Confused about usage of register: R7 in 'UnsetPending'

          if (res.slotSkillList)[i] == nil then
            (res.slotSkillList)[i] = 0
          end
        end
      else
        do
          do
            local commandSkill = (CommanderSkillTreeData.New)(1, 1, 0)
            res.treeCfg = commandSkill.treeCfg
            res.treeLevel = commandSkill.level
            res.slotSkillList = commandSkill.slotSkillList
            do
              local commandSkill = (CommanderSkillTreeData.New)(1, 1, 0)
              res.treeCfg = commandSkill.treeCfg
              res.treeLevel = commandSkill.level
              res.slotSkillList = commandSkill.slotSkillList
              res:CalculateHeroData(data.hero)
              res.chipList = {}
              for key,value in pairs(data.alg) do
                local chipData = (ChipData.New)(key, value)
                ;
                (table.insert)(res.chipList, chipData)
              end
              return res
            end
          end
        end
      end
    end
  end
end

RecommeFormationSingleData.GetSkillById = function(self, skillId, treeId)
  -- function num : 0_2 , upvalues : _ENV
  local unlockSkillCfg = (ConfigData.commander_skill_unlock)[treeId]
  for k,v in pairs(unlockSkillCfg) do
    if k == skillId then
      return v
    end
  end
end

RecommeFormationSingleData.CalculateHeroData = function(self, heroMsg)
  -- function num : 0_3 , upvalues : _ENV, HeroData
  self.recommanHeroDic = {}
  self.firstPower = 0
  self.benchPower = 0
  self.heroCount = 0
  self.starMax = 0
  self.levelMax = 0
  self.idAddtion = 0
  LocalFunc_CalculateIndex = function(self, index, heroList)
    -- function num : 0_3_0 , upvalues : HeroData
    for i = 1, #heroList do
      index = index + 1
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.recommanHeroDic)[index] = {basic = (HeroData.New)(heroList[i]), power = (heroList[i]).power, position = (heroList[i]).position}
    end
    return index
  end

  local xMax = 0
  local yMax = 0
  local posHeroDic = {}
  local benchDic = {}
  for k,v in pairs(heroMsg) do
    local x, y = (BattleUtil.Pos2XYCoord)(v.position or 0)
    if (yMax < y and y) or x == (ConfigData.buildinConfig).BenchX then
      local yArry = benchDic[y]
      if yArry == nil then
        yArry = {}
        benchDic[y] = yArry
      end
      ;
      (table.insert)(yArry, v)
    else
      do
        if xMax >= x or not x then
          local xDic = posHeroDic[x]
          if xDic == nil then
            xDic = {}
            posHeroDic[x] = xDic
          end
          do
            local yArry = xDic[y]
            if yArry == nil then
              yArry = {}
              xDic[y] = yArry
            end
            ;
            (table.insert)(yArry, v)
            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  local curIndex = 0
  for x = 0, xMax do
    if posHeroDic[x] ~= nil then
      for y = 0, yMax do
        local heroList = (posHeroDic[x])[y]
        if heroList ~= nil and #heroList > 0 then
          curIndex = LocalFunc_CalculateIndex(self, curIndex, heroList)
        end
      end
    end
  end
  if (table.count)(benchDic) > 0 then
    local benchCount = 0
    for i = 0, yMax do
      if benchDic[i] ~= nil then
        benchCount = benchCount + (table.count)(benchDic[i])
      end
    end
    if benchCount < (ConfigData.game_config).max_bench_hero then
      curIndex = (ConfigData.game_config).max_stage_hero
    else
      curIndex = (ConfigData.game_config).max_stage_hero + (ConfigData.game_config).max_bench_hero - (benchCount)
    end
    for i = 0, yMax do
      if benchDic[i] ~= nil then
        curIndex = LocalFunc_CalculateIndex(self, curIndex, benchDic[i])
      end
    end
  end
  do
    for key,value in pairs(self.recommanHeroDic) do
      if key <= (ConfigData.game_config).max_stage_hero then
        self.firstPower = self.firstPower + value.power
      else
        self.benchPower = self.benchPower + value.power
      end
      self.heroCount = self.heroCount + 1
      if (value.basic).star >= self.starMax or not self.starMax then
        self.starMax = (value.basic).star
        if (value.basic).level >= self.levelMax or not self.levelMax then
          do
            self.levelMax = (value.basic).level
            self.idAddtion = self.idAddtion + (value.basic).dataId
            -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    self.firstPower = self.firstPower + (ConfigData.GetFormulaValue)(eFormulaType.Commander, {power = self.firstPower})
    self.firstPower = (math.floor)(self.firstPower)
    self.power = self.firstPower + self.benchPower
  end
end

RecommeFormationSingleData.IsAllowCopy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local indexMax = ConfigData:GetFormationHeroCount()
  for index,data in pairs(self.recommanHeroDic) do
    if index <= indexMax and (PlayerDataCenter.heroDic)[(data.basic).dataId] ~= nil then
      return true
    end
  end
  return false
end

RecommeFormationSingleData.GetHaveCount = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local indexMax = ConfigData:GetFormationHeroCount()
  local count = 0
  for index,data in pairs(self.recommanHeroDic) do
    if index <= indexMax and (PlayerDataCenter.heroDic)[(data.basic).dataId] ~= nil then
      count = count + 1
    end
  end
  return count
end

RecommeFormationSingleData.CopyFormation = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local indexMax = ConfigData:GetFormationHeroCount()
  local res = {}
  for index,data in pairs(self.recommanHeroDic) do
    if index <= indexMax and (PlayerDataCenter.heroDic)[(data.basic).dataId] ~= nil then
      res[index] = (data.basic).dataId
    end
  end
  return res
end

return RecommeFormationSingleData

