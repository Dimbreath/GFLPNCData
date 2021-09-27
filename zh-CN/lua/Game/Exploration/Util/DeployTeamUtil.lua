local DeployTeamUtil = {}
local autoDeployListPool = (CommonPool.New)(function()
  -- function num : 0_0
  return {}
end
, function(p)
  -- function num : 0_1 , upvalues : _ENV
  (table.removeall)(p)
  return true
end
)
local banchPosArray = {1, 3, 2, 0, 4}
DeployTeamUtil.banchPosArray = banchPosArray
DeployTeamUtil.FinalDeployRole = function(defendRoles, longRangeRoles, benchRoles, deployDic, mapDeployX, mapSizeY, benchX)
  -- function num : 0_2 , upvalues : _ENV, banchPosArray
  if #defendRoles > 0 then
    for x = mapDeployX - 1, 0, -1 do
      for y = 0, mapSizeY - 1 do
        if #defendRoles ~= 0 then
          local coord = x << 16 | y
          if not deployDic[coord] then
            deployDic[coord] = true
            local role = (table.remove)(defendRoles)
            role:SetCoordXY(x, y, benchX)
          end
          do
            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do
    if #longRangeRoles > 0 then
      for x = 0, mapDeployX - 1 do
        for y = 0, mapSizeY - 1 do
          if #longRangeRoles ~= 0 then
            local coord = x << 16 | y
            if not deployDic[coord] then
              deployDic[coord] = true
              local role = (table.remove)(longRangeRoles)
              role:SetCoordXY(x, y, benchX)
            end
            do
              -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC60: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    do
      local index = 1
      for k,role in pairs(benchRoles) do
        role:SetCoordXY(benchX, banchPosArray[index], benchX)
        index = index + 1
      end
    end
  end
end

