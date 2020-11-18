-- params : ...
-- function num : 0 , upvalues : _ENV
local ChipEnum = {}
ChipEnum.ePropActionResult = {Success = 0, Skip = 1, Fail = 2}
ChipEnum.eChipInfluenceType = {AllHero = 101, Career = 102, Camp = 103, Row = 104, HeroId = 105, EnemyAllHero = 601, EnemyCareer = 602, EnemyCamp = 603, EnemyRow = 604, EnemyHeroId = 605}
ChipEnum.eChipSelectState = {StateNone = 0, StateSelected = 1}
return ChipEnum

