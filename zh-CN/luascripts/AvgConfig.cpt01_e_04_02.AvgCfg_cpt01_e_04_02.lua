-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_04_02 = {
    [1] = {
        images = {
            {
                imgId = 1,
                imgPath = "cpt01/cpt01_e_bg002",
                imgType = 2,
                fullScreen = true
            }, {
                imgId = 2,
                imgPath = "turing",
                imgType = 3,
                pos = {-475, -330, 0},
                scale = {-1.2, 1.2, 1.2},
                alpha = 0
            }, {
                imgId = 3,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {475, -310, 0},
                scale = {-1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 2, duration = 0.6, pos = {-400, -330, 0}, alpha = 1},
            {imgId = 3, duration = 0.6, pos = {400, -310, 0}, alpha = 1}
        },
        content = 10,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [2] = {
        content = 20,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [3] = {
        content = 30,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [4] = {
        imgTween = {{imgId = 2, isDark = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        audio = {bgm = {cue = "Mus_Story_Funny", sheet = "Music"}}
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [6] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 60,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [7] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 70,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [8] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [9] = {
        content = 90,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [10] = {
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [11] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [12] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [13] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 130,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [14] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [15] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 150,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        branch = {{content = 151, jumpAct = 16}, {content = 152, jumpAct = 19}}
    },
    [16] = {
        content = 160,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [17] = {
        content = 170,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [18] = {
        content = 180,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        nextId = 22
    },
    [19] = {
        content = 190,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [20] = {
        content = 200,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [22] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 220,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [23] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 230,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt01_e_04_02

