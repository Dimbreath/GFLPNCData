-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_18_02 = {
    [1] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt01/cpt01_e_bg005",
                imgType = 2,
                order = 97,
                fullScreen = true,
                delete = false
            }, {
                imgId = 9,
                imgPath = "mai_avg",
                imgType = 3,
                pos = {450, 100, 0},
                rot = {0, 0, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 9,
                duration = 0.2,
                pos = {350, 100, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [2] = {
        images = {
            {
                imgId = 6,
                imgPath = "fresnel_avg",
                imgType = 3,
                pos = {-465, -300, 0},
                rot = {0, 0, 0},
                scale = {1.2, 1.2, 1.2},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 9, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [3] = {
        imgTween = {
            {imgId = 6, isDark = true},
            {imgId = 9, duration = 0.5, isDark = false, shake = true}
        },
        content = 30,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [4] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 40,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [5] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 50,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [6] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 60,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_Relax", sheet = "Music"}}
    },
    [7] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 70,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [8] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 80,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [9] = {
        content = 90,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [10] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 100,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [11] = {
        content = 110,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [12] = {
        content = 120,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [13] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 130,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [14] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 140,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [15] = {
        content = 150,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [16] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 160,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [17] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 170,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [18] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 180,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [19] = {
        content = 190,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [20] = {
        content = 200,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [22] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 220,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [23] = {
        content = 230,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [24] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 250,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [26] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 260,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 270,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [28] = {
        imgTween = {{imgId = 6, alpha = 0}, {imgId = 9, alpha = 0}},
        content = 280,
        contentType = 2
    },
    [29] = {
        imgTween = {
            {imgId = 9, alpha = 1, isDark = true},
            {imgId = 6, alpha = 1, isDark = false}
        },
        content = 290,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 300,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [31] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 310,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [32] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 320,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [33] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 330,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [34] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 340,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [35] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 350,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [36] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 360,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [37] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 370,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 9, isDark = false}},
        content = 380,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [39] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 6, isDark = false}},
        content = 390,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [40] = {
        content = 400,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    }
}
return AvgCfg_cpt01_e_18_02

