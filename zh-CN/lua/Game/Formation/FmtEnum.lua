local FmtEnum = {}
FmtEnum.eFmtFromModule = {SectorLevel = 1, FriendshipDungeon = 2, MaterialDungeon = 3, Infinity = 4, ATHDungeon = 5, PeriodicChallenge = 6, WeeklyChallenge = 7, DailyDungeon = 8, DailyDungeonLevel = 9}
FmtEnum.eFmtGamePlayType = {None = 0, Exploration = 1, Dungeon = 2}
local fmtModule2PlayType = {[(FmtEnum.eFmtFromModule).SectorLevel] = (FmtEnum.eFmtGamePlayType).Exploration, [(FmtEnum.eFmtFromModule).FriendshipDungeon] = (FmtEnum.eFmtGamePlayType).Dungeon, [(FmtEnum.eFmtFromModule).MaterialDungeon] = (FmtEnum.eFmtGamePlayType).Dungeon, [(FmtEnum.eFmtFromModule).Infinity] = (FmtEnum.eFmtGamePlayType).Exploration, [(FmtEnum.eFmtFromModule).ATHDungeon] = (FmtEnum.eFmtGamePlayType).Dungeon, [(FmtEnum.eFmtFromModule).PeriodicChallenge] = (FmtEnum.eFmtGamePlayType).Exploration, [(FmtEnum.eFmtFromModule).WeeklyChallenge] = (FmtEnum.eFmtGamePlayType).Exploration}
FmtEnum.eFmtEvaluationAdvant = {advContain = 1, advantage = 2, inferior = 3}
FmtEnum.eFmtHeroDetailState = {Lock = 1, Empty = 2, HasHero = 3}
FmtEnum.GetFmtGameTypeByModuleId = function(modId)
  -- function num : 0_0 , upvalues : fmtModule2PlayType, FmtEnum
  local gameType = fmtModule2PlayType[modId]
  if not gameType then
    return (FmtEnum.eFmtGamePlayType).None
  end
end

return FmtEnum

