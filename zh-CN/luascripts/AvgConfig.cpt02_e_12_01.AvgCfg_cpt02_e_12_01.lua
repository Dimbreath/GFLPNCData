-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_12_01 = {
    [1] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg003",
                imgType = 2,
                fullScreen = true
            }, {
                imgId = 10,
                imgPath = "evelyn_avg",
                imgType = 3,
                pos = {-100, -400, 0},
                rot = {0, 0, 0},
                scale = {1.8, 1.8, 1.8},
                alpha = 0.2
            }
        },
        imgTween = {{imgId = 10, duration = 0.5, pos = {0, -400, 0}, alpha = 1}},
        content = 10,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 2,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}},
        branch = {{content = 11, jumpAct = 2}}
    },
    [2] = {
        content = 20,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 2,
        branch = {{content = 21, jumpAct = 3}}
    },
    [3] = {
        content = 30,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 2,
        branch = {{content = 31, jumpAct = 4}}
    },
    [4] = {
        content = 40,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 2
    },
    [5] = {
        images = {
            {
                imgId = 1,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-475, -310, 0},
                rot = {0, 0, 0},
                scale = {1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 1, duration = 0.5, pos = {-400, -310, 0}, alpha = 1},
            {imgId = 10, duration = 0.5, pos = {350, -400, 0}, isDark = true}
        },
        content = 50,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [6] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 10, isDark = false}},
        content = 60,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 3
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = 1010,
        speakerHeroPosId = 3
    },
    [8] = {
        imgTween = {
            {imgId = 1, pos = {-475, -310, 0}, alpha = 0},
            {imgId = 10, alpha = 0}
        },
        content = 80,
        contentType = 2
    },
    [9] = {
        images = {
            {
                imgId = 4,
                imgPath = "simo",
                imgType = 3,
                order = 11,
                pos = {500, -50, 0},
                scale = {1.15, 1.15, 1.15},
                alpha = 0.2
            }
        },
        imgTween = {{imgId = 4, duration = 0.5, pos = {430, -50, 0}, alpha = 1}},
        content = 90,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [10] = {
        content = 100,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [11] = {
        images = {
            {
                imgId = 3,
                imgPath = "sol",
                imgType = 3,
                order = 10,
                pos = {-345, -400, 0},
                rot = {0, 0, 0},
                scale = {1.45, 1.45, 1.45},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 3, pos = {-270, -400, 0}, duration = 0.5, alpha = 1},
            {imgId = 4, isDark = true}
        },
        content = 110,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [12] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 4, isDark = false}},
        content = 120,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [13] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 3, isDark = false}},
        content = 130,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [14] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 4, isDark = false}},
        content = 140,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [15] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 3, isDark = false}},
        content = 150,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [16] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 4, isDark = false}},
        content = 160,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [17] = {
        images = {
            {
                imgId = 2,
                imgPath = "anna_avg",
                imgType = 3,
                pos = {-475, -330, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 2, duration = 0.2, pos = {-400, -330, 0}, alpha = 1},
            {imgId = 4, isDark = true},
            {imgId = 3, pos = {-345, -400, 0}, duration = 0.2, alpha = 0}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [18] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 4, isDark = false}},
        content = 180,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [19] = {
        content = 190,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [20] = {
        imgTween = {
            {imgId = 2, alpha = 0, pos = {-470, -330, 0}},
            {imgId = 4, pos = {500, -50, 0}, alpha = 0}
        },
        content = 200,
        contentType = 2
    },
    [21] = {
        imgTween = {
            {
                imgId = 1,
                pos = {-400, -310, 0},
                duration = 0.2,
                alpha = 1,
                isDark = false
            }
        },
        content = 210,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        contentShake = true,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [22] = {
        imgTween = {{imgId = 4, pos = {430, -50, 0}, duration = 0.5, alpha = 1}},
        content = 220,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [23] = {
        imgTween = {{imgId = 4, isDark = true}},
        content = 230,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        contentShake = true,
        audio = {bgm = {cue = "Mus_Story_Relax", sheet = "Music"}}
    },
    [24] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 4, isDark = false}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [25] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 1, isDark = false}},
        content = 250,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [26] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 4, isDark = false}},
        content = 260,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [27] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 1, isDark = false}},
        content = 270,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [28] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 4, isDark = false}},
        content = 280,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [29] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 1, isDark = false}},
        content = 290,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 4, isDark = false}},
        content = 300,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [31] = {
        imgTween = {
            {imgId = 1, alpha = 0, pos = {-470, -310, 0}},
            {imgId = 4, alpha = 0, pos = {500, -50, 0}}
        },
        content = 310,
        contentType = 2
    },
    [32] = {
        images = {
            {
                imgId = 101,
                imgPath = "olivia_avg",
                imgType = 3,
                pos = {450, -350, 0},
                rot = {0, 180, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {
            {
                imgId = 3,
                pos = {-270, -400, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 101, isDark = true}
        },
        content = 340,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 101, isDark = false}},
        content = 350,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [36] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 101, isDark = true}},
        content = 360,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [37] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 3, isDark = false}},
        content = 370,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [38] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 101, isDark = true}},
        content = 380,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [39] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 101, isDark = false}},
        content = 390,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [40] = {
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [41] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 101, isDark = true}},
        content = 410,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [42] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 101, isDark = false}},
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {
            {
                imgId = 1,
                pos = {-400, -310, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 3,
                pos = {-470, -400, 0},
                duration = 0.5,
                alpha = 0,
                isDark = false
            }, {imgId = 101, alpha = 0}
        },
        content = 430,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [44] = {
        images = {
            {
                imgId = 13,
                imgPath = "betty_avg",
                imgType = 3,
                pos = {470, 0, 0},
                alpha = 1
            }
        },
        imgTween = {{imgId = 1, isDark = true}},
        content = 440,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [45] = {
        images = {
            {
                imgId = 34,
                imgPath = "abigail_avg",
                imgType = 3,
                pos = {470, 0, 0},
                scale = {-1, 1, 1},
                alpha = 1
            }, {imgId = 13, delete = true}
        },
        content = 450,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [46] = {
        images = {{imgId = 34, delete = true}},
        imgTween = {{imgId = 1, isDark = false}},
        content = 460,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [47] = {
        imgTween = {
            {
                imgId = 2,
                pos = {-400, -330, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 1, pos = {-475, -310, 0}, duration = 0.5, alpha = 0}
        },
        content = 470,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [48] = {
        imgTween = {
            {
                imgId = 3,
                pos = {-270, -400, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 2, pos = {-475, -330, 0}, duration = 0.5, alpha = 0}
        },
        content = 480,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [49] = {
        imgTween = {
            {
                imgId = 1,
                pos = {-400, -310, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 3, pos = {-345, -400, 0}, duration = 0.5, alpha = 0}
        },
        content = 490,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        branch = {{content = 491, jumpAct = 50}, {content = 492, jumpAct = 52}}
    },
    [50] = {
        imgTween = {
            {
                imgId = 3,
                pos = {-270, -400, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 1, pos = {-475, -310, 0}, duration = 0.5, alpha = 0}
        },
        content = 500,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [51] = {
        imgTween = {
            {
                imgId = 4,
                pos = {430, -50, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 3, isDark = true}
        },
        content = 510,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3,
        nextId = 54
    },
    [52] = {
        imgTween = {
            {
                imgId = 2,
                pos = {475, -330, 0},
                rot = {0, 180, 0},
                alpha = 0.2,
                isDark = false
            }, {imgId = 2, pos = {400, -330, 0}, duration = 0.5, alpha = 1},
            {imgId = 1, isDark = true}
        },
        content = 520,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [53] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 2, isDark = true}},
        content = 530,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [54] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg004",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {
            {imgId = 4, pos = {500, -50, 0}, alpha = 0},
            {imgId = 3, pos = {-345, -400, 0}, alpha = 0},
            {imgId = 1, pos = {-475, -310, 0}, alpha = 0},
            {imgId = 2, alpha = 0}
        },
        content = 540,
        contentType = 1,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [55] = {
        images = {
            {
                imgId = 101,
                imgPath = "arrow_avg",
                imgType = 3,
                pos = {450, -350, 0},
                rot = {0, 0, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 550,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        audio = {bgm = {cue = "Mus_Story_Purifier", sheet = "Music"}}
    },
    [56] = {
        images = {
            {
                imgId = 102,
                imgPath = "mara_weapon_avg",
                imgType = 3,
                pos = {-150, -400, 0},
                rot = {0, 0, 0},
                scale = {3.7, 3.7, 3.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 101, duration = 0.2, pos = {450, -350, 0}, alpha = 0}
        },
        content = 560,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [57] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0},
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 570,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [58] = {
        imgTween = {
            {imgId = 1, pos = {-50, -310, 0}, alpha = 0.2},
            {
                imgId = 1,
                pos = {0, -310, 0},
                duration = 0.5,
                alpha = 0.7,
                isDark = false
            }, {imgId = 101, duration = 0.2, pos = {450, -350, 0}, alpha = 0}
        },
        content = 580,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [59] = {
        imgTween = {
            {imgId = 1, pos = {-50, -310, 0}, duration = 0.5, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 590,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [60] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0},
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 600,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [61] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 101, duration = 0.2, pos = {450, -350, 0}, alpha = 0}
        },
        content = 610,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [62] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0},
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 620,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [63] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 101, duration = 0.2, pos = {450, -350, 0}, alpha = 0}
        },
        content = 630,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [64] = {
        imgTween = {
            {imgId = 1, pos = {-20, -310, 0}, alpha = 0},
            {imgId = 1, pos = {0, -310, 0}, duration = 0.2, alpha = 1},
            {imgId = 102, duration = 0.2, alpha = 0}
        },
        content = 640,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2
    },
    [65] = {
        imgTween = {
            {imgId = 1, pos = {-200, -310, 0}, duration = 0.2, alpha = 0},
            {
                imgId = 102,
                duration = 0.5,
                pos = {-100, -400, 0},
                alpha = 1,
                shake = true
            }
        },
        content = 650,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [66] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 660,
        contentType = 2
    },
    [67] = {
        imgTween = {
            {imgId = 4, pos = {100, -50, 0}, alpha = 0.2, isDark = false},
            {imgId = 4, pos = {50, -50, 0}, duration = 0.5, alpha = 1},
            {imgId = 1, pos = {-100, -310, 0}, duration = 0.5, alpha = 0}
        },
        content = 670,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [68] = {
        imgTween = {
            {imgId = 4, duration = 0.5, pos = {100, -50, 0}, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 680,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [69] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0},
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 690,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [70] = {
        imgTween = {
            {imgId = 101, duration = 0.2, pos = {450, -350, 0}, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 700,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [71] = {
        content = 710,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [72] = {
        imgTween = {
            {
                imgId = 1,
                pos = {500, -310, 0},
                rot = {0, 180, 0},
                alpha = 0.2,
                isDark = false
            }, {imgId = 1, pos = {400, -310, 0}, alpha = 1, duration = 0.5},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 720,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [73] = {
        imgTween = {
            {imgId = 1, duration = 0.2, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 730,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [74] = {
        imgTween = {
            {imgId = 1, duration = 0.2, alpha = 1},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 740,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [75] = {
        imgTween = {
            {imgId = 1, duration = 0.2, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 750,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [76] = {
        content = 760,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [77] = {
        imgTween = {
            {imgId = 4, pos = {500, -50, 0}, alpha = 0.2, isDark = false},
            {imgId = 4, pos = {430, -50, 0}, duration = 0.5, alpha = 1},
            {imgId = 1, pos = {500, -310, 0}, duration = 0.5, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 770,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [78] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 780,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [79] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 1},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 790,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [80] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 800,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [81] = {
        imgTween = {
            {
                imgId = 1,
                pos = {400, -310, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 4, pos = {500, -50, 0}, duration = 0.5, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 810,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [82] = {
        imgTween = {
            {imgId = 1, duration = 0.2, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 820,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        branch = {{content = 821, jumpAct = 83}, {content = 822, jumpAct = 84}}
    },
    [83] = {
        content = 830,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        nextId = 85
    },
    [84] = {
        content = 840,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [85] = {
        imgTween = {
            {
                imgId = 4,
                pos = {430, -50, 0},
                duration = 0.3,
                alpha = 1,
                isDark = false
            }, {imgId = 1, pos = {500, -310, 0}, duration = 0.3, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 850,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [86] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 860,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [87] = {
        content = 870,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [88] = {
        imgTween = {
            {imgId = 3, pos = {575, -400, 0}, alpha = 0.2},
            {
                imgId = 3,
                pos = {500, -400, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 4, pos = {500, -50, 0}, duration = 0.5, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 880,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [89] = {
        imgTween = {
            {imgId = 3, pos = {575, -400, 0}, duration = 0.5, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 890,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [90] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 900,
        contentType = 2
    },
    [91] = {
        imgTween = {
            {
                imgId = 4,
                pos = {430, -50, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }
        },
        content = 910,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [92] = {content = 920, contentType = 2},
    [93] = {
        imgTween = {
            {imgId = 4, pos = {1200, -50, 0}, duration = 0.5, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 930,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [94] = {
        imgTween = {
            {imgId = 4, pos = {500, -50, 0}, alpha = 0},
            {
                imgId = 4,
                pos = {430, -50, 0},
                duration = 0.2,
                alpha = 1,
                isDark = false
            }, {imgId = 102, duration = 0.2, alpha = 0}
        },
        content = 940,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [95] = {
        content = 950,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [96] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 960,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [97] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 1},
            {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 970,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [98] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 0},
            {
                imgId = 102,
                duration = 0.2,
                pos = {-100, -400, 0},
                alpha = 1,
                shake = true
            }
        },
        content = 980,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [99] = {
        imgTween = {
            {imgId = 1, pos = {-500, -310, 0}, alpha = 0.2, rot = {0, 0, 0}},
            {
                imgId = 1,
                pos = {-400, -310, 0},
                duration = 0.5,
                alpha = 1,
                isDark = false
            }, {imgId = 102, duration = 0.2, pos = {-200, -400, 0}, alpha = 0}
        },
        content = 990,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [100] = {
        imgTween = {
            {imgId = 1, isDark = true}, {imgId = 4, alpha = 1, isDark = false}
        },
        content = 1000,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [101] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 1, isDark = false}},
        content = 1010,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [102] = {
        imgTween = {
            {imgId = 1, alpha = 0}, {imgId = 4, duration = 0.2, alpha = 0},
            {imgId = 101, pos = {50, -350, 0}, alpha = 0.2},
            {imgId = 101, duration = 0.2, pos = {0, -350, 0}, alpha = 1}
        },
        content = 1020,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    }
}
return AvgCfg_cpt02_e_12_01

