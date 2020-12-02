-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeEnum = {}
HomeEnum.eHomeState = {None = 0, Normal = 1, ShowHero = 2, Hided = 3, Covered = 4}
HomeEnum.eHomeTogType = {HumanResource = 1, ControlCenter = 2, Infrastructure = 3}
HomeEnum.eHomeTogTypeOrder = {[1] = (HomeEnum.eHomeTogType).HumanResource, [2] = (HomeEnum.eHomeTogType).ControlCenter, [3] = (HomeEnum.eHomeTogType).Infrastructure}
HomeEnum.eChangeBtnType = {HeroData = 1, Oasis = 2}
HomeEnum.eNoticeType = {Mail = 1, Achievement = 2, OasisBuildingFinish = 3, SectorBuildingFinish = 4, ResourceGenerateOverflow = 5, HasOasisBuildingOperate = 6, HasSectorBuildingOperate = 7, FragDungeonRefresh = 8, ResDungeonRefresh = 9, ATHDungeonRefresh = 10}
return HomeEnum

