-- params : ...
-- function num : 0 , upvalues : _ENV
local LotteryEnum = {}
LotteryEnum.eLotteryPoolType = {NoPaid = 0, Paid = 1}
LotteryEnum.eLotteryState = {None = 0, Normal = 1, WaitStartShow = 2, LotteryAnimation = 3, PoolDetail = 4}
return LotteryEnum

-- params : ...
-- function num : 0 , upvalues : _ENV
local LotteryEnum = {}
LotteryEnum.eLotteryPoolType = {NoPaid = 0, Paid = 1}
LotteryEnum.eLotteryState = {
    None = 0,
    Normal = 1,
    WaitStartShow = 2,
    LotteryAnimation = 3,
    PoolDetail = 4
}
return LotteryEnum

