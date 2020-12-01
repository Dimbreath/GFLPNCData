-- params : ...
-- function num : 0 , upvalues : _ENV
local ChipBattleData = class("ChipBattleData")
local CS_BattleManager_Ins = (CS.BattleManager).Instance
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ChipBattleData.ctor = function(self, chipCfg, skillLevel, skillType)
  -- function num : 0_0 , upvalues : ExplorationEnum, _ENV, DynBattleSkill
  if not skillLevel then
    skillLevel = 1
  end
  self.level = skillLevel
  self.chipCfg = chipCfg
  if not skillType then
    local battleSkillType = (ExplorationEnum.eBattleSkillType).Chip
  end
  self.attributeIdList = (self.chipCfg).attribute_id
  if #(self.chipCfg).skill_list > 0 then
    self.skillDataList = {}
    for k,skillId in ipairs((self.chipCfg).skill_list) do
      local skillData = (DynBattleSkill.New)(skillId, skillLevel, battleSkillType)
      skillData.itemId = (self.chipCfg).id
      ;
      (table.insert)(self.skillDataList, skillData)
    end
  end
  do
    self.influenceType = (self.chipCfg).influence
    self.influenceArg = (self.chipCfg).arg
  end
end

ChipBattleData.UpdateSkillLevel = function(self, level)
  -- function num : 0_1 , upvalues : _ENV
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      v:Update(level)
      if self.level ~= level then
        self.level = level
      end
    end
  end
end

ChipBattleData.ExecutePropHero = function(self, hero, propNum)
  -- function num : 0_2 , upvalues : _ENV, HeroAttrUtility
  for k,property in ipairs(self.attributeIdList) do
    local value = ((self.chipCfg).attribute_initial)[k] + (((self.chipCfg).level_increase)[k] or 0) * (propNum - 1)
    ;
    (HeroAttrUtility.OffsetAttrFromDynHero)(hero, property, value)
  end
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      hero:AddItemSkill(v)
    end
  end
end

ChipBattleData.RollbackHero = function(self, hero, propNum)
  -- function num : 0_3 , upvalues : _ENV, HeroAttrUtility
  for k,property in ipairs(self.attributeIdList) do
    local value = ((self.chipCfg).attribute_initial)[k] + (((self.chipCfg).level_increase)[k] or 0) * (propNum - 1)
    ;
    (HeroAttrUtility.OffsetAttrFromDynHero)(hero, property, -value)
  end
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      hero:RemoveItemSkill(v)
    end
  end
end

ChipBattleData.ExecutePropDynPlayer = function(self, dynPlayer, propNum)
  -- function num : 0_4 , upvalues : _ENV, HeroAttrUtility
  for k,property in ipairs(self.attributeIdList) do
    local value = ((self.chipCfg).attribute_initial)[k] + (((self.chipCfg).level_increase)[k] or 0) * (propNum - 1)
    ;
    (HeroAttrUtility.OffsetAttrFormDynPlayer)(dynPlayer.dynData, property, value)
  end
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      dynPlayer:AddItemSkill(v)
    end
  end
end

ChipBattleData.RollbackDynPlayer = function(self, dynPlayer, propNum)
  -- function num : 0_5 , upvalues : _ENV, HeroAttrUtility
  for k,property in ipairs(self.attributeIdList) do
    local value = ((self.chipCfg).attribute_initial)[k] + (((self.chipCfg).level_increase)[k] or 0) * (propNum - 1)
    ;
    (HeroAttrUtility.OffsetAttrFormDynPlayer)(dynPlayer.dynData, property, -value)
  end
  if self.skillDataList ~= nil then
    for k,v in ipairs(self.skillDataList) do
      dynPlayer:RemoveItemSkill(v)
    end
  end
end

