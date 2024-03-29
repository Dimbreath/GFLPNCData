local SectorLevelDetailEnum = {}
SectorLevelDetailEnum.eDifficulty = {normal = 1, nightmare = 2, infinity = (ConfigData.sector_stage).difficultyCount + 1, daily_challenge = (ConfigData.sector_stage).difficultyCount + 2, weekly_challenge = (ConfigData.sector_stage).difficultyCount + 3}
SectorLevelDetailEnum.eDifficultyName = {[(SectorLevelDetailEnum.eDifficulty).normal] = "normal", [(SectorLevelDetailEnum.eDifficulty).nightmare] = "nightmare", [(SectorLevelDetailEnum.eDifficulty).infinity] = "infinity"}
SectorLevelDetailEnum.eDetailType = {None = 0, Stage = 1, Avg = 2, Infinity = 3, PeriodicChallenge = 4, WeeklyChallenge = 5, DailyDungeon = 6}
SectorLevelDetailEnum.eInfoNodeType = {LevelNormalInfo = 0, LevelChips = 1, LevelEnemies = 2}
SectorLevelDetailEnum.eTogType = {(SectorLevelDetailEnum.eInfoNodeType).LevelNormalInfo, (SectorLevelDetailEnum.eInfoNodeType).LevelChips}
return SectorLevelDetailEnum

