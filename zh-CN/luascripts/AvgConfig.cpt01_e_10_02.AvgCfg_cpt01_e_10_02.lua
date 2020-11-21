-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_10_02 = {
    [1] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt01/cpt01_e_bg004_2",
                imgType = 2,
                order = 97,
                fullScreen = true,
                delete = false
            }, {
                imgId = 101,
                imgPath = "42lab_npc_02_avg",
                imgType = 3,
                pos = {-400, -200, 0},
                rot = {0, 0, 0},
                scale = {1.2, 1.2, 1.2},
                alpha = 1
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [2] = {
        images = {
            {
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
            }, {imgId = 101, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [3] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 30,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [4] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [5] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 50,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [6] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 60,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [7] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 70,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [8] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 80,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [9] = {
        content = 90,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [10] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [11] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [12] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [13] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 130,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [14] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [15] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 150,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [16] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [17] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 170,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [18] = {
        content = 180,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [19] = {
        images = {
            {
                imgId = 6,
                imgPath = "fresnel_avg",
                imgType = 3,
                pos = {-460, -300, 0},
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
            },
            {
                imgId = 101,
                duration = 0.2,
                pos = {-500, -200, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 9, isDark = true}
        },
        content = 190,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [20] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 200,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [21] = {
        imgTween = {{imgId = 6, isDark = false}, {imgId = 9, isDark = true}},
        content = 210,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [22] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 220,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [23] = {
        imgTween = {{imgId = 6, isDark = false}, {imgId = 9, isDark = true}},
        content = 230,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [24] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [25] = {
        imgTween = {{imgId = 6, isDark = false}, {imgId = 9, isDark = true}},
        content = 250,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [26] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 260,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [27] = {
        imgTween = {{imgId = 6, isDark = false}, {imgId = 9, isDark = true}},
        content = 270,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [28] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 280,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [29] = {
        content = 290,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [30] = {
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-460, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 300,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [31] = {
        content = 310,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [32] = {
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 6, isDark = false}, {imgId = 9, isDark = true}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [33] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 330,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {{imgId = 6, isDark = false}, {imgId = 9, isDark = true}},
        content = 340,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {-400, -200, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-460, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 350,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [36] = {
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {-500, -200, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 360,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [37] = {
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {-400, -200, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-460, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 370,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 380,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [39] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 9, isDark = true}},
        content = 390,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [40] = {
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {-500, -200, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 400,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [41] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 410,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [42] = {
        content = 420,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {{imgId = 6, isDark = false}, {imgId = 9, isDark = true}},
        content = 430,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [44] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 440,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    },
    [45] = {
        imgTween = {{imgId = 6, isDark = false}, {imgId = 9, isDark = true}},
        content = 450,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [46] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 6, isDark = true}},
        content = 460,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt01_e_10_02