ChipBattleData.GetValidCharacterListByBtCtlr = function(self, battleController)
  -- function num : 0_6 , upvalues : ChipEnum
  local validHeroList = {}
  if self.influenceType == (ChipEnum.eChipInfluenceType).AllHero then
    for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
      local hero = ((battleController.PlayerTeamController).battleOriginRoleList)[i]
      validHeroList[hero] = true
    end
  else
    do
      if self.influenceType == (ChipEnum.eChipInfluenceType).Camp then
        for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
          local hero = ((battleController.PlayerTeamController).battleOriginRoleList)[i]
          if (hero.character):GetCamp() == self.influenceArg then
            validHeroList[hero] = true
          end
        end
      else
        do
          if self.influenceType == (ChipEnum.eChipInfluenceType).Career then
            for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
              local hero = ((battleController.PlayerTeamController).battleOriginRoleList)[i]
              if (hero.character):GetCareer() == self.influenceArg then
                validHeroList[hero] = true
              end
            end
          else
            do
              if self.influenceType == (ChipEnum.eChipInfluenceType).Row then
                for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
                  local hero = ((battleController.PlayerTeamController).battleOriginRoleList)[i]
                  if (hero.character):GetAttackRangeType() == self.influenceArg then
                    validHeroList[hero] = true
                  end
                end
              else
                do
                  if self.influenceType == (ChipEnum.eChipInfluenceType).HeroId then
                    for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
                      local hero = ((battleController.PlayerTeamController).battleOriginRoleList)[i]
                      if (hero.character).dataId == self.influenceArg then
                        validHeroList[hero] = true
                      end
                    end
                  else
                    do
                      if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyAllHero then
                        for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                          local hero = ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                          validHeroList[hero] = true
                        end
                      else
                        do
                          if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyCareer then
                            for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                              local hero = ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                              if (hero.character):GetCareer() == self.influenceArg then
                                validHeroList[hero] = true
                              end
                            end
                          else
                            do
                              if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyCamp then
                                for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                  local hero = ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                  if (hero.character):GetCamp() == self.influenceArg then
                                    validHeroList[hero] = true
                                  end
                                end
                              else
                                do
                                  if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyRow then
                                    for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                      local hero = ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                      if (hero.character):GetAttackRangeType() == self.influenceArg then
                                        validHeroList[hero] = true
                                      end
                                    end
                                  else
                                    do
                                      if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyHeroId then
                                        for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                          local hero = ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                          if (hero.character).dataId == self.influenceArg then
                                            validHeroList[hero] = true
                                          end
                                        end
                                      end
                                      do
                                        return validHeroList
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
              end
            end
          end
        end
      end
    end
  end
end

ChipBattleData.GetValidRoleList = function(self, dynBattleRoleList, belong)
  -- function num : 0_7 , upvalues : _ENV, ChipEnum
  local result = {}
  if #dynBattleRoleList == 0 then
    return result
  end
  local validRoleList = {}
  if belong == eBattleRoleBelong.player then
    if self.influenceType == (ChipEnum.eChipInfluenceType).AllHero then
      for k,role in ipairs(dynBattleRoleList) do
        validRoleList[role] = true
      end
    else
      do
        if self.influenceType == (ChipEnum.eChipInfluenceType).Camp then
          for k,role in ipairs(dynBattleRoleList) do
            if role:GetCamp() == self.influenceArg then
              validRoleList[role] = true
            end
          end
        else
          do
            if self.influenceType == (ChipEnum.eChipInfluenceType).Career then
              for k,role in ipairs(dynBattleRoleList) do
                if role:GetCareer() == self.influenceArg then
                  validRoleList[role] = true
                end
              end
            else
              do
                if self.influenceType == (ChipEnum.eChipInfluenceType).Row then
                  for k,role in ipairs(dynBattleRoleList) do
                    if role:GetAttackRangeType() == self.influenceArg then
                      validRoleList[role] = true
                    end
                  end
                else
                  do
                    if self.influenceType == (ChipEnum.eChipInfluenceType).HeroId then
                      for k,role in ipairs(dynBattleRoleList) do
                        if role.dataId == self.influenceArg then
                          validRoleList[role] = true
                        end
                      end
                    end
                    do
                      if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyAllHero then
                        for k,enemy in ipairs(dynBattleRoleList) do
                          validRoleList[enemy] = true
                        end
                      else
                        do
                          if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyCamp then
                            for k,enemy in ipairs(dynBattleRoleList) do
                              if enemy:GetCamp() == self.influenceArg then
                                validRoleList[enemy] = true
                              end
                            end
                          else
                            do
                              if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyCareer then
                                for k,enemy in ipairs(dynBattleRoleList) do
                                  if enemy:GetCareer() == self.influenceArg then
                                    validRoleList[enemy] = true
                                  end
                                end
                              else
                                do
                                  if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyRow then
                                    for k,enemy in ipairs(dynBattleRoleList) do
                                      if enemy:GetAttackRangeType() == self.influenceArg then
                                        validRoleList[enemy] = true
                                      end
                                    end
                                  else
                                    do
                                      if self.influenceType == (ChipEnum.eChipInfluenceType).EnemyHeroId then
                                        for k,enemy in ipairs(dynBattleRoleList) do
                                          if enemy.dataId == self.influenceArg then
                                            validRoleList[enemy] = true
                                          end
                                        end
                                      end
                                      do
                                        for k,v in ipairs(dynBattleRoleList) do
                                          if validRoleList[v] ~= nil then
                                            (table.insert)(result, v)
                                          end
                                        end
                                        return result
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
              end
            end
          end
        end
      end
    end
  end
