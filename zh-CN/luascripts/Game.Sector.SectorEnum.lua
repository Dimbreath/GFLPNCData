-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorEnum = {}
SectorEnum.eSectorAchivState = {Normal = 1, Completed = 2, Picked = 3}
SectorEnum.eSectorMentionId = {
    None = 0,
    MaterialDungeonId = 11,
    FriendshipDungeonId = 12
}
return SectorEnum

