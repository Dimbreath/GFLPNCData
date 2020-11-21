-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_tutorial_09 = {
    [1] = {
        images = {
            {
                imgId = 1,
                imgPath = "sol",
                imgType = 3,
                pos = {575, -400, 0},
                scale = {1.45, 1.45, 1.45},
                alpha = 0.1
            }
        },
        imgTween = {
            {imgId = 1, duration = 0.5, pos = {500, -400, 0}, alpha = 1}
        },
        content = 10,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [2] = {
        images = {
            {
                imgId = 2,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-475, -310, 0},
                scale = {1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 2, duration = 0.5, pos = {-400, -310, 0}, alpha = 1},
            {imgId = 1, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [3] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = false}},
        content = 30,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [4] = {
        content = 40,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [5] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 2, isDark = false}},
        content = 50,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [6] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = false}},
        content = 60,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt00_tutorial_09

