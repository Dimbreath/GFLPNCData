local ActivityFrameEnum = {}
ActivityFrameEnum.eActivityState = {Locked = 1, Wait2Open = 2, Opening = 3, Closed = 4, Destroied = 5}
ActivityFrameEnum.eActivityType = {BattlePass = 1, StarUp = 2, SevenDayLogin = 4, Lotter = 5, Tickets = 6, dailySignIn = "dailySignIn"}
ActivityFrameEnum.eActivityLiftType = {FixedTime = 1, ServerTime = 2, RoleTime = 3}
ActivityFrameEnum.eActivityEnterType = {LimitTime = 1, Novice = 2}
ActivityFrameEnum.eActivityEnterTypePriority = {[1] = (ActivityFrameEnum.eActivityEnterType).LimitTime, [2] = (ActivityFrameEnum.eActivityEnterType).Novice}
ActivityFrameEnum.eActivityUIType = {StarUp = 1, BattlePass = 2, EventGrowBag = 3, SevenDayLogin = 4, Tickets = 5, dailySignIn = "dailySignIn"}
ActivityFrameEnum.eActiveityFakeId = {dailySignIn = 999999, Tickets = 6001}
return ActivityFrameEnum

