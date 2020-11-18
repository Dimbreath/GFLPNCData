-- params : ...
-- function num : 0 , upvalues : _ENV
local ATHEnum = {}
ATHEnum.eAthQualityType = {White = 1, Blue = 2, Purple = 3, Orange = 4}
ATHEnum.AthQualityColor = {[(ATHEnum.eAthQualityType).White] = (Color.New)(0.75, 0.68, 0.68, 1), [(ATHEnum.eAthQualityType).Blue] = (Color.New)(0.45, 0.58, 0.882, 1), [(ATHEnum.eAthQualityType).Purple] = (Color.New)(0.749, 0.494, 0.803, 1), [(ATHEnum.eAthQualityType).Orange] = (Color.New)(0.956, 0.662, 0.372, 1)}
ATHEnum.eAthColorType = {White = 1, Green = 2, Blue = 3, Purple = 4, Orange = 5}
ATHEnum.AthColor = {[(ATHEnum.eAthColorType).White] = (Color.New)(0.75, 0.68, 0.68, 1), [(ATHEnum.eAthColorType).Green] = (Color.New)(0.458, 0.725, 0.364, 1), [(ATHEnum.eAthColorType).Blue] = (Color.New)(0.45, 0.58, 0.882, 1), [(ATHEnum.eAthColorType).Purple] = (Color.New)(0.749, 0.494, 0.803, 1), [(ATHEnum.eAthColorType).Orange] = (Color.New)(0.956, 0.662, 0.372, 1)}
return ATHEnum