end

ChipBattleData.IsValidDynPlayer = function(self)
  -- function num : 0_8 , upvalues : ChipEnum
  do return self.influenceType == (ChipEnum.eChipInfluenceType).DynPlayer end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChipBattleData.SetOnlyForOneHero = function(self, heroId)
  -- function num : 0_9 , upvalues : ChipEnum
  self.influenceType = (ChipEnum.eChipInfluenceType).HeroId
  self.influenceArg = heroId
end

return ChipBattleData

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChipBattleData = class("ChipBattleData")
local CS_BattleManager_Ins = (CS.BattleManager).Instance
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ChipBattleData.ctor = function(self, chipCfg, skillLevel, skillType)
    -- function num : 0_0 , upvalues : ExplorationEnum, _ENV, DynBattleSkill
    if not skillLevel then skillLevel = 1 end
    self.level = skillLevel
    self.chipCfg = chipCfg
    if not skillType then
        local battleSkillType = (ExplorationEnum.eBattleSkillType).Chip
    end
    self.attributeIdList = (self.chipCfg).attribute_id
    if #(self.chipCfg).skill_list > 0 then
        self.skillDataList = {}
        for k, skillId in ipairs((self.chipCfg).skill_list) do
            local skillData = (DynBattleSkill.New)(skillId, skillLevel,
                                                   battleSkillType)
            skillData.itemId = (self.chipCfg).id;
            (table.insert)(self.skillDataList, skillData)
        end
    end
    do
        self.influenceType = (self.chipCfg).influence
        self.influenceArg = (self.chipCfg).arg
    end
end

ChipBattleData.UpdateSkillLevel = function(self, level)
    -- function num : 0_1 , upvalues : _ENV
    if self.skillDataList ~= nil then
        for k, v in ipairs(self.skillDataList) do
            v:Update(level)
            if self.level ~= level then self.level = level end
        end
    end
end

ChipBattleData.ExecutePropHero = function(self, hero, propNum)
    -- function num : 0_2 , upvalues : _ENV, HeroAttrUtility
    for k, property in ipairs(self.attributeIdList) do
        local value = ((self.chipCfg).attribute_initial)[k] +
                          (((self.chipCfg).level_increase)[k] or 0) *
                          (propNum - 1);
        (HeroAttrUtility.OffsetAttrFromDynHero)(hero, property, value)
    end
    if self.skillDataList ~= nil then
        for k, v in ipairs(self.skillDataList) do hero:AddItemSkill(v) end
    end
end

ChipBattleData.RollbackHero = function(self, hero, propNum)
    -- function num : 0_3 , upvalues : _ENV, HeroAttrUtility
    for k, property in ipairs(self.attributeIdList) do
        local value = ((self.chipCfg).attribute_initial)[k] +
                          (((self.chipCfg).level_increase)[k] or 0) *
                          (propNum - 1);
        (HeroAttrUtility.OffsetAttrFromDynHero)(hero, property, -value)
    end
    if self.skillDataList ~= nil then
        for k, v in ipairs(self.skillDataList) do hero:RemoveItemSkill(v) end
    end
end

ChipBattleData.ExecutePropDynPlayer = function(self, dynPlayer, propNum)
    -- function num : 0_4 , upvalues : _ENV, HeroAttrUtility
    for k, property in ipairs(self.attributeIdList) do
        local value = ((self.chipCfg).attribute_initial)[k] +
                          (((self.chipCfg).level_increase)[k] or 0) *
                          (propNum - 1);
        (HeroAttrUtility.OffsetAttrFormDynPlayer)(dynPlayer.dynData, property,
                                                  value)
    end
    if self.skillDataList ~= nil then
        for k, v in ipairs(self.skillDataList) do
            dynPlayer:AddItemSkill(v)
        end
    end
end

ChipBattleData.RollbackDynPlayer = function(self, dynPlayer, propNum)
    -- function num : 0_5 , upvalues : _ENV, HeroAttrUtility
    for k, property in ipairs(self.attributeIdList) do
        local value = ((self.chipCfg).attribute_initial)[k] +
                          (((self.chipCfg).level_increase)[k] or 0) *
                          (propNum - 1);
        (HeroAttrUtility.OffsetAttrFormDynPlayer)(dynPlayer.dynData, property,
                                                  -value)
    end
    if self.skillDataList ~= nil then
        for k, v in ipairs(self.skillDataList) do
            dynPlayer:RemoveItemSkill(v)
        end
    end
