-- params : ...
-- function num : 0 , upvalues : _ENV
eItemType = {Resource = 1, GrowUp = 2, BattleUse = 3, ExplorationUse = 4, HeroCard = 5, ExplorationBuffer = 6, GlobalChip = 7, Package = 8, LimitRes = 9, FactoryRes = 10, Arithmetic = 11, DormRoom = 12, DormFurniture = 13, AutoGenerateResource = 14}
eEpEvtChoiceGetNewType = {item = 1, expBuff = 4, chipSwap = 5}
ItemTypeMax = 14
ConstGlobalItem = {PaidItem = 1001, PaidSubItem = 1002, NormalGold = 1003, SKey = 1007, Blitz = 1014, BuildBlueprint = 1500}
eItemQualityType = {White = 1, Green = 2, Blue = 3, Purple = 4, Orange = 5}
ItemQualityColor = {[eItemQualityType.White] = (Color.New)(0.603, 0.603, 0.603, 1), [eItemQualityType.Green] = (Color.New)(0.458, 0.725, 0.364, 1), [eItemQualityType.Blue] = (Color.New)(0, 0.592, 0.862, 1), [eItemQualityType.Purple] = (Color.New)(0.76, 0.333, 0.701, 1), [eItemQualityType.Orange] = (Color.New)(1, 0.517, 0, 1)}
ItemQualitySprite = {[eItemQualityType.White] = "ItemQuailty_1", [eItemQualityType.Green] = "ItemQuailty_2", [eItemQualityType.Blue] = "ItemQuailty_3", [eItemQualityType.Purple] = "ItemQuailty_4", [eItemQualityType.Orange] = "ItemQuailty_5"}
eItemActionType = {HeroExp = 2001, CommanderSkillExp = 3001, HeroCard = 4001, HeroCardFrag = 4002, BuildingAcc = 5001, AthAreaExp = 6001}
eItemAvailableType = {NotUse = 0, Useable = 1, AutoUse = 2}
eChipDetailPowerType = {Add = 1, None = 0, Subtract = -1}
eChipCornerSprite = {[1] = "Corner_0", [2] = "Corner_1", [3] = "Corner_2", [4] = "Corner_3", [5] = "Corner_4", [6] = "Corner_5", [7] = "Corner_6", [8] = "Corner_7", [9] = "Corner_8", [10] = "Corner_9", [11] = "Corner_10", [12] = "Corner_11", [13] = "Corner_12", [14] = "Corner_13"}

