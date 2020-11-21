-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_08_01 = {
    [1] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg002",
                imgType = 2,
                fullScreen = true
            }
        },
        content = 10,
        contentType = 1,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [2] = {
        images = {
            {
                imgId = 3,
                imgPath = "sol",
                imgType = 3,
                pos = {-50, -400, 0},
                scale = {1.45, 1.45, 1.45},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {0, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [3] = {
        images = {
            {
                imgId = 1,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-50, -310, 0},
                scale = {1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 1,
                duration = 0.5,
                pos = {0, -310, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 3, alpha = 0}
        },
        content = 30,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [4] = {
        imgTween = {
            {imgId = 1, duration = 0.5, pos = {-50, -310, 0}, alpha = 0}
        },
        content = 40,
        contentType = 2
    },
    [5] = {
        imgTween = {
            {imgId = 3, pos = {-100, -400, 0}, alpha = 0.2},
            {imgId = 3, pos = {0, -400, 0}, duration = 0.5, alpha = 1}
        },
        content = 50,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2
    },
    [6] = {
        content = 60,
        contentType = 3,
        contentShake = true,
        speakerHeroId = -1
    },
    [7] = {
        content = 70,
        contentType = 3,
        contentShake = true,
        speakerHeroId = 1003,
        speakerHeroPosId = 2
    },
    [8] = {
        images = {
            {
                imgId = 2,
                imgPath = "anna_avg",
                imgType = 3,
                pos = {-50, -330, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 2, duration = 0.5, pos = {0, -330, 0}, alpha = 1},
            {imgId = 3, alpha = 0}
        },
        content = 80,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 2
    },
    [9] = {
        content = 90,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 2
    },
    [10] = {imgTween = {{imgId = 2, alpha = 0}}, content = 100, contentType = 2},
    [11] = {
        imgTween = {{imgId = 1, pos = {0, -310, 0}, alpha = 1}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [12] = {
        imgTween = {{imgId = 1, alpha = 0}, {imgId = 3, alpha = 1}},
        content = 120,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2
    },
    [13] = {imgTween = {{imgId = 3, alpha = 0}}, content = 130, contentType = 2},
    [14] = {
        images = {
            {
                imgId = 8,
                imgPath = "cpt02/cpt02_e_bg003",
                imgType = 2,
                alpha = 0,
                fullScreen = true
            }, {
                imgId = 97,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 4,
                fullScreen = true,
                alpha = 0
            }
        },
        imgTween = {
            {imgId = 1, delay = 0.5, alpha = 1},
            {imgId = 97, duration = 0.5, alpha = 1},
            {imgId = 97, delay = 0.5, duration = 0.5, alpha = 0},
            {imgId = 9, delay = 0.5, alpha = 0},
            {imgId = 8, delay = 0.5, alpha = 1}
        },
        content = 140,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [15] = {
        images = {{imgId = 97, delete = true}, {imgId = 9, delete = true}},
        imgTween = {{imgId = 1, alpha = 0}},
        content = 150,
        contentType = 2,
        contentShake = true,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [16] = {content = 160, contentType = 2, contentShake = true},
    [17] = {
        imgTween = {
            {imgId = 3, alpha = 0.2, pos = {-345, -400, 0}},
            {imgId = 3, alpha = 1, pos = {-270, -400, 0}}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [18] = {
        imgTween = {
            {imgId = 3, isDark = true},
            {imgId = 2, pos = {475, -330, 0}, rot = {0, 180, 0}, alpha = 0.2},
            {imgId = 2, pos = {400, -330, 0}, duration = 0.5, alpha = 1}
        },
        content = 180,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {{imgId = 3, alpha = 0}, {imgId = 2, alpha = 0}},
        content = 190,
        contentType = 2
    },
    [20] = {
        imgTween = {{imgId = 3, alpha = 1, isDark = false}},
        content = 200,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_Relax", sheet = "Music"}}
    },
    [21] = {
        imgTween = {
            {imgId = 3, isDark = true}, {imgId = 2, alpha = 1, isDark = false}
        },
        content = 210,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [22] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 3, isDark = false}},
        content = 220,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [23] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 2, isDark = false}},
        content = 230,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [24] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 3, isDark = false}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 2, isDark = false}},
        content = 250,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [26] = {
        imgTween = {
            {imgId = 3, alpha = 0}, {imgId = 2, alpha = 0},
            {imgId = 1, pos = {0, -310, 0}, alpha = 1}
        },
        content = 260,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [27] = {imgTween = {{imgId = 1, alpha = 0}}, content = 270, contentType = 2},
    [28] = {
        imgTween = {{imgId = 3, alpha = 1, isDark = false}},
        content = 280,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [29] = {
        images = {
            {
                imgId = 111,
                imgPath = "cyclopes_npc_01_avg",
                imgType = 3,
                pos = {400, 0, 0},
                scale = {-1, 1, 1},
                alpha = 1
            }
        },
        imgTween = {{imgId = 3, isDark = true}},
        content = 290,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [30] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 111, isDark = true}},
        content = 300,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [31] = {
        imgTween = {
            {imgId = 1, alpha = 1, pos = {-400, -310, 0}, isDark = false},
            {imgId = 3, alpha = 0}, {imgId = 111, alpha = 0}
        },
        content = 310,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [32] = {
        imgTween = {
            {imgId = 2, alpha = 1, isDark = false}, {imgId = 1, isDark = true}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 2, isDark = true}},
        content = 340,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 1, isDark = true}},
        content = 350,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [36] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 2, isDark = true}},
        content = 360,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [37] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false}, {imgId = 1, alpha = 0}
        },
        content = 370,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {{imgId = 3, alpha = 0}, {imgId = 2, alpha = 0}},
        content = 380,
        contentType = 2
    },
    [39] = {
        imgTween = {{imgId = 1, alpha = 1}},
        content = 390,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [40] = {
        imgTween = {
            {imgId = 1, isDark = true}, {imgId = 2, alpha = 1, isDark = false}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [41] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = false}},
        content = 410,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [42] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 2, isDark = false}},
        content = 420,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 1, isDark = false}},
        content = 430,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [44] = {
        content = 440,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [45] = {
        images = {
            {
                imgId = 5,
                imgPath = "croque_avg",
                imgType = 3,
                pos = {450, -300, 0},
                scale = {1.55, 1.55, 1.55},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 5, duration = 0.5, pos = {380, -300, 0}, alpha = 1},
            {imgId = 1, isDark = true}, {imgId = 2, alpha = 0}
        },
        content = 450,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [46] = {
        content = 460,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [47] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 5, isDark = true}},
        content = 470,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [48] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 1, isDark = true}},
        content = 480,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [49] = {
        content = 490,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3,
        branch = {{content = 491, jumpAct = 50}}
    },
    [50] = {
        content = 500,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [51] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 5, isDark = true}},
        content = 510,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [52] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 1, isDark = true}},
        content = 520,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [53] = {
        imgTween = {
            {imgId = 1, isDark = false, duration = 1, pos = {0, -310, 0}},
            {
                imgId = 5,
                duration = 1,
                pos = {1000, -300, 0},
                alpha = 0,
                isDark = true
            }
        },
        content = 530,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [54] = {
        content = 540,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [55] = {
        imgTween = {
            {imgId = 3, isDark = false, pos = {-100, -400, 0}, alpha = 0.2},
            {imgId = 3, duration = 0.2, pos = {0, -400, 0}, alpha = 1},
            {imgId = 1, alpha = 0}
        },
        content = 550,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2
    },
    [56] = {
        content = 560,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2,
        contentShake = true,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [57] = {imgTween = {{imgId = 3, alpha = 0}}, content = 570, contentType = 2},
    [58] = {
        content = 580,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [59] = {
        content = 590,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [60] = {
        content = 600,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [61] = {
        content = 610,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [62] = {
        imgTween = {{imgId = 3, alpha = 1}},
        content = 620,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [63] = {
        images = {
            {
                imgId = 34,
                imgPath = "abigail_avg",
                imgType = 3,
                pos = {470, 0, 0},
                scale = {-1, 1, 1},
                alpha = 1
            }, {
                imgId = 13,
                imgPath = "betty_avg",
                imgType = 3,
                scale = {-1, 1, 1},
                pos = {-470, 0, 0},
                alpha = 1
            }
        },
        imgTween = {
            {imgId = 3, alpha = 0}, {imgId = 13, duration = 1, shake = true},
            {imgId = 34, duration = 1, shake = true}
        },
        content = 630,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [64] = {
        imgTween = {
            {imgId = 3, alpha = 1}, {imgId = 13, alpha = 0},
            {imgId = 34, alpha = 0}
        },
        content = 640,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [65] = {
        imgTween = {{imgId = 3, alpha = 0}, {imgId = 34, alpha = 1}},
        content = 650,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        audio = {bgm = {cue = "Mus_Story_Funny", sheet = "Music"}}
    },
    [66] = {
        content = 660,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [67] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = false}, {imgId = 34, isDark = true}
        },
        content = 670,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [68] = {
        imgTween = {
            {imgId = 1, alpha = 1, isDark = false},
            {imgId = 13, alpha = 0, isDark = false},
            {imgId = 34, alpha = 0, isDark = false}
        },
        content = 680,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [69] = {
        imgTween = {
            {imgId = 1, alpha = 0}, {imgId = 34, alpha = 1, isDark = false}
        },
        content = 690,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [70] = {
        imgTween = {
            {imgId = 13, alpha = 1, isDark = false},
            {imgId = 34, alpha = 1, isDark = true}
        },
        content = 700,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [71] = {
        imgTween = {
            {imgId = 3, alpha = 1}, {imgId = 13, alpha = 0},
            {imgId = 34, alpha = 0}
        },
        content = 710,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2
    },
    [72] = {
        imgTween = {
            {imgId = 2, alpha = 0}, {imgId = 1, alpha = 1},
            {imgId = 3, alpha = 0}
        },
        content = 720,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    }
}
return AvgCfg_cpt02_e_08_01