DeployTeamUtil.DeployHeroTeam = function(heroList, size_row, size_col, deploy_rows, lastDeployDic)
  -- function num : 0_3 , upvalues : _ENV, autoDeployListPool, DeployTeamUtil
  local benchX = (ConfigData.buildinConfig).BenchX
  local longRangeRoles = autoDeployListPool:PoolGet()
  local defendRoles = autoDeployListPool:PoolGet()
  local benchRoles = autoDeployListPool:PoolGet()
  local deployDic = {}
  if not lastDeployDic then
    lastDeployDic = {}
  end
  for k,heroData in pairs(heroList) do
    if heroData.onBench then
      (table.insert)(benchRoles, heroData)
    else
      if lastDeployDic[heroData.dataId] ~= nil then
        local coord = lastDeployDic[heroData.dataId]
        local x, y = (BattleUtil.Pos2XYCoord)(coord)
        heroData:SetCoordXY(x, y, benchX)
        deployDic[coord] = true
      else
        do
          do
            if heroData.attackRange <= 1 then
              (table.insert)(defendRoles, heroData)
            else
              ;
              (table.insert)(longRangeRoles, heroData)
            end
            -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  local mapDeployX = deploy_rows
  local mapSizeY = size_col
  local totalHeroCount = #heroList
  local defendRoleCount = #defendRoles
  local longRangeRoleCount = #longRangeRoles
  if defendRoleCount > 3 or longRangeRoleCount > 3 then
    (DeployTeamUtil.FinalDeployRole)(defendRoles, longRangeRoles, benchRoles, deployDic, mapDeployX, mapSizeY, benchX)
    autoDeployListPool:PoolPut(longRangeRoles)
    autoDeployListPool:PoolPut(defendRoles)
    autoDeployListPool:PoolPut(benchRoles)
    return 
  end
  if defendRoleCount > 0 then
    local curRow = mapDeployX - 1
    if totalHeroCount <= defendRoleCount then
      curRow = 0
    end
    if defendRoleCount > 2 then
      for c = mapSizeY - 1, 0, -1 do
        -- DECOMPILER ERROR at PC114: Unhandled construct in 'MakeBoolean' P1

        if c % 2 == 0 and #defendRoles ~= 0 then
          local coord = curRow << 16 | c
          if not deployDic[coord] then
            deployDic[coord] = true
            local role = (table.remove)(defendRoles)
            role:SetCoordXY(curRow, c, benchX)
          end
          do
            -- DECOMPILER ERROR at PC127: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC127: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    else
      if defendRoleCount == 2 then
        if totalHeroCount - defendRoleCount == 3 then
          local role = (table.remove)(defendRoles)
          role:SetCoordXY(1, 0, benchX)
          role = (table.remove)(defendRoles)
          role:SetCoordXY(1, 4, benchX)
        else
          do
            for c = mapSizeY - 1, 0, -1 do
              -- DECOMPILER ERROR at PC166: Unhandled construct in 'MakeBoolean' P1

              if c % 2 == 1 and #defendRoles ~= 0 then
                local coord = curRow << 16 | c
                if not deployDic[coord] then
                  deployDic[coord] = true
                  local role = (table.remove)(defendRoles)
                  role:SetCoordXY(curRow, c, benchX)
                end
                do
                  -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC179: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
            if defendRoleCount == 1 then
              local curCow = (mapSizeY - 1) // 2
              local coord = curRow << 16 | curCow
              if not deployDic[coord] then
                deployDic[coord] = true
                local role = (table.remove)(defendRoles)
                role:SetCoordXY(curRow, curCow, benchX)
              end
            end
            do
              if longRangeRoleCount > 0 then
                local curRow = 0
                if longRangeRoleCount >= 5 then
                  for c = mapSizeY - 1, 0, -1 do
                    if #longRangeRoles ~= 0 then
                      local coord = curRow << 16 | c
                      if not deployDic[coord] then
                        deployDic[coord] = true
                        local role = (table.remove)(longRangeRoles)
                        role:SetCoordXY(curRow, c, benchX)
                      end
                      do
                        -- DECOMPILER ERROR at PC227: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC227: LeaveBlock: unexpected jumping out IF_STMT

                      end
                    end
                  end
                else
                  if longRangeRoleCount == 4 then
                    for c = 0, 1 do
                      if #longRangeRoles ~= 0 then
                        local coord = curRow << 16 | c
                        if not deployDic[coord] then
                          deployDic[coord] = true
                          local role = (table.remove)(longRangeRoles)
                          role:SetCoordXY(curRow, c, benchX)
                        end
                        do
                          -- DECOMPILER ERROR at PC253: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC253: LeaveBlock: unexpected jumping out IF_STMT

                        end
                      end
                    end
                    for c = mapSizeY - 1, 3, -1 do
                      if #longRangeRoles ~= 0 then
                        local coord = curRow << 16 | c
                        if not deployDic[coord] then
                          deployDic[coord] = true
                          local role = (table.remove)(longRangeRoles)
                          role:SetCoordXY(curRow, c, benchX)
                        end
                        do
                          -- DECOMPILER ERROR at PC276: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC276: LeaveBlock: unexpected jumping out IF_STMT

                        end
                      end
                    end
                  else
                    if longRangeRoleCount == 3 then
                      for c = mapSizeY - 1, 0, -1 do
                        -- DECOMPILER ERROR at PC292: Unhandled construct in 'MakeBoolean' P1

                        if c % 2 == 0 and #longRangeRoles ~= 0 then
                          local coord = curRow << 16 | c
                          if not deployDic[coord] then
                            deployDic[coord] = true
                            local role = (table.remove)(longRangeRoles)
                            role:SetCoordXY(curRow, c, benchX)
                          end
                          do
                            -- DECOMPILER ERROR at PC305: LeaveBlock: unexpected jumping out IF_THEN_STMT

                            -- DECOMPILER ERROR at PC305: LeaveBlock: unexpected jumping out IF_STMT

                          end
                        end
                      end
                    else
                      if longRangeRoleCount == 2 then
                        if defendRoleCount > 0 then
                          if #longRangeRoles > 0 then
                            local coord = curRow << 16 | 0
                            if not deployDic[coord] then
                              deployDic[coord] = true
                              local role = (table.remove)(longRangeRoles)
                              role:SetCoordXY(curRow, 0, benchX)
                            end
                          end
                          do
                            if #longRangeRoles > 0 then
                              local coord = curRow << 16 | mapSizeY - 1
                              if not deployDic[coord] then
                                deployDic[coord] = true
                                local role = (table.remove)(longRangeRoles)
                                role:SetCoordXY(curRow, mapSizeY - 1, benchX)
                              end
                            end
                            do
                              for c = mapSizeY - 1, 0, -1 do
                                -- DECOMPILER ERROR at PC361: Unhandled construct in 'MakeBoolean' P1

                                if c % 2 == 1 and #longRangeRoles ~= 0 then
                                  local coord = curRow << 16 | c
                                  if not deployDic[coord] then
                                    deployDic[coord] = true
                                    local role = (table.remove)(longRangeRoles)
                                    role:SetCoordXY(curRow, c, benchX)
                                  end
                                  do
                                    -- DECOMPILER ERROR at PC374: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC374: LeaveBlock: unexpected jumping out IF_STMT

                                  end
                                end
                              end
                              if longRangeRoleCount == 1 and #longRangeRoles > 0 then
                                local curCow = (mapSizeY - 1) // 2
                                local coord = curRow << 16 | curCow
                                if not deployDic[coord] then
                                  deployDic[coord] = true
                                  local role = (table.remove)(longRangeRoles)
                                  role:SetCoordXY(curRow, curCow, benchX)
                                end
                              end
                              do
                                ;
                                (DeployTeamUtil.FinalDeployRole)(defendRoles, longRangeRoles, benchRoles, deployDic, mapDeployX, mapSizeY, benchX)
                                autoDeployListPool:PoolPut(longRangeRoles)
                                autoDeployListPool:PoolPut(defendRoles)
                                autoDeployListPool:PoolPut(benchRoles)
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

