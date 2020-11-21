-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_04_01 = {
    [1] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 2,
                order = 50,
                fullScreen = true
            }, {
                imgId = 98,
                imgPath = "cpt01/cpt01_e_bg002",
                imgType = 2,
                order = 49,
                fullScreen = true
            }
        },
        content = 10,
        contentType = 2,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [2] = {content = 20, contentType = 3, speakerHeroId = -1},
    [3] = {
        content = 30,
        contentType = 3,
        speakerHeroId = -1,
        branch = {{content = 31, jumpAct = 4}}
    },
    [4] = {
        images = {
            {
                imgId = 2,
                imgPath = "turing",
                imgType = 3,
                pos = {0, -330, 0},
                scale = {-1.2, 1.2, 1.2},
                alpha = 0
            }
        },
        imgTween = {
            {imgId = 99, duration = 1.5, alpha = 0},
            {imgId = 2, delay = 1.6, duration = 0.5, alpha = 1}
        },
        content = 40,
        contentType = 3,
        speakerHeroId = -1,
        branch = {{content = 41, jumpAct = 5}},
        audio = {bgm = {cue = "Mus_Story_Relax", sheet = "Music"}}
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = -1,
        branch = {{content = 51, jumpAct = 6}}
    },
    [6] = {
        content = 60,
        contentType = 3,
        speakerHeroId = -1,
        branch = {{content = 61, jumpAct = 7}}
    },
    [7] = {content = 70, contentType = 3, speakerHeroId = -1},
    [8] = {
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        branch = {{content = 81, jumpAct = 9}}
    },
    [9] = {content = 90, contentType = 3, speakerHeroId = -1},
    [10] = {
        images = {
            {
                imgId = 101,
                imgPath = "42lab_npc_01_avg",
                imgType = 3,
                pos = {450, -200, 0},
                rot = {0, 0, 0},
                scale = {1.2, 1.2, 1.2},
                alpha = 0
            }
        },
        imgTween = {
            {
                imgId = 2,
                duration = 0.5,
                pos = {-400, -330, 0},
                alpha = 1,
                isDark = true
            }, {imgId = 101, duration = 0.2, pos = {400, -200, 0}, alpha = 1}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [11] = {
        imgTween = {{imgId = 101, isDark = true}, {imgId = 2, isDark = false}},
        content = 110,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [12] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 101, isDark = false}},
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [13] = {
        imgTween = {{imgId = 101, isDark = true}, {imgId = 2, isDark = false}},
        content = 130,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [14] = {
        images = {
            {
                imgId = 4,
                imgPath = "sol",
                imgType = 3,
                scale = {1.45, 1.45, 1.45},
                pos = {575, -400, 0},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 4, duration = 0.6, pos = {500, -400, 0}, alpha = 1},
            {imgId = 2, isDark = true}, {imgId = 101, alpha = 0}
        },
        content = 140,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [15] = {
        content = 150,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [16] = {
        imgTween = {
            {imgId = 4, alpha = 0, isDark = false},
            {imgId = 2, alpha = 0, isDark = false}
        },
        content = 160,
        contentType = 2
    },
    [17] = {
        imgTween = {
            {imgId = 4, alpha = 1, isDark = true},
            {imgId = 2, alpha = 1, isDark = false}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [18] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 4, isDark = false}},
        content = 180,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [19] = {
        images = {
            {
                imgId = 97,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 4,
                fullScreen = true,
                alpha = 0
            }
        },
        imgTween = {
            {imgId = 97, duration = 0.5, alpha = 1},
            {imgId = 97, delay = 0.5, duration = 0.5, alpha = 0},
            {imgId = 2, alpha = 0, isDark = false}
        },
        content = 190,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [20] = {
        images = {
            {
                imgId = 3,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-475, -310, 0},
                scale = {1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 3, duration = 0.6, pos = {-400, -310, 0}, alpha = 1},
            {imgId = 4, isDark = true}
        },
        content = 200,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        branch = {{content = 201, jumpAct = 21}}
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [22] = {
        content = 220,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        branch = {{content = 221, jumpAct = 23}}
    },
    [23] = {
        content = 230,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [24] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 4, isDark = false}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [25] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 3, isDark = false}},
        content = 250,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [26] = {
        imgTween = {
            {imgId = 3, duration = 0.2, pos = {-470, -310, 0}, alpha = 0},
            {imgId = 2, pos = {-475, -330, 0}, alpha = 0},
            {imgId = 2, duration = 0.2, pos = {-400, -330, 0}, alpha = 1}
        },
        content = 260,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {
            {imgId = 4, duration = 0.2, alpha = 0}, {
                imgId = 3,
                pos = {475, -310, 0},
                scale = {-1.7, 1.7, 1.7},
                alpha = 0,
                isDark = false
            }, {imgId = 3, duration = 0.2, pos = {400, -310, 0}, alpha = 1},
            {imgId = 2, isDark = true}
        },
        content = 270,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [28] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 2, isDark = false}},
        content = 280,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [29] = {
        content = 290,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 3, isDark = false}},
        content = 300,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [31] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 310,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [32] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 320,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [33] = {
        imgTween = {
            {imgId = 2, alpha = 0}, {imgId = 3, isDark = true},
            {imgId = 4, alpha = 1, isDark = false, pos = {-270, -400, 0}}
        },
        content = 330,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [34] = {
        content = 340,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {
            {imgId = 3, isDark = false}, {imgId = 2, isDark = true},
            {imgId = 2, alpha = 1}, {imgId = 4, alpha = 0}
        },
        content = 350,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        branch = {{content = 351, jumpAct = 36}}
    },
    [36] = {
        content = 360,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [38] = {
        content = 380,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [39] = {
        content = 390,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [40] = {
        content = 400,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [41] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 410,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [42] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 420,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [44] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 440,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [45] = {
        content = 450,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [46] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 460,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [47] = {
        content = 470,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [48] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 480,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [49] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 490,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [50] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 500,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [51] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 510,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [52] = {
        content = 520,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [53] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 530,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [54] = {
        content = 540,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [55] = {
        content = 550,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [56] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 560,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [57] = {
        content = 570,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [58] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 580,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [59] = {
        imgTween = {
            {imgId = 3, alpha = 0, isDark = false},
            {imgId = 2, alpha = 0, isDark = true}
        },
        content = 590,
        contentType = 2
    },
    [60] = {
        imgTween = {
            {imgId = 2, alpha = 1, isDark = false},
            {imgId = 3, alpha = 1, isDark = true}
        },
        content = 600,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [61] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 610,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [62] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 620,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [63] = {
        content = 630,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [64] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 640,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [65] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 650,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [66] = {
        images = {
            {
                imgId = 101,
                imgPath = "42lab_npc_01_avg",
                imgType = 3,
                pos = {400, -200, 0},
                rot = {0, 0, 0},
                scale = {1.2, 1.2, 1.2},
                alpha = 1
            }
        },
        imgTween = {{imgId = 3, alpha = 0}, {imgId = 2, isDark = true}},
        content = 660,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [67] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 101, isDark = true}},
        content = 670,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [68] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 2, isDark = true}},
        content = 680,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [69] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 690,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [70] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false},
            {imgId = 101, alpha = 0, isDark = false}, {imgId = 2, isDark = true}
        },
        content = 700,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [71] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 710,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [72] = {
        imgTween = {
            {imgId = 3, alpha = 0}, {imgId = 101, alpha = 1},
            {imgId = 2, isDark = true}
        },
        content = 720,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [73] = {
        imgTween = {{imgId = 2, isDark = false}},
        content = 730,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [74] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false}, {imgId = 2, isDark = true},
            {imgId = 101, alpha = 0, isDark = false}
        },
        content = 740,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [75] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 750,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [76] = {
        content = 760,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_Relax", sheet = "Music"}}
    },
    [77] = {
        imgTween = {
            {imgId = 3, alpha = 0}, {imgId = 2, isDark = true},
            {imgId = 4, alpha = 1, pos = {500, -400, 0}, isDark = false}
        },
        content = 770,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [78] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false}, {imgId = 4, alpha = 0}
        },
        content = 780,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [79] = {
        content = 790,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [80] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 800,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [81] = {
        content = 810,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [82] = {
        content = 820,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [83] = {
        imgTween = {
            {imgId = 4, alpha = 1, pos = {500, -400, 0}, isDark = false},
            {imgId = 2, isDark = true}, {imgId = 3, alpha = 0}
        },
        content = 830,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [84] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 4, isDark = true}},
        content = 840,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [85] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 2, isDark = true}},
        content = 850,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [86] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 4, isDark = true}},
        content = 860,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [87] = {
        images = {
            {
                imgId = 5,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 4,
                fullScreen = true,
                alpha = 0
            }, {
                imgId = 6,
                imgPath = "cpt01/cpt01_e_bg001",
                imgType = 2,
                order = 51,
                fullScreen = true,
                alpha = 0
            }, {imgId = 2, delete = true}, {imgId = 3, delete = true},
            {imgId = 4, delete = true}, {imgId = 99, delete = true}
        },
        imgTween = {
            {imgId = 5, duration = 1, alpha = 1},
            {imgId = 5, delay = 1, duration = 1, alpha = 0},
            {imgId = 6, delay = 1, alpha = 1}
        },
        content = 870,
        contentType = 2
    },
    [88] = {
        content = 880,
        contentType = 4,
        speakerName = 881,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [89] = {content = 890, contentType = 4, speakerName = 882},
    [90] = {
        images = {
            {
                imgId = 7,
                imgPath = "fresnel_avg",
                imgType = 3,
                pos = {-465, -300, 0},
                scale = {1.2, 1.2, 1.2},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 7, duration = 0.5, pos = {-390, -300, 0}, alpha = 1}
        },
        content = 900,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [91] = {
        images = {
            {
                imgId = 8,
                imgPath = "mai_avg",
                imgType = 3,
                pos = {425, 100, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 8, duration = 0.5, pos = {350, 100, 0}, alpha = 1},
            {imgId = 7, isDark = true}
        },
        content = 910,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [92] = {
        imgTween = {{imgId = 7, isDark = false}, {imgId = 8, isDark = true}},
        content = 920,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [93] = {
        imgTween = {{imgId = 8, isDark = false}, {imgId = 7, isDark = true}},
        content = 930,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [94] = {
        content = 940,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt01_e_04_01