end

ChipBattleData.GetValidCharacterListByBtCtlr =
    function(self, battleController)
        -- function num : 0_6 , upvalues : ChipEnum
        local validHeroList = {}
        if self.influenceType == (ChipEnum.eChipInfluenceType).AllHero then
            for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
                local hero =
                    ((battleController.PlayerTeamController).battleOriginRoleList)[i]
                validHeroList[hero] = true
            end
        else
            do
                if self.influenceType == (ChipEnum.eChipInfluenceType).Camp then
                    for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
                        local hero =
                            ((battleController.PlayerTeamController).battleOriginRoleList)[i]
                        if (hero.character):GetCamp() == self.influenceArg then
                            validHeroList[hero] = true
                        end
                    end
                else
                    do
                        if self.influenceType ==
                            (ChipEnum.eChipInfluenceType).Career then
                            for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
                                local hero =
                                    ((battleController.PlayerTeamController).battleOriginRoleList)[i]
                                if (hero.character):GetCareer() ==
                                    self.influenceArg then
                                    validHeroList[hero] = true
                                end
                            end
                        else
                            do
                                if self.influenceType ==
                                    (ChipEnum.eChipInfluenceType).Row then
                                    for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
                                        local hero =
                                            ((battleController.PlayerTeamController).battleOriginRoleList)[i]
                                        if (hero.character):GetAttackRangeType() ==
                                            self.influenceArg then
                                            validHeroList[hero] = true
                                        end
                                    end
                                else
                                    do
                                        if self.influenceType ==
                                            (ChipEnum.eChipInfluenceType).HeroId then
                                            for i = 0, #(battleController.PlayerTeamController).battleOriginRoleList do
                                                local hero =
                                                    ((battleController.PlayerTeamController).battleOriginRoleList)[i]
                                                if (hero.character).dataId ==
                                                    self.influenceArg then
                                                    validHeroList[hero] = true
                                                end
                                            end
                                        else
                                            do
                                                if self.influenceType ==
                                                    (ChipEnum.eChipInfluenceType).EnemyAllHero then
                                                    for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                                        local hero =
                                                            ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                                        validHeroList[hero] =
                                                            true
                                                    end
                                                else
                                                    do
                                                        if self.influenceType ==
                                                            (ChipEnum.eChipInfluenceType).EnemyCareer then
                                                            for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                                                local hero =
                                                                    ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                                                if (hero.character):GetCareer() ==
                                                                    self.influenceArg then
                                                                    validHeroList[hero] =
                                                                        true
                                                                end
                                                            end
                                                        else
                                                            do
                                                                if self.influenceType ==
                                                                    (ChipEnum.eChipInfluenceType).EnemyCamp then
                                                                    for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                                                        local 
                                                                            hero =
                                                                            ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                                                        if (hero.character):GetCamp() ==
                                                                            self.influenceArg then
                                                                            validHeroList[hero] =
                                                                                true
                                                                        end
                                                                    end
                                                                else
                                                                    do
                                                                        if self.influenceType ==
                                                                            (ChipEnum.eChipInfluenceType).EnemyRow then
                                                                            for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                                                                local 
                                                                                    hero =
                                                                                    ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                                                                if (hero.character):GetAttackRangeType() ==
                                                                                    self.influenceArg then
                                                                                    validHeroList[hero] =
                                                                                        true
                                                                                end
                                                                            end
                                                                        else
                                                                            do
                                                                                if self.influenceType ==
                                                                                    (ChipEnum.eChipInfluenceType).EnemyHeroId then
                                                                                    for i = 0, #(battleController.EnemyTeamController).battleOriginRoleList do
                                                                                        local 
                                                                                            hero =
                                                                                            ((battleController.EnemyTeamController).battleOriginRoleList)[i]
                                                                                        if (hero.character).dataId ==
                                                                                            self.influenceArg then
                                                                                            validHeroList[hero] =
                                                                                                true
                                                                                        end
                                                                                    end
                                                                                end
                                                                                do
                                                                                    return
                                                                                        validHeroList
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
                                end
                            end
                        end
                    end
                end
            end
        end
    end

