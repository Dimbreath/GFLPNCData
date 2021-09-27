local LotteryEnum = {}
LotteryEnum.eLotteryPoolType = {NoPaid = 0, Paid = 1}
LotteryEnum.eLotteryState = {None = 0, Normal = 1, WaitStartShow = 2, LotteryAnimation = 3, PoolDetail = 4}
LotteryEnum.eLtrExecType = {Once = 1, Ten = 2, SpecialOnce = 3, FreeChoice = 4}
return LotteryEnum

