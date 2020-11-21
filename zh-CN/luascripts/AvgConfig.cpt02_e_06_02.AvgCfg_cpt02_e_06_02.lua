-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_06_02 = {
    [1] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg001",
                imgType = 2,
                fullScreen = true
            }, {
                imgId = 13,
                imgPath = "betty_avg",
                imgType = 3,
                pos = {470, 0, 0},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 13,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        audio = {bgm = {cue = "Mus_Story_Funny", sheet = "Music"}}
    },
    [2] = {
        images = {
            {
                imgId = 34,
                imgPath = "abigail_avg",
                imgType = 3,
                pos = {-470, 0, 0},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 34,
                duration = 0.2,
                pos = {-400, 0, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 13, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [3] = {
        imgTween = {
            {imgId = 34, alpha = 0, isDark = false},
            {imgId = 13, alpha = 0, isDark = false}
        },
        content = 30,
        contentType = 2
    },
    [4] = {
        images = {
            {
                imgId = 101,
                imgPath = "dog_avg",
                imgType = 3,
                pos = {0, 0, 0},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {0, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 40,
        contentType = 4,
        speakerName = 31
    },
    [5] = {
        imgTween = {
            {imgId = 34, alpha = 1, isDark = false}, {imgId = 101, alpha = 0}
        },
        content = 50,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [6] = {
        imgTween = {
            {imgId = 34, isDark = true}, {imgId = 13, alpha = 1, isDark = false}
        },
        content = 60,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [8] = {
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [9] = {
        imgTween = {
            {imgId = 13, alpha = 0, isDark = true},
            {imgId = 34, alpha = 0, isDark = true}, {imgId = 101, alpha = 1}
        },
        content = 90,
        contentType = 4,
        speakerName = 31
    },
    [10] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = true},
            {imgId = 34, alpha = 1, isDark = false}, {imgId = 101, alpha = 0}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [11] = {
        content = 110,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [12] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [13] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 130,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [14] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [15] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 150,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [16] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [17] = {
        imgTween = {{imgId = 34, alpha = 0}, {imgId = 13, alpha = 0}},
        content = 170,
        contentType = 2
    },
    [18] = {
        imgTween = {{imgId = 34, alpha = 1}, {imgId = 13, alpha = 1}},
        content = 180,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 190,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [20] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 200,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [21] = {
        imgTween = {{imgId = 34, alpha = 0}, {imgId = 13, alpha = 0}},
        content = 210,
        contentType = 2
    },
    [22] = {
        imgTween = {
            {imgId = 34, alpha = 0, isDark = true},
            {imgId = 13, alpha = 0, isDark = true}, {imgId = 101, alpha = 1}
        },
        content = 220,
        contentType = 4,
        speakerName = 31
    },
    [23] = {
        imgTween = {
            {imgId = 34, alpha = 1, isDark = false},
            {imgId = 13, alpha = 0, isDark = true}, {imgId = 101, alpha = 0}
        },
        content = 230,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [24] = {
        imgTween = {
            {imgId = 34, alpha = 0, isDark = true},
            {imgId = 13, alpha = 0, isDark = true}, {imgId = 101, alpha = 1}
        },
        content = 240,
        contentType = 4,
        speakerName = 31
    },
    [25] = {
        imgTween = {
            {imgId = 13, alpha = 0, isDark = true},
            {imgId = 34, alpha = 1, isDark = false}, {imgId = 101, alpha = 0}
        },
        content = 250,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [26] = {
        content = 260,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [27] = {
        content = 270,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [28] = {
        content = 280,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [29] = {
        imgTween = {
            {imgId = 34, alpha = 0, isDark = true}, {imgId = 13, alpha = 0}
        },
        content = 290,
        contentType = 2
    },
    [30] = {
        imgTween = {
            {imgId = 34, alpha = 0}, {imgId = 13, alpha = 1, isDark = false}
        },
        content = 300,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [31] = {
        imgTween = {{imgId = 13, alpha = 0}, {imgId = 101, alpha = 1}},
        content = 310,
        contentType = 4,
        speakerName = 31
    },
    [32] = {
        imgTween = {
            {imgId = 34, alpha = 1, isDark = false}, {imgId = 101, alpha = 0}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [34] = {
        imgTween = {{imgId = 34, alpha = 0}, {imgId = 101, alpha = 1}},
        content = 340,
        contentType = 4,
        speakerName = 31
    },
    [35] = {
        imgTween = {{imgId = 101, alpha = 0}, {imgId = 34, alpha = 1}},
        content = 350,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [36] = {
        imgTween = {{imgId = 34, alpha = 0}, {imgId = 101, alpha = 1}},
        content = 360,
        contentType = 4,
        speakerName = 31
    },
    [37] = {
        imgTween = {{imgId = 34, alpha = 0}, {imgId = 101, alpha = 0}},
        content = 370,
        contentType = 2
    },
    [38] = {
        imgTween = {{imgId = 34, alpha = 1}},
        content = 380,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [39] = {
        content = 390,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [40] = {
        imgTween = {
            {imgId = 34, alpha = 1, isDark = true},
            {imgId = 13, alpha = 1, isDark = false}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [41] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 410,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [42] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [44] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 440,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [45] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 450,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [46] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 460,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [47] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 470,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [48] = {
        imgTween = {
            {imgId = 13, alpha = 0, isDark = false},
            {imgId = 34, alpha = 0, isDark = false}
        },
        content = 480,
        contentType = 2,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [49] = {
        imgTween = {
            {imgId = 13, alpha = 0, isDark = false},
            {imgId = 34, alpha = 1, isDark = false}
        },
        content = 490,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [50] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = false},
            {imgId = 34, alpha = 1, isDark = true}
        },
        content = 500,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [51] = {
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 510,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [52] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
        content = 520,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [53] = {
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 530,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [54] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
        content = 540,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt02_e_06_02

