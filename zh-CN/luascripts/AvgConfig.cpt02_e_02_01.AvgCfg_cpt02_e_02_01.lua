-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_02_01 = {
    [1] = {
        images = {
            {
                imgId = 4,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 2,
                fullScreen = true
            }
        },
        content = 10,
        contentType = 1,
        audio = {bgm = {cue = "Mus_Story_Purifier", sheet = "Music"}}
    },
    [2] = {content = 20, contentType = 1},
    [3] = {content = 30, contentType = 1},
    [4] = {content = 40, contentType = 1},
    [5] = {
        images = {
            {
                imgId = 5,
                imgPath = "cpt02/cpt02_e_bg003",
                imgType = 2,
                scale = {1, 1, 1},
                fullScreen = true
            }
        },
        content = 50,
        contentType = 2,
        audio = {
            bgm = {stop = true, cue = "Mus_Story_Purifier", sheet = "Music"}
        }
    },
    [6] = {
        images = {
            {
                imgId = 111,
                imgPath = "cyclopes_npc_01_avg",
                imgType = 3,
                pos = {-470, 0, 0},
                scale = {1, 1, 1},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 111,
                duration = 0.2,
                pos = {-400, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 60,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [8] = {
        images = {
            {
                imgId = 112,
                imgPath = "cyclopes_npc_02_avg",
                imgType = 3,
                pos = {470, 0, 0},
                scale = {-1, 1, 1},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 112,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, isDark = true}
        },
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [9] = {
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
            }
        },
        content = 90,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [10] = {
        imgTween = {
            {
                imgId = 112,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 113,
                duration = 0.2,
                pos = {470, 0, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [11] = {
        images = {
            {
                imgId = 3,
                imgPath = "simo",
                imgType = 3,
                pos = {100, -50, 0},
                scale = {1.15, 1.15, 1.15},
                alpha = 0.1
            }
        },
        imgTween = {
            {imgId = 3, duration = 0.5, pos = {50, -50, 0}, alpha = 0.5},
            {imgId = 112, alpha = 0}, {imgId = 111, alpha = 0}
        },
        content = 110,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [12] = {imgTween = {{imgId = 3, alpha = 0}}, content = 120, contentType = 2},
    [13] = {
        imgTween = {{imgId = 111, alpha = 1, isDark = false}},
        content = 130,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [14] = {
        imgTween = {
            {imgId = 3, duration = 0.5, alpha = 0.5},
            {imgId = 111, alpha = 0, isDark = false}
        },
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [15] = {
        content = 150,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [16] = {
        imgTween = {
            {imgId = 3, duration = 0.1, alpha = 0},
            {imgId = 111, alpha = 1, isDark = false}
        },
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [17] = {
        imgTween = {
            {imgId = 3, alpha = 0.5}, {imgId = 111, alpha = 0, isDark = false}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [18] = {
        imgTween = {
            {imgId = 3, alpha = 0}, {imgId = 111, alpha = 1, isDark = true},
            {imgId = 112, pos = {400, 0, 0}, alpha = 1, isDark = false}
        },
        content = 180,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {
            {imgId = 112, alpha = 0},
            {imgId = 113, pos = {400, 0, 0}, alpha = 1, isDark = false}
        },
        content = 190,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [20] = {
        imgTween = {{imgId = 111, isDark = false}, {imgId = 113, isDark = true}},
        content = 200,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [21] = {
        imgTween = {
            {imgId = 3, alpha = 0.5}, {imgId = 111, alpha = 0},
            {imgId = 113, alpha = 0}
        },
        content = 210,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [22] = {
        imgTween = {
            {imgId = 3, pos = {-430, -50, 0}, rot = {0, 180, 0}, alpha = 0},
            {imgId = 112, alpha = 1, isDark = false},
            {imgId = 111, alpha = 1, isDark = true}
        },
        content = 220,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [23] = {
        imgTween = {
            {imgId = 113, alpha = 1, isDark = false}, {imgId = 112, alpha = 0}
        },
        content = 230,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [24] = {
        imgTween = {{imgId = 111, isDark = false}, {imgId = 113, isDark = true}},
        content = 240,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [25] = {
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
            {imgId = 3, alpha = 1}, {imgId = 111, alpha = 0},
            {imgId = 113, alpha = 0}
        },
        content = 290,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {
            {imgId = 3, isDark = true},
            {imgId = 111, pos = {400, 0, 0}, scale = {-1, 1, 1}, alpha = 0.2}, {
                imgId = 111,
                duration = 0.5,
                pos = {400, 0, 0},
                scale = {-1, 1, 1},
                alpha = 1,
                shake = true,
                isDark = false
            }
        },
        content = 300,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [31] = {
        imgTween = {{imgId = 111, isDark = true}},
        content = 310,
        contentType = 2
    },
    [32] = {
        imgTween = {{imgId = 3, isDark = false}},
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
        imgTween = {{imgId = 3, isDark = true}, {imgId = 111, isDark = false}},
        content = 340,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [35] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 111, isDark = true}},
        content = 350,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [36] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 111, isDark = true}},
        content = 360,
        contentType = 2,
        contentShake = true
    },
    [37] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 111, isDark = false}},
        content = 370,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [38] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 111, isDark = true}},
        content = 380,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [39] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 111, isDark = false}},
        content = 390,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [40] = {
        imgTween = {
            {
                imgId = 111,
                duration = 0.5,
                pos = {450, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 400,
        contentType = 2
    },
    [41] = {
        imgTween = {
            {
                imgId = 111,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 410,
        contentType = 3,
        contentShake = true,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [42] = {
        imgTween = {
            {imgId = 5, duration = 0.5, shake = true}, {imgId = 3, alpha = 0},
            {imgId = 111, alpha = 0}
        },
        content = 420,
        contentType = 2
    },
    [43] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false},
            {imgId = 111, alpha = 1, isDark = true}
        },
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [44] = {
        imgTween = {
            {imgId = 3, isDark = true}, {imgId = 111, alpha = 1, isDark = false}
        },
        content = 440,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [45] = {
        imgTween = {
            {imgId = 3, duration = 0.5, isDark = false, shake = true},
            {imgId = 111, alpha = 0, delay = 0.5}
        },
        content = 450,
        contentType = 2
    },
    [46] = {content = 460, contentType = 2},
    [47] = {
        imgTween = {
            {imgId = 3, isDark = true}, {imgId = 112, alpha = 1, isDark = false}
        },
        content = 470,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [48] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 112, alpha = 0}},
        content = 480,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [49] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 111, alpha = 1}},
        content = 490,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [50] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 111, isDark = true}},
        content = 500,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [51] = {
        imgTween = {
            {imgId = 3, isDark = true}, {imgId = 111, alpha = 0},
            {imgId = 113, alpha = 1, isDark = false}
        },
        content = 510,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [52] = {
        imgTween = {
            {imgId = 112, alpha = 1},
            {imgId = 113, duration = 0.5, pos = {450, 0, 0}, alpha = 0}
        },
        content = 520,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [53] = {
        imgTween = {{imgId = 112, duration = 0.5, pos = {450, 0, 0}, alpha = 0}},
        content = 530,
        contentType = 2
    },
    [54] = {
        imgTween = {
            {imgId = 3, duration = 1, pos = {-50, -50, 0}, isDark = false}
        },
        content = 540,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [55] = {
        imgTween = {{imgId = 3, isDark = true}},
        content = 550,
        contentType = 2
    },
    [56] = {
        imgTween = {{imgId = 3, isDark = false}},
        content = 560,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [57] = {
        content = 570,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [58] = {
        imgTween = {{imgId = 3, isDark = false}},
        content = 580,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [59] = {
        imgTween = {{imgId = 3, duration = 3, shake = true}},
        content = 590,
        contentType = 2
    },
    [60] = {
        imgTween = {
            {imgId = 3, isDark = false}, {imgId = 5, duration = 3, shake = true}
        },
        content = 600,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [61] = {
        imgTween = {{imgId = 3, isDark = false}},
        content = 610,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    }
}
return AvgCfg_cpt02_e_02_01

