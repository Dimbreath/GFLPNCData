-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_01 = {
    [1] = {
        images = {
            {
                imgId = 1,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 2,
                fullScreen = true
            }
        },
        content = 10,
        contentType = 4,
        speakerName = 11,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [2] = {content = 20, contentType = 4, speakerName = 21},
    [3] = {content = 30, contentType = 2, contentShake = true},
    [4] = {
        images = {
            {
                imgId = 2,
                imgPath = "cpt00/cpt00_e_bg005",
                imgType = 2,
                fullScreen = true,
                alpha = 0
            }, {
                imgId = 3,
                imgPath = "sol",
                imgType = 3,
                pos = {-345, -400, 0},
                scale = {1.45, 1.45, 1.45},
                alpha = 0.1,
                order = 1
            }
        },
        imgTween = {
            {imgId = 2, duration = 0.5, alpha = 1},
            {imgId = 3, duration = 0.5, pos = {-270, -400, 0}, alpha = 1}
        },
        content = 40,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [6] = {
        images = {
            {
                imgId = 4,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {480, -310, 0},
                scale = {-1.7, 1.7, 1.7},
                alpha = 0.1,
                order = 2
            }
        },
        imgTween = {
            {imgId = 3, isDark = true},
            {
                imgId = 4,
                duration = 0.5,
                pos = {400, -310, 0},
                alpha = 1,
                shake = true
            }
        },
        content = 60,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [8] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 4, isDark = true}},
        content = 80,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [9] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 3, isDark = true}},
        content = 90,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [10] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 4, isDark = true}},
        content = 100,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [11] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 3, isDark = true}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [12] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 4, isDark = true}},
        content = 120,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [13] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 4, isDark = true}},
        content = 130,
        contentType = 4,
        speakerName = 131
    },
    [14] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 4, isDark = true}},
        content = 140,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [15] = {
        content = 150,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [16] = {
        images = {
            {
                imgId = 5,
                imgPath = "cpt00/cpt00_e_bg004",
                imgType = 4,
                alpha = 0.5,
                fullScreen = true
            }
        },
        imgTween = {
            {imgId = 5, duration = 2, alpha = 0},
            {imgId = 4, isDark = false, duration = 1, shake = true},
            {imgId = 3, isDark = false, duration = 1, shake = true}
        },
        content = 160,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        branch = {{content = 161, jumpAct = 17}}
    },
    [17] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 3, isDark = true}},
        content = 170,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [18] = {
        content = 180,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 4, isDark = true}},
        content = 190,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [20] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 3, isDark = true}},
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
        imgTween = {{imgId = 3, isDark = false}, {imgId = 4, isDark = true}},
        content = 220,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [23] = {
        content = 230,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    }
}
return AvgCfg_cpt00_e_01_01

