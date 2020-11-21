-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_h_02_01 = {
    [1] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg003",
                imgType = 2,
                fullScreen = true
            }
        },
        content = 10,
        contentType = 1,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [2] = {
        content = 20,
        contentType = 2,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [3] = {
        images = {
            {
                imgId = 4,
                imgPath = "simo",
                imgType = 3,
                pos = {-100, -50, 0},
                rot = {0, 180, 0},
                scale = {1.15, 1.15, 1.15},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {0, -50, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 30,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [4] = {content = 40, contentType = 2},
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [6] = {
        content = 60,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [8] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-100, -50, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 80,
        contentType = 2
    },
    [9] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {0, -50, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 90,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [10] = {
        content = 100,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [11] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-100, -50, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 110,
        contentType = 2
    },
    [12] = {content = 120, contentType = 1},
    [13] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg001",
                imgType = 2,
                fullScreen = true
            }
        },
        content = 130,
        contentType = 2
    },
    [14] = {content = 140, contentType = 2},
    [15] = {content = 150, contentType = 2},
    [16] = {
        images = {
            {
                imgId = 112,
                imgPath = "cyclopes_npc_02_avg",
                imgType = 3,
                pos = {-470, 0, 0},
                scale = {1, 1, 1},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 112,
                duration = 0.2,
                pos = {-400, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [17] = {
        images = {
            {
                imgId = 111,
                imgPath = "cyclopes_npc_01_avg",
                imgType = 3,
                pos = {470, 0, 0},
                scale = {-1, 1, 1},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 111,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, isDark = true}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [18] = {
        imgTween = {
            {imgId = 4, pos = {-500, -50, 0}, alpha = 0.2},
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, -50, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}, {imgId = 112, alpha = 0}
        },
        content = 180,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [19] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-500, -50, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 111, alpha = 1}
        },
        content = 190,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [20] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, -50, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, isDark = true}
        },
        content = 200,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [21] = {
        imgTween = {{imgId = 111, isDark = false}, {imgId = 4, isDark = true}},
        content = 210,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [22] = {
        imgTween = {{imgId = 4, isDark = true}},
        content = 220,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [23] = {
        content = 230,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [24] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 111, isDark = true}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 111, isDark = false}},
        content = 250,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [26] = {
        content = 260,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [27] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 111, isDark = true}},
        content = 270,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [28] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 111, isDark = false}},
        content = 280,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [29] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 111, isDark = true}},
        content = 290,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [30] = {
        content = 300,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [31] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 111, isDark = false}},
        content = 310,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [32] = {
        imgTween = {{imgId = 4, isDark = false}},
        content = 320,
        contentType = 2
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [34] = {
        imgTween = {
            {imgId = 4, isDark = true},
            {imgId = 111, duration = 0.5, shake = true, isDark = false}
        },
        content = 340,
        contentType = 2
    },
    [35] = {
        imgTween = {{imgId = 4, isDark = true}},
        content = 350,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [36] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 111, isDark = true}},
        content = 360,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [37] = {
        imgTween = {{imgId = 4, duration = 0.5, pos = {-430, 50, 0}, alpha = 0}},
        content = 370,
        contentType = 2
    },
    [38] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {{imgId = 111, alpha = 0}},
        content = 380,
        contentType = 1
    },
    [39] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg004",
                imgType = 2,
                fullScreen = true
            }, {
                imgId = 103,
                imgPath = "arrow_avg",
                imgType = 3,
                pos = {-450, -300, 0},
                rot = {0, 180, 0},
                scale = {1.55, 1.55, 1.55},
                alpha = 0.2
            }, {imgId = 4, delete = true}, {imgId = 111, delete = true}
        },
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {-400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 390,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [40] = {
        imgTween = {
            {imgId = 103, isDark = true},
            {imgId = 112, pos = {400, 0, 0}, scale = {-1, 1, 1}, alpha = 1}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [41] = {
        imgTween = {{imgId = 103, isDark = false}},
        content = 410,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [42] = {
        images = {
            {
                imgId = 113,
                imgPath = "cyclopes_npc_03_avg",
                imgType = 3,
                pos = {470, 0, 0},
                scale = {-1, 1, 1},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 113,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 112,
                duration = 0.2,
                pos = {470, 0, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 103, isDark = true}
        },
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {{imgId = 103, alpha = 0}, {imgId = 113, alpha = 0}},
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [44] = {
        imgTween = {{imgId = 113, alpha = 1}},
        content = 440,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [45] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {-450, -350, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 113, alpha = 0}
        },
        content = 450,
        contentType = 2
    },
    [46] = {
        images = {
            {
                imgId = 102,
                imgPath = "mara_weapon_avg",
                imgType = 3,
                pos = {-100, -400, 0},
                rot = {0, 0, 0},
                scale = {3.7, 3.7, 3.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 102, duration = 0.5, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 460,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [47] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 113, alpha = 1}
        },
        content = 470,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [48] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 113, alpha = 0}
        },
        content = 480,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [49] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 103, pos = {450, -300, 0}, rot = {0, 0, 0}, alpha = 0},
            {imgId = 103, duration = 0.2, pos = {400, -300, 0}, alpha = 1}
        },
        content = 490,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [50] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 103, duration = 0.2, pos = {450, -300, 0}, alpha = 0}
        },
        content = 500,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [51] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 103, duration = 0.2, pos = {400, -300, 0}, alpha = 1}
        },
        content = 510,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [52] = {
        content = 520,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [53] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 103, duration = 0.2, pos = {450, -300, 0}, alpha = 0}
        },
        content = 530,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [54] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 103, duration = 0.2, pos = {400, -300, 0}, alpha = 1}
        },
        content = 540,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [55] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 103, duration = 0.2, pos = {450, -300, 0}, alpha = 0}
        },
        content = 550,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [56] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 103, duration = 0.2, pos = {400, -300, 0}, alpha = 1}
        },
        content = 560,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [57] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 103, duration = 0.2, pos = {450, -300, 0}, alpha = 0}
        },
        content = 570,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [58] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 103, duration = 0.2, pos = {400, -300, 0}, alpha = 1}
        },
        content = 580,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [59] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 103, duration = 0.2, pos = {400, -300, 0}, alpha = 1}
        },
        content = 590,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [60] = {
        imgTween = {
            {imgId = 103, isDark = true},
            {imgId = 113, pos = {-400, 0, 0}, scale = {1, 1, 1}, alpha = 1}
        },
        content = 600,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [61] = {
        imgTween = {{imgId = 103, isDark = false}, {imgId = 113, alpha = 0}},
        content = 610,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [62] = {
        imgTween = {
            {imgId = 103, isDark = true}, {imgId = 113, alpha = 0},
            {imgId = 112, pos = {-400, 0, 0}, scale = {1, 1, 1}, alpha = 1}
        },
        content = 620,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [63] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {0, -300, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 112, alpha = 0}
        },
        content = 630,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    }
}
return AvgCfg_cpt02_h_02_01

