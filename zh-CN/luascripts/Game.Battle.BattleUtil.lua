-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleUtil = {}
BattleUtil.mvpParaType = {damage = 1, injury = 2, selfHeal = 3, otherHeal = 4}
BattleUtil.mvpType = {heal = 0, damagem = 1, injury = 2, default = 3}
BattleUtil.Pos2XYCoord = function(pos)
    -- function num : 0_0 , upvalues : _ENV
    local x = pos >> 16
    local y = pos & CommonUtil.UInt16Max
    return x, y
end

BattleUtil.XYCoord2Pos = function(x, y)
    -- function num : 0_1
    local pos = x << 16 | y
    return pos
end

BattleUtil.GetChipAttrInfo = function(attrId, initValue, increaseValue, count,
                                      newcount)
    -- function num : 0_2 , upvalues : _ENV
    local attibuteCfg = (ConfigData.attribute)[attrId]
    if attibuteCfg == nil then
        error("Can\'t find attibuteCfg, id = " .. tostring(attrId))
        return ""
    end
    if not count then count = 1 end
    local atrName = (LanguageUtil.GetLocaleText)(attibuteCfg.name)
    local isRatio = attibuteCfg.num_type == 2
    local value = initValue + (increaseValue or 0) * (count - 1)
    if not isRatio or not tostring(FormatNum(value / 10)) .. "%" then
        local valueStr = (tostring(value))
    end
    local sign = nil
    if value < 0 then
        sign = ""
    else
        sign = "+"
    end
    if not increaseValue then
        local newValue = initValue + (newcount == nil or 0) * (newcount - 1)
        local newSign = nil
        if newValue < 0 then
            newSign = ""
        else
            newSign = "+"
        end
        if not isRatio or not tostring(FormatNum(newValue / 10)) .. "%" then
            local newValueStr = tostring(newValue)
        end
        do
            local content = (string.format)("%s%s%s%s<color=#%s>%s%s</color>",
                                            atrName, sign, valueStr,
                                            (ConfigData.buildinConfig).ChipLevelUpSign,
                                            (ConfigData.buildinConfig).ChipLevelUpColor,
                                            newSign, newValueStr)
            do return content end
            do
                local content = atrName .. sign .. valueStr
                do return content end
                -- DECOMPILER ERROR: 13 unprocessed JMP targets
            end
        end
    end
end

BattleUtil.GenMvp = function(playerRoleList)
    -- function num : 0_3 , upvalues : _ENV, BattleUtil
    local heroGradeList = {}
    local typeTotalValue = {}
    local bestDamageID, bestInjuryID, bestHealID = nil, nil, nil
    local bestDamageNum = 0
    local bestInjuryNum = 0
    local bestHealNum = 0
    for i = 0, playerRoleList.Count - 1 do
        local role = playerRoleList[i]
        if not (role.character).onBench then
            local heroData = (PlayerDataCenter.heroDic)[role.roleDataId]
            if heroData == nil then
                error("Can\'t find heroData by id, id = " ..
                          tostring(role.roleDataId))
            else
                local MVPNum = 0
                local ok, damageDetail =
                    (((CS.BattleStatistics).Instance).playerDamage):TryGetValue(
                        role)
                if ok then
                    MVPNum = MVPNum + damageDetail.damage *
                                 ((heroData.heroCfg).mvp_para)[(BattleUtil.mvpParaType).damage]
                    if bestDamageNum < damageDetail.damage then
                        bestDamageNum = damageDetail.damage
                        bestDamageID = role.roleDataId
                    end
                end
                local ok, takeDamageDetail =
                    (((CS.BattleStatistics).Instance).playerTakeDamage):TryGetValue(
                        role)
                if ok then
                    MVPNum = MVPNum + takeDamageDetail.damage *
                                 ((heroData.heroCfg).mvp_para)[(BattleUtil.mvpParaType).injury]
                    if bestInjuryNum < takeDamageDetail.damage then
                        bestInjuryNum = takeDamageDetail.damage
                        bestInjuryID = role.roleDataId
                    end
                end
                local ok, healDetail =
                    (((CS.BattleStatistics).Instance).playerHeal):TryGetValue(
                        role)
                if ok then
                    MVPNum = MVPNum + healDetail.selfHeal *
                                 ((heroData.heroCfg).mvp_para)[(BattleUtil.mvpParaType).selfHeal]
                    MVPNum = MVPNum + healDetail.otherHeal *
                                 ((heroData.heroCfg).mvp_para)[(BattleUtil.mvpParaType).otherHeal]
                    if bestHealNum < healDetail.heal then
                        bestHealNum = healDetail.heal
                        bestHealID = role.roleDataId
                    end
                end
                local gradeTab = {role = role, MVPNum = MVPNum};
                (table.insert)(heroGradeList, gradeTab)
            end
        end
    end
    (table.sort)(heroGradeList, function(role1, role2)
        -- function num : 0_3_0
        if role2.MVPNum >= role1.MVPNum then
            do return role1.MVPNum == role2.MVPNum end
            do
                return (role1.role).roleDataId < (role2.role).roleDataId
            end
            -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end
    end)
    local mvp = heroGradeList[1]
    local MvpFitNum = 0
    if (mvp.role).roleDataId == bestDamageID then
        mvp.MvpType = (BattleUtil.mvpType).damagem
        MvpFitNum = MvpFitNum + 1
    end
    if (mvp.role).roleDataId == bestInjuryID then
        mvp.MvpType = (BattleUtil.mvpType).injury
        MvpFitNum = MvpFitNum + 1
    end
    if (mvp.role).roleDataId == bestHealID then
        mvp.MvpType = (BattleUtil.mvpType).heal
        MvpFitNum = MvpFitNum + 1
    end
    if MvpFitNum == 0 or MvpFitNum > 1 then
        mvp.MvpType = (BattleUtil.mvpType).default
    end
    return mvp
end

return BattleUtil

