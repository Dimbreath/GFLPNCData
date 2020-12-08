-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationEnum = {}
ExplorationEnum.eRoomType = {deploy = -1, start = 0, boss = 1, empty = 2, enemy = 3, item = 4, store = 5, elite = 6, challenge = 7, eventroom = 8, recovery = 9, chip = 10}
ExplorationEnum.RoomTypeColor = {[(ExplorationEnum.eRoomType).start] = (Color.New)(0.913, 0.556, 0.043, 1), [(ExplorationEnum.eRoomType).boss] = (Color.New)(0.952, 0.156, 0.294, 1), [(ExplorationEnum.eRoomType).empty] = (Color.New)(0.15, 0.95, 0.48, 1), [(ExplorationEnum.eRoomType).enemy] = (Color.New)(0.86, 0.85, 0.863, 1), [(ExplorationEnum.eRoomType).item] = (Color.New)(0.906, 0.78, 0.345, 1), [(ExplorationEnum.eRoomType).store] = (Color.New)(0.306, 0.725, 0.902, 1), [(ExplorationEnum.eRoomType).elite] = (Color.New)(0.972, 0.412, 0.863, 1), [(ExplorationEnum.eRoomType).challenge] = (Color.New)(0.607, 0.219, 0.89, 1), [(ExplorationEnum.eRoomType).eventroom] = (Color.New)(0.902, 0.482, 0.306, 1), [(ExplorationEnum.eRoomType).recovery] = (Color.New)(0.792, 0.902, 0.306, 1), [(ExplorationEnum.eRoomType).chip] = (Color.New)(0.24, 0.706, 0.66, 1)}
ExplorationEnum.eRoomTypeState = {None = 0, Complete = 1, CurrentStay = 2, AbleChoose = 3, UnReachable = 4}
ExplorationEnum.eTrackLineType = {NormalYTrack = 0, NormalETrack = 1, ReverseETrack = 2, SingleTrack = 3, EndTrack = 4}
ExplorationEnum.eTrackLineState = {Normal = 0, Pass = 1, Auto = 2}
ExplorationEnum.LineAutoModeColor = Color.white
ExplorationEnum.eBattleSkillType = {Original = 0, Chip = 1, BattleBuff = 2, TempChip = 3, AthSuit = 4}
ExplorationEnum.eHeroHpPercent = 10000
ExplorationEnum.eEventRoomType = {Recovery = 1, Event = 2}
ExplorationEnum.eEventRoomChoiceType = {Normal = 1, Random = 2, Upgrade = 3, Jump = 4}
ExplorationEnum.eChoiceConditionType = {NotRequired = 0, Required = 1, NotRequiredAtLeastOne = 2}
ExplorationEnum.eResetRoomType = {Duplicate = 1, Mix = 2, reconstitution = 3}
ExplorationEnum.eExitRoomCompleteType = {EventRoom = 1, BattleToEp = 2, StoreRoom = 3, TreasureRoom = 4, OutsideSelectChip = 5, DiscardChip = 6, ResetRoom = 7, JumpRoomComplete = 8}
ExplorationEnum.eAutoEventChoiceType = {AllRoleHpLess = 1, OneRoleHpLess = 2, HasItemCount = 3}
ExplorationEnum.eAutoTitleType = {Normal = 0, SelectRoom = 1, ExitRoom = 2, UpgradeChip = 3, DiscardChip = 4}
ExplorationEnum.EnemyRoleType = {monster = 1, neutral = 2}
ExplorationEnum.UnReachableAlpha = 0.2
return ExplorationEnum