DeployTeamUtil.AutoBattleDeploy = function(roomData, heroList, size_row, size_col, deploy_rows)
  -- function num : 0_4 , upvalues : autoDeployListPool, _ENV, banchPosArray
  if roomData == nil or roomData.effectGridList == nil or #roomData.effectGridList == 0 then
    return 
  end
  local benchRoles = autoDeployListPool:PoolGet()
  local stageRoles = autoDeployListPool:PoolGet()
  local roleAttrDics = {}
  local succCoordDic = {}
  for coord,v in pairs(roomData.occupyCoords) do
    succCoordDic[coord] = true
  end
  for _,dynHero in pairs(heroList) do
    if dynHero.onBench then
      (table.insert)(benchRoles, dynHero)
    else
      ;
      (table.insert)(stageRoles, dynHero)
    end
    local attrDic = dynHero:GetDynBattleRoleAttrDic()
    roleAttrDics[dynHero.dataId] = attrDic
  end
  local benchX = (ConfigData.buildinConfig).BenchX
  for _,dynGrid in pairs(roomData.effectGridList) do
    local roles = nil
    if dynGrid.x == benchX then
      roles = benchRoles
    else
      roles = stageRoles
    end
    if #roles ~= 0 then
      local auto_career = dynGrid:GetGridAutoCareer()
      local validRoles = autoDeployListPool:PoolGet()
      local maxCareerKey = -1
      for _,dynHero in pairs(roles) do
        if not auto_career[dynHero:GetCareer()] then
          local careerKey = auto_career[0]
        end
        if careerKey ~= nil and maxCareerKey <= careerKey and dynGrid:GetGridNecessaryFormulaValue(roleAttrDics[dynHero.dataId]) then
          if maxCareerKey < careerKey then
            maxCareerKey = careerKey
          end
          ;
          (table.insert)(validRoles, dynHero)
        end
      end
      if #validRoles == 0 then
        autoDeployListPool:PoolPut(validRoles)
      else
        local bestRole = nil
        if #validRoles > 1 then
          if dynGrid:GetAutoIsMax() then
            local bestValue = CommonUtil.Int64Min
            for _,dynHero in pairs(validRoles) do
              if not auto_career[dynHero:GetCareer()] then
                local careerKey = auto_career[0]
              end
              if maxCareerKey <= careerKey then
                local value = dynGrid:GetGridAttrFormulaValue(roleAttrDics[dynHero.dataId])
                if bestValue < value then
                  bestValue = value
                  bestRole = dynHero
                end
              end
            end
          else
            do
              local bestValue = CommonUtil.Int64Max
              for _,dynHero in pairs(validRoles) do
                if not auto_career[dynHero:GetCareer()] then
                  local careerKey = auto_career[0]
                end
                if maxCareerKey <= careerKey then
                  local value = dynGrid:GetGridAttrFormulaValue(roleAttrDics[dynHero.dataId])
                  if value < bestValue then
                    bestValue = value
                    bestRole = dynHero
                  end
                end
              end
              do
                bestRole = validRoles[1]
                if bestRole == nil then
                  error("DeployTeamUtil.AutoBattleDeploy get bestRole is null!")
                  autoDeployListPool:PoolPut(validRoles)
                else
                  for index,dynHero in pairs(roles) do
                    if dynHero == bestRole then
                      (table.remove)(roles, R27_PC189)
                      break
                    end
                  end
                  do
                    do
                      bestRole:SetCoord(dynGrid.coord, benchX)
                      succCoordDic[dynGrid.coord] = bestRole
                      autoDeployListPool:PoolPut(validRoles)
                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC203: LeaveBlock: unexpected jumping out IF_STMT

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
  local conflictRoles = autoDeployListPool:PoolGet()
  for k,dynHero in pairs(benchRoles) do
    local curHero = succCoordDic[dynHero.coord]
    if curHero == nil then
      succCoordDic[dynHero.coord] = dynHero
    else
      if curHero ~= dynHero then
        (table.insert)(conflictRoles, dynHero)
      end
    end
  end
  local index = 1
  for k,role in pairs(conflictRoles) do
    local coord = nil
    repeat
      coord = (BattleUtil.XYCoord2Pos)(benchX, banchPosArray[index])
      index = index + 1
    until succCoordDic[coord] == nil
    role:SetCoord(coord, benchX)
  end
  autoDeployListPool:PoolPut(conflictRoles)
  local longRangeRoles = autoDeployListPool:PoolGet()
  local defendRoles = autoDeployListPool:PoolGet()
  for k,dynHero in pairs(stageRoles) do
    local curHero = succCoordDic[dynHero.coord]
    if curHero == nil then
      succCoordDic[dynHero.coord] = dynHero
    else
      if curHero ~= dynHero then
        if dynHero.attackRange <= 1 then
          (table.insert)(defendRoles, dynHero)
        else
          ;
          (table.insert)(longRangeRoles, dynHero)
        end
      end
    end
  end
  local mapDeployX = deploy_rows
  local mapSizeY = size_col
  if #defendRoles > 0 then
    for x = mapDeployX - 1, 0, -1 do
      for y = 0, mapSizeY - 1 do
        if #defendRoles ~= 0 then
          local coord = (BattleUtil.XYCoord2Pos)(x, y)
          do
            if succCoordDic[coord] == nil then
              local role = (table.remove)(defendRoles)
              succCoordDic[coord] = role
              role:SetCoordXY(x, y, benchX)
            end
            -- DECOMPILER ERROR at PC323: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC323: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do
    if #longRangeRoles > 0 then
      for x = 0, mapDeployX - 1 do
        for y = 0, mapSizeY - 1 do
          if #longRangeRoles ~= 0 then
            local coord = (BattleUtil.XYCoord2Pos)(x, y)
            do
              if succCoordDic[coord] == nil then
                local role = (table.remove)(longRangeRoles)
                succCoordDic[coord] = role
                -- DECOMPILER ERROR at PC352: Overwrote pending register: R27 in 'AssignReg'

                role:SetCoordXY(x, y, benchX)
              end
              -- DECOMPILER ERROR at PC357: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC357: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    do
      autoDeployListPool:PoolPut(longRangeRoles)
      autoDeployListPool:PoolPut(defendRoles)
      autoDeployListPool:PoolPut(benchRoles)
      autoDeployListPool:PoolPut(stageRoles)
    end
  end
end

return DeployTeamUtil

