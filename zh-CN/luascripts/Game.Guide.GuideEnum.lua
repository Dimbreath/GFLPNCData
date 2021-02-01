-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideEnum = {}
GuideEnum.StepType = {LargeDialog = 0, Operate = 1, Avg = 2, Code = 3, HeroSmallTalk = 4, Highlight = 5}
GuideEnum.GuideType = {NormalGuide = 0, TipsGuide = 1}
GuideEnum.TipsGuideType = {Normal = 0, Code = 1}
GuideEnum.TriggerGuideCondition = {FuncUnlock = 1, HasItem = 2, SectorStage = 3, HeroLevelGreater = 4}
return GuideEnum

