local DormEnum = {}
DormEnum.eDormState = {None = 0, House = 1, HouseEdit = 2, Room = 3, RoomEdit = 4, Room2House = 5, House2Room = 6}
DormEnum.eDormFntType = {FloorDecoration = 1, WallDecoration = 2, Furniture = 3, Wall = 4, Floor = 5, Door = 6}
DormEnum.eDormFntCategory = {Wall = 1, Floor = 4}
DormEnum.CharInteractState = {None = 0, Fnt = 1, WaitExit = 2, Talk = 3, LeaveDoor = 4, Greet = 5}
DormEnum.CharacterAIEventId = {None = 0, ExitState = 1, StartFntInteract = 101, ExitFntInteract = 102}
DormEnum.DormAnimatorNormalName = "StandWalk"
DormEnum.DormShadowDistance = 14
return DormEnum

