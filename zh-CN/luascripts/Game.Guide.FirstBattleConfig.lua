-- params : ...
-- function num : 0 , upvalues : _ENV
local FirstBattleConfig = {
    firstBattle1 = {
        formHeroList = {1001, 1003},
        formCSList = {5001},
        csTreeId = 1,
        csGuideDelay = 60,
        guideList = {[1] = 1000, [2] = 1001}
    },
    firstBattle2 = {
        formHeroList = {1001, 1003},
        formHeroPos = {{0, 1}, {0, 3}},
        benchHero = 1005,
        benchHeroOriginPos = 1,
        benchHeroPos = {1, 2},
        introHeroGuideTextId = 136,
        introHeroGuideHeroId = 1001,
        introHeroGuidePos = "2",
        dragGuideTextId = 126,
        guideTalkHeroId = 1001,
        guideTalkPos = "2",
        beforeDragAvg = "cpt00_tutorial_03",
        formCSList = {5001, 5010},
        csTreeId = 1,
        csGuideDelay = 85,
        guideList = {[1] = 1011, [2] = 1012, [3] = 1013}
    }
}
return FirstBattleConfig

