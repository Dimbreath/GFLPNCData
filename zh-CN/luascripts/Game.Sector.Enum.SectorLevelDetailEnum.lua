-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorLevelDetailEnum = {}
SectorLevelDetailEnum.eDifficulty = {normal = 1, nightmare = 2, infinity = (ConfigData.sector_stage).difficultyCount + 1}
SectorLevelDetailEnum.eDifficultyName = {[(SectorLevelDetailEnum.eDifficulty).normal] = "normal", [(SectorLevelDetailEnum.eDifficulty).nightmare] = "nightmare", [(SectorLevelDetailEnum.eDifficulty).infinity] = "infinity"}
SectorLevelDetailEnum.eDetailType = {None = 0, Stage = 1, Avg = 2, Infinity = 3}
SectorLevelDetailEnum.eInfoNodeType = {LevelNormalInfo = 0, LevelChips = 1, LevelEnemies = 2}
SectorLevelDetailEnum.eTogType = {(SectorLevelDetailEnum.eInfoNodeType).LevelNormalInfo, (SectorLevelDetailEnum.eInfoNodeType).LevelChips}
return SectorLevelDetailEnum

