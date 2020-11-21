-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_04_01 = {
    [1] = {
        images = {
            {
                imgId = 8,
                imgPath = "cpt00/cpt00_e_bg001",
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
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg001",
                imgType = 2,
                scale = {1, 1, 1},
                fullScreen = true
            }, {
                imgId = 1,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-470, -310, 0},
                scale = {1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 1, duration = 0.2, pos = {-400, -310, 0}, alpha = 1}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_Relax", sheet = "Music"}}
    },
    [3] = {
        images = {
            {
                imgId = 2,
                imgPath = "sol",
                imgType = 3,
                pos = {600, -400, 0},
                scale = {1.45, 1.45, 1.45},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 2, duration = 0.2, pos = {500, -400, 0}, alpha = 1},
            {imgId = 1, isDark = true}
        },
        content = 30,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [4] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 2, isDark = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [6] = {
        images = {
            {
                imgId = 3,
                imgPath = "anna_avg",
                imgType = 3,
                pos = {-475, -330, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 1, duration = 0.3, alpha = 0},
            {imgId = 3, duration = 0.5, pos = {-400, -330, 0}, alpha = 1}
        },
        content = 60,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [7] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 2, alpha = 0}},
        content = 70,
        contentType = 2,
        branch = {{content = 71, jumpAct = 8}, {content = 72, jumpAct = 12}}
    },
    [8] = {
        imgTween = {{imgId = 3, isDark = false}},
        content = 80,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [9] = {
        content = 90,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [10] = {
        imgTween = {
            {imgId = 2, alpha = 1, isDark = false}, {imgId = 3, isDark = true}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [11] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        nextId = 16
    },
    [12] = {
        imgTween = {
            {imgId = 3, duration = 0.2, pos = {-400, -330, 0}, isDark = false}
        },
        content = 120,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [13] = {
        imgTween = {
            {imgId = 3, duration = 1, pos = {-475, -330, 0}, isDark = false}
        },
        content = 130,
        contentType = 2
    },
    [14] = {
        imgTween = {
            {imgId = 3, alpha = 0, pos = {-400, -330, 0}},
            {imgId = 1, alpha = 0.2, pos = {-475, -310, 0}, isDark = false},
            {imgId = 1, alpha = 1, pos = {-400, -310, 0}, isDark = false}
        },
        content = 140,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [15] = {
        imgTween = {
            {imgId = 1, isDark = true},
            {imgId = 2, alpha = 0.2, pos = {575, -400, 0}},
            {
                imgId = 2,
                alpha = 1,
                duration = 0.5,
                isDark = false,
                pos = {500, -400, 0}
            }
        },
        content = 150,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [16] = {
        images = {
            {
                imgId = 101,
                imgPath = "olivia_avg",
                imgType = 3,
                pos = {-50, -350, 0},
                rot = {0, 0, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 101, duration = 0.2, pos = {0, -350, 0}, alpha = 1},
            {imgId = 1, alpha = 0}, {imgId = 2, alpha = 0},
            {imgId = 3, alpha = 0}
        },
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [17] = {
        imgTween = {
            {imgId = 2, alpha = 1, isDark = false},
            {imgId = 101, duration = 0.2, alpha = 0}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [18] = {
        imgTween = {
            {imgId = 2, alpha = 0}, {imgId = 101, duration = 0.2, alpha = 1}
        },
        content = 180,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [19] = {
        imgTween = {
            {imgId = 101, pos = {50, -350, 0}, duration = 0.5, alpha = 0}
        },
        content = 190,
        contentType = 2
    },
    [20] = {
        imgTween = {
            {imgId = 1, alpha = 1, isDark = false},
            {imgId = 101, pos = {450, -350, 0}, rot = {0, 180, 0}, alpha = 0.2},
            {
                imgId = 101,
                duration = 0.2,
                pos = {400, -350, 0},
                rot = {0, 180, 0},
                alpha = 1,
                isDark = true
            }
        },
        content = 200,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [21] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 101, isDark = false}},
        content = 210,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [22] = {
        imgTween = {
            {imgId = 1, alpha = 0},
            {imgId = 101, duration = 0.5, pos = {0, -350, 0}}
        },
        content = 220,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        branch = {{content = 221, jumpAct = 23}}
    },
    [23] = {
        imgTween = {
            {imgId = 1, alpha = 1, isDark = false},
            {imgId = 101, duration = 0.5, pos = {400, -350, 0}}
        },
        content = 230,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [24] = {
        imgTween = {{imgId = 1, isDark = true}},
        content = 240,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [25] = {
        imgTween = {
            {imgId = 1, isDark = false},
            {imgId = 101, duration = 0.5, pos = {500, -350, 0}, alpha = 0}
        },
        content = 250,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [26] = {
        imgTween = {
            {imgId = 1, alpha = 0},
            {imgId = 2, alpha = 1, pos = {-345, -400, 0}},
            {imgId = 2, duration = 0.5, pos = {-270, -400, 0}}
        },
        content = 260,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {
            {imgId = 2, isDark = true},
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 270,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [28] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 101, isDark = true}},
        content = 280,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [29] = {
        imgTween = {{imgId = 2, isDark = true}, {imgId = 101, isDark = false}},
        content = 290,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [30] = {
        content = 300,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [31] = {
        content = 310,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [32] = {
        content = 320,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        branch = {{content = 321, jumpAct = 33}}
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {
            {imgId = 1, alpha = 1, isDark = false}, {imgId = 2, alpha = 0},
            {imgId = 101, isDark = true}
        },
        content = 340,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 101, isDark = false}},
        content = 350,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [36] = {
        images = {
            {
                imgId = 112,
                imgPath = "cyclopes_npc_02_avg",
                imgType = 3,
                pos = {400, 0, 0},
                rot = {0, 0, 0},
                scale = {-1, 1, 1},
                alpha = 1
            }
        },
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {450, -350, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 360,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [37] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 112, alpha = 0}},
        content = 370,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {{imgId = 1, alpha = 0}},
        content = 380,
        contentType = 2,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [39] = {
        imgTween = {{imgId = 112, alpha = 1}},
        content = 390,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [40] = {
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {400, -350, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 112, alpha = 0}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [41] = {
        imgTween = {
            {imgId = 1, alpha = 1, isDark = false}, {imgId = 101, isDark = true}
        },
        content = 410,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [42] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 101, isDark = false}},
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {
            {imgId = 2, pos = {0, -400, 0}, isDark = false, alpha = 1},
            {imgId = 1, alpha = 0}, {imgId = 101, alpha = 0}
        },
        content = 430,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2
    },
    [44] = {
        imgTween = {
            {imgId = 3, pos = {0, -330, 0}, isDark = false, alpha = 1},
            {imgId = 2, pos = {0, -400, 0}, alpha = 0}
        },
        content = 440,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 2
    },
    [45] = {
        content = 450,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 2
    },
    [46] = {
        imgTween = {
            {imgId = 2, alpha = 1, isDark = false}, {imgId = 3, alpha = 0}
        },
        content = 460,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2
    }
}
return AvgCfg_cpt02_e_04_01