ChipBattleData.GetValidRoleList = function(self, dynBattleRoleList, belong)
    -- function num : 0_7 , upvalues : _ENV, ChipEnum
    local result = {}
    if #dynBattleRoleList == 0 then return result end
    local validRoleList = {}
    if belong == eBattleRoleBelong.player then
        if self.influenceType == (ChipEnum.eChipInfluenceType).AllHero then
            for k, role in ipairs(dynBattleRoleList) do
                validRoleList[role] = true
            end
        else
            do
                if self.influenceType == (ChipEnum.eChipInfluenceType).Camp then
                    for k, role in ipairs(dynBattleRoleList) do
                        if role:GetCamp() == self.influenceArg then
                            validRoleList[role] = true
                        end
                    end
                else
                    do
                        if self.influenceType ==
                            (ChipEnum.eChipInfluenceType).Career then
                            for k, role in ipairs(dynBattleRoleList) do
                                if role:GetCareer() == self.influenceArg then
                                    validRoleList[role] = true
                                end
                            end
                        else
                            do
                                if self.influenceType ==
                                    (ChipEnum.eChipInfluenceType).Row then
                                    for k, role in ipairs(dynBattleRoleList) do
                                        if role:GetAttackRangeType() ==
                                            self.influenceArg then
                                            validRoleList[role] = true
                                        end
                                    end
                                else
                                    do
                                        if self.influenceType ==
                                            (ChipEnum.eChipInfluenceType).HeroId then
                                            for k, role in
                                                ipairs(dynBattleRoleList) do
                                                if role.dataId ==
                                                    self.influenceArg then
                                                    validRoleList[role] = true
                                                end
                                            end
                                        end
                                        do
                                            if self.influenceType ==
                                                (ChipEnum.eChipInfluenceType).EnemyAllHero then
                                                for k, enemy in
                                                    ipairs(dynBattleRoleList) do
                                                    validRoleList[enemy] = true
                                                end
                                            else
                                                do
                                                    if self.influenceType ==
                                                        (ChipEnum.eChipInfluenceType).EnemyCamp then
                                                        for k, enemy in
                                                            ipairs(
                                                                dynBattleRoleList) do
                                                            if enemy:GetCamp() ==
                                                                self.influenceArg then
                                                                validRoleList[enemy] =
                                                                    true
                                                            end
                                                        end
                                                    else
                                                        do
                                                            if self.influenceType ==
                                                                (ChipEnum.eChipInfluenceType).EnemyCareer then
                                                                for k, enemy in
                                                                    ipairs(
                                                                        dynBattleRoleList) do
                                                                    if enemy:GetCareer() ==
                                                                        self.influenceArg then
                                                                        validRoleList[enemy] =
                                                                            true
                                                                    end
                                                                end
                                                            else
                                                                do
                                                                    if self.influenceType ==
                                                                        (ChipEnum.eChipInfluenceType).EnemyRow then
                                                                        for k,
                                                                            enemy in
                                                                            ipairs(
                                                                                dynBattleRoleList) do
                                                                            if enemy:GetAttackRangeType() ==
                                                                                self.influenceArg then
                                                                                validRoleList[enemy] =
                                                                                    true
                                                                            end
                                                                        end
                                                                    else
                                                                        do
                                                                            if self.influenceType ==
                                                                                (ChipEnum.eChipInfluenceType).EnemyHeroId then
                                                                                for 
                                                                                    k,
                                                                                    enemy in
                                                                                    ipairs(
                                                                                        dynBattleRoleList) do
                                                                                    if enemy.dataId ==
                                                                                        self.influenceArg then
                                                                                        validRoleList[enemy] =
                                                                                            true
                                                                                    end
                                                                                end
                                                                            end
                                                                            do
                                                                                for 
                                                                                    k,
                                                                                    v in
                                                                                    ipairs(
                                                                                        dynBattleRoleList) do
                                                                                    if validRoleList[v] ~=
                                                                                        nil then
                                                                                        (table.insert)(
                                                                                            result,
                                                                                            v)
                                                                                    end
                                                                                end
                                                                                return
                                                                                    result
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
                            end
                        end
                    end
                end
            end
        end
    end
end

ChipBattleData.IsValidDynPlayer = function(self)
    -- function num : 0_8 , upvalues : ChipEnum
    do return self.influenceType == (ChipEnum.eChipInfluenceType).DynPlayer end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChipBattleData.SetOnlyForOneHero = function(self, heroId)
    -- function num : 0_9 , upvalues : ChipEnum
    self.influenceType = (ChipEnum.eChipInfluenceType).HeroId
    self.influenceArg = heroId
end

return ChipBattleData

