-- params : ...
-- function num : 0 , upvalues : _ENV
local ActivityEnum = {}
ActivityEnum.eActivityState = {NotOpen = 1, Open = 2, End = 3}
ActivityEnum.eActivityStageOpen = {LastEnd = 1, Day = 2}
ActivityEnum.eActivityExtraParamType = {HeroPicShow = 1, Live2DShow = 2}
ActivityEnum.eActivityFixedId = {StarUp = 1}
return ActivityEnum

