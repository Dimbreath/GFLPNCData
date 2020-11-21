-- params : ...
-- function num : 0 , upvalues : _ENV
local CherkerGeneralDungeon = {}
CherkerGeneralDungeon.LengthCheck = function(param)
    -- function num : 0_0
    if #param >= 2 then return true end
    return false
end

CherkerGeneralDungeon.IsPassDungeon = function(levelID)
    -- function num : 0_1 , upvalues : _ENV
    if levelID == 0 then return true end
    local levelBattleTimeCfg =
        (PlayerDataCenter.dungeonTotalBattleTimes)[levelID]
    if levelBattleTimeCfg == nil then return false end
    if levelBattleTimeCfg > 0 then return true end
    return false
end

CherkerGeneralDungeon.ParamsCheck = function(param)
    -- function num : 0_2 , upvalues : CherkerGeneralDungeon
    local ok = (CherkerGeneralDungeon.IsPassDungeon)(param[2])
    return ok
end

CherkerGeneralDungeon.GetUnlockInfo = function(param)
    -- function num : 0_3 , upvalues : _ENV
    local levelId = param[2]
    local stageCfg = (ConfigData.battle_dungeon)[levelId]
    if stageCfg == nil then
        error("Cant\'t find battleDungeon cfg,id = " .. tostring(levelId))
    end
    return (string.format)(ConfigData:GetTipContent(
                               TipContent.FunctionUnlockDescription_BattleDungeon),
                           (LanguageUtil.GetLocaleText)(stageCfg.name))
end

return CherkerGeneralDungeon

