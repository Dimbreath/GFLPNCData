-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_14_02 = {
    [1] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg004",
                imgType = 2,
                fullScreen = true
            }, {
                imgId = 13,
                imgPath = "betty_avg",
                imgType = 3,
                scale = {-1, 1, 1},
                pos = {-470, 0, 0},
                alpha = 0.2,
                isDark = false
            }, {
                imgId = 34,
                imgPath = "abigail_avg",
                imgType = 3,
                pos = {470, 0, 0},
                scale = {-1, 1, 1},
                alpha = 0.2,
                isDark = true
            }
        },
        imgTween = {
            {
                imgId = 13,
                duration = 0.2,
                pos = {-400, 0, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 34,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = true
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [2] = {
        content = 20,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [3] = {
        content = 30,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [4] = {
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [5] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
        content = 50,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [6] = {
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 60,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [7] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
        content = 70,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [8] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {
            {
                imgId = 13,
                duration = 0.2,
                pos = {-470, 0, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 34,
                duration = 0.2,
                pos = {470, 0, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 80,
        contentType = 2
    },
    [9] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg004",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {
            {
                imgId = 13,
                duration = 0.2,
                pos = {-400, 0, 0},
                alpha = 1,
                isDark = true
            },
            {
                imgId = 34,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 90,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [10] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [11] = {
        imgTween = {{imgId = 13, alpha = 0}, {imgId = 34, alpha = 0}},
        content = 110,
        contentType = 4,
        speakerName = 111
    },
    [12] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = false},
            {imgId = 34, alpha = 1, isDark = true}
        },
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [13] = {
        imgTween = {{imgId = 13, alpha = 0}, {imgId = 34, alpha = 0}},
        content = 130,
        contentType = 2,
        contentShake = true
    },
    [14] = {
        imgTween = {
            {imgId = 13, alpha = 0}, {imgId = 34, alpha = 1, isDark = false}
        },
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [15] = {
        images = {
            {
                imgId = 106,
                imgPath = "dog_avg",
                imgType = 3,
                pos = {0, 0, 0},
                alpha = 1
            }
        },
        imgTween = {{imgId = 34, alpha = 0}},
        content = 150,
        contentType = 4,
        speakerName = 151,
        contentShake = true
    },
    [16] = {
        imgTween = {{imgId = 106, alpha = 0}},
        content = 160,
        contentType = 2
    },
    [17] = {
        content = 170,
        contentType = 4,
        speakerName = 171,
        contentShake = true
    },
    [18] = {content = 180, contentType = 2},
    [19] = {
        imgTween = {{imgId = 34, alpha = 1}},
        content = 190,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [20] = {
        imgTween = {{imgId = 34, alpha = 0}},
        content = 200,
        contentType = 2
    },
    [21] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = false}, {imgId = 34, alpha = 0}
        },
        content = 210,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [22] = {
        imgTween = {
            {imgId = 13, duration = 0.5, shake = true, isDark = false},
            {
                imgId = 13,
                delay = 0.5,
                duration = 0.2,
                pos = {-300, 0, 0},
                alpha = 0
            }
        },
        content = 220,
        contentType = 2
    },
    [23] = {content = 230, contentType = 2},
    [24] = {
        imgTween = {
            {
                imgId = 13,
                duration = 0.1,
                pos = {-400, 0, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 34, alpha = 1, isDark = true}
        },
        content = 240,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 250,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [26] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
        content = 260,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 270,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [28] = {
        imgTween = {{imgId = 34, alpha = 0}, {imgId = 13, alpha = 0}},
        content = 280,
        contentType = 2
    },
    [29] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = true},
            {imgId = 34, alpha = 1, isDark = false}
        },
        content = 290,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [30] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 300,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [31] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 310,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [32] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 320,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [33] = {
        imgTween = {{imgId = 13, isDark = true}, {imgId = 34, isDark = false}},
        content = 330,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {{imgId = 34, isDark = true}, {imgId = 13, isDark = false}},
        content = 340,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {{imgId = 34, alpha = 0}, {imgId = 13, alpha = 0}},
        content = 350,
        contentType = 2
    },
    [36] = {
        images = {
            {
                imgId = 5,
                imgPath = "croque_avg",
                imgType = 3,
                pos = {0, -200, 0},
                rot = {0, 0, 0},
                scale = {1.55, 1.55, 1.55},
                alpha = 0
            }
        },
        imgTween = {
            {
                imgId = 5,
                duration = 0.5,
                delay = 1,
                pos = {0, -300, 0},
                alpha = 1
            }, {imgId = 9, duration = 1, shake = true}
        },
        content = 360,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 2
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 2
    },
    [38] = {
        imgTween = {
            {imgId = 5, alpha = 0}, {imgId = 34, alpha = 1, isDark = false}
        },
        content = 380,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [39] = {
        imgTween = {
            {imgId = 34, alpha = 0}, {imgId = 5, alpha = 1, isDark = false}
        },
        content = 390,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 2
    },
    [40] = {
        imgTween = {{imgId = 5, duration = 0.5, pos = {0, -200, 0}, alpha = 0}},
        content = 400,
        contentType = 2
    },
    [41] = {
        imgTween = {
            {imgId = 9, duration = 1.5, shake = true},
            {imgId = 5, pos = {0, -300, 0}, delay = 1.5, alpha = 1}
        },
        content = 410,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 2
    },
    [42] = {
        imgTween = {
            {imgId = 5, duration = 0.5, pos = {0, -200, 0}, alpha = 0},
            {imgId = 13, alpha = 1, isDark = false}
        },
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [43] = {
        imgTween = {
            {imgId = 13, isDark = true}, {imgId = 34, alpha = 1, isDark = false}
        },
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [44] = {
        content = 440,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [45] = {
        imgTween = {
            {imgId = 13, alpha = 0}, {imgId = 34, alpha = 0},
            {imgId = 106, alpha = 1}
        },
        content = 450,
        contentType = 4,
        speakerName = 151
    }
}
return AvgCfg_cpt02_e_14_02

