-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_10_01 = {
    [1] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg003",
                imgType = 2,
                fullScreen = true
            }, {
                imgId = 13,
                imgPath = "betty_avg",
                imgType = 3,
                scale = {-1, 1, 1},
                pos = {-400, 0, 0},
                alpha = 1
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_Funny", sheet = "Music"}}
    },
    [2] = {
        images = {
            {
                imgId = 34,
                imgPath = "abigail_avg",
                imgType = 3,
                pos = {400, 0, 0},
                scale = {-1, 1, 1},
                alpha = 1
            }
        },
        imgTween = {{imgId = 13, isDark = true}},
        content = 20,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [3] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
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
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [9] = {
        imgTween = {{imgId = 13, isDark = false}, {imgId = 34, isDark = true}},
        content = 90,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [10] = {
        imgTween = {{imgId = 34, isDark = false}, {imgId = 13, isDark = true}},
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [11] = {
        imgTween = {
            {imgId = 13, duration = 0.5, pos = {0, 0, 0}, isDark = false},
            {imgId = 34, alpha = 0}
        },
        content = 110,
        contentType = 2
    },
    [12] = {
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        branch = {{content = 121, jumpAct = 13}, {content = 122, jumpAct = 14}}
    },
    [13] = {
        content = 130,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        nextId = 15
    },
    [14] = {
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [15] = {
        images = {
            {
                imgId = 1,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-475, -310, 0},
                scale = {1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 1, pos = {-400, -310, 0}, duration = 0.5, alpha = 1},
            {imgId = 13, alpha = 0}
        },
        content = 150,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [16] = {
        imgTween = {
            {imgId = 1, isDark = true}, {imgId = 34, alpha = 1, isDark = false}
        },
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [17] = {
        imgTween = {
            {
                imgId = 13,
                alpha = 1,
                isDark = false,
                scale = {1, 1, 1},
                pos = {400, 0, 0}
            }, {imgId = 34, alpha = 0}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [18] = {
        imgTween = {{imgId = 13, alpha = 0}, {imgId = 34, alpha = 1}},
        content = 180,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {{imgId = 13, alpha = 1}, {imgId = 34, alpha = 0}},
        content = 190,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [20] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 13, isDark = true}},
        content = 200,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [21] = {
        imgTween = {
            {imgId = 1, isDark = true}, {imgId = 34, alpha = 1, isDark = false},
            {imgId = 13, alpha = 0, isDark = false}
        },
        content = 210,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [22] = {
        content = 220,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [23] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = false}, {imgId = 34, alpha = 0}
        },
        content = 230,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [24] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 13, isDark = true}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {
            {imgId = 1, isDark = true}, {imgId = 34, alpha = 1, isDark = false},
            {imgId = 13, alpha = 0, isDark = false}
        },
        content = 250,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [26] = {
        content = 260,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [27] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 34, alpha = 0}},
        content = 270,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [28] = {
        images = {
            {
                imgId = 2,
                imgPath = "anna_avg",
                imgType = 3,
                pos = {475, -330, 0},
                rot = {0, 180, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 2, duration = 0.5, pos = {400, -330, 0}, alpha = 1},
            {imgId = 1, isDark = true}
        },
        content = 280,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [29] = {
        content = 290,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [30] = {
        content = 300,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3,
        branch = {{content = 301, jumpAct = 31}, {content = 302, jumpAct = 35}}
    },
    [31] = {
        content = 310,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [32] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = false}},
        content = 320,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [33] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 2, isDark = false}},
        content = 330,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = false}},
        content = 340,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        nextId = 39
    },
    [35] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 2, isDark = false}},
        content = 350,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [36] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = false}},
        content = 360,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 2, isDark = false}},
        content = 380,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [39] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = true}},
        content = 390,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [40] = {
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [41] = {
        content = 410,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [42] = {
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [43] = {
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [44] = {
        content = 440,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [45] = {
        content = 450,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [46] = {
        content = 460,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [47] = {
        content = 470,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [48] = {
        images = {
            {
                imgId = 3,
                imgPath = "sol",
                imgType = 3,
                pos = {-345, -400, 0},
                rot = {0, 0, 0},
                scale = {1.45, 1.45, 1.45},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 3, pos = {-270, -400, 0}, duration = 0.5, alpha = 1},
            {imgId = 1, pos = {-475, -310, 0}, duration = 0.3, alpha = 0}
        },
        content = 480,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [49] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 2, isDark = false}},
        content = 490,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [50] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.5,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 3, duration = 0.5, pos = {-345, -400, 0}, alpha = 0},
            {imgId = 2, isDark = true}
        },
        content = 500,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [51] = {
        content = 510,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [52] = {
        imgTween = {
            {imgId = 1, isDark = true},
            {imgId = 2, pos = {475, -330, 0}, duration = 0.1, alpha = 0},
            {imgId = 34, alpha = 1, isDark = false}
        },
        content = 520,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [53] = {
        images = {
            {
                imgId = 106,
                imgPath = "dog_avg",
                imgType = 3,
                pos = {0, 0, 0},
                alpha = 1
            }
        },
        imgTween = {{imgId = 1, alpha = 0}, {imgId = 34, alpha = 0}},
        content = 530,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [54] = {
        imgTween = {
            {imgId = 106, alpha = 0}, {imgId = 34, alpha = 1, isDark = false}
        },
        content = 540,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [55] = {
        content = 550,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [56] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg002",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {
            {imgId = 1, pos = {-475, -310, 0}, alpha = 0},
            {imgId = 34, alpha = 0, isDark = false}
        },
        content = 560,
        contentType = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [57] = {
        imgTween = {
            {
                imgId = 1,
                pos = {-400, -310, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }
        },
        content = 570,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [58] = {
        imgTween = {
            {imgId = 1, isDark = true}, {imgId = 34, alpha = 1, isDark = false}
        },
        content = 580,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [59] = {
        imgTween = {
            {imgId = 1, isDark = true}, {imgId = 13, alpha = 1, isDark = false},
            {imgId = 34, alpha = 0, isDark = false}
        },
        content = 590,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [60] = {
        imgTween = {
            {imgId = 2, pos = {475, -330, 0}, alpha = 0.2},
            {
                imgId = 2,
                pos = {400, -330, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 13, alpha = 0}
        },
        content = 600,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [61] = {
        images = {
            {
                imgId = 10,
                imgPath = "evelyn_avg",
                imgType = 3,
                pos = {350, -400, 0},
                scale = {1.8, 1.8, 1.8},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 2, pos = {475, -330, 0}, duration = 0.5, alpha = 0},
            {imgId = 1, pos = {-475, -310, 0}, duration = 0.5, alpha = 0},
            {imgId = 10, pos = {0, -400, 0}, duration = 4, alpha = 1},
            {imgId = 13, alpha = 0}
        },
        content = 610,
        contentType = 2
    },
    [62] = {
        content = 620,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 2
    },
    [63] = {
        content = 630,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 2
    },
    [64] = {
        content = 640,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 2
    },
    [65] = {
        imgTween = {
            {imgId = 10, pos = {-100, -400, 0}, duration = 0.5, alpha = 0}
        },
        content = 650,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [66] = {
        imgTween = {
            {
                imgId = 1,
                pos = {-400, -310, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }
        },
        content = 660,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [67] = {
        imgTween = {
            {
                imgId = 2,
                pos = {400, -330, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 1, isDark = true}
        },
        content = 670,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt02_e_10_01

