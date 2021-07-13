-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskEnum = {}
TaskEnum.eTaskType = {MainTask = 1, SideTask = 2, DailyTask = 4, WeeklyTask = 5, SectorTask = 300, Achievement = 600, AvgTask = 7, SpecialTask = 8, heroTrainTask = 10}
TaskEnum.eTaskPeriodType = {DailyTask = 1, WeeklyTask = 2}
TaskEnum.eTaskState = {InProgress = 1, Completed = 2, Picked = 3}
TaskEnum.eSpecialType = {FirstBattleGuide1 = 1, FirstBattleGuide2 = 2}
TaskEnum.HomeTaskRewardOthers = {(TaskEnum.eTaskType).SideTask, (TaskEnum.eTaskType).WeeklyTask, (TaskEnum.eTaskType).DailyTask}
return TaskEnum

