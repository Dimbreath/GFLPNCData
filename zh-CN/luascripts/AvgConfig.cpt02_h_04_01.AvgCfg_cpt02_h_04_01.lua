-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_h_04_01 = {
    [1] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt00/cpt00_e_bg005",
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
                imgId = 103,
                imgPath = "arrow_avg",
                imgType = 3,
                pos = {-450, -300, 0},
                rot = {0, 180, 0},
                scale = {1.55, 1.55, 1.55},
                alpha = 0.2
            }
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
        content = 20,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [3] = {
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
            }, {imgId = 103, isDark = true}
        },
        content = 30,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [4] = {
        imgTween = {{imgId = 103, isDark = false}, {imgId = 113, isDark = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [5] = {
        imgTween = {{imgId = 103, isDark = true}, {imgId = 113, isDark = false}},
        content = 50,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [6] = {
        imgTween = {{imgId = 103, isDark = false}, {imgId = 113, isDark = true}},
        content = 60,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [8] = {
        imgTween = {{imgId = 103, isDark = true}, {imgId = 113, isDark = false}},
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [9] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {-450, -300, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 113, alpha = 0}
        },
        content = 90,
        contentType = 2
    },
    [10] = {content = 100, contentType = 2},
    [11] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {-400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 110,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [12] = {
        imgTween = {
            {imgId = 103, isDark = true},
            {imgId = 113, alpha = 1, isDark = false}
        },
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [13] = {
        images = {
            {
                imgId = 4,
                imgPath = "simo",
                imgType = 3,
                pos = {0, -50, 0},
                rot = {0, 180, 0},
                scale = {1.15, 1.15, 1.15},
                alpha = 0
            }
        },
        imgTween = {
            {
                imgId = 4,
                duration = 1.5,
                pos = {-50, -50, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 103,
                duration = 0.2,
                pos = {-450, -300, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 113, alpha = 0}
        },
        content = 130,
        contentType = 2
    },
    [14] = {
        imgTween = {
            {
                imgId = 4,
                duration = 1.5,
                pos = {-50, -50, 0},
                alpha = 0,
                isDark = false
            }, {
                imgId = 103,
                delay = 1.5,
                duration = 0.2,
                pos = {-400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [15] = {
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
            }, {imgId = 103, isDark = true}
        },
        content = 150,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [16] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {-400, -300, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 112, isDark = true}
        },
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [17] = {
        imgTween = {
            {imgId = 4, pos = {-50, -50, 0}, alpha = 1, isDark = false},
            {
                imgId = 4,
                duration = 1,
                pos = {200, -50, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 103,
                duration = 0.2,
                pos = {-450, -300, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 112, alpha = 0}
        },
        content = 170,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [18] = {
        imgTween = {
            {
                imgId = 4,
                duration = 1,
                pos = {-50, -50, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 180,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [19] = {content = 190, contentType = 2},
    [20] = {
        content = 200,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [22] = {
        content = 220,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [23] = {
        imgTween = {
            {imgId = 4, pos = {-50, -50, 0}, alpha = 1},
            {
                imgId = 4,
                duration = 0.5,
                pos = {-400, -50, 0},
                alpha = 1,
                isDark = false
            }, {
                imgId = 103,
                pos = {450, -300, 0},
                rot = {0, 0, 0},
                alpha = 0.2,
                isDark = false
            },
            {
                imgId = 103,
                duration = 0.2,
                pos = {400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 230,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [24] = {
        {imgId = 103, isDark = true},
        content = 240,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {
            {imgId = 4, pos = {-450, -50, 0}, alpha = 0, isDark = false},
            {imgId = 103, pos = {450, -300, 0}, alpha = 0.2, isDark = false},
            {imgId = 103, pos = {450, -300, 0}, alpha = 0, isDark = false}
        },
        content = 250,
        contentType = 2
    },
    [26] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.5,
                pos = {-400, -50, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 103,
                duration = 0.2,
                pos = {400, -300, 0},
                alpha = 1,
                isDark = true
            }
        },
        content = 260,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 103, isDark = false}},
        content = 270,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [28] = {content = 280, contentType = 2},
    [29] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 103, isDark = true}},
        content = 290,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {{imgId = 4, isDark = true}, {imgId = 103, isDark = false}},
        content = 300,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [31] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 103, isDark = true}},
        content = 310,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [32] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.5,
                pos = {-300, -50, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 103,
                duration = 0.2,
                pos = {450, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 320,
        contentType = 2
    },
    [33] = {
        imgTween = {
            {imgId = 103, pos = {50, -300, 0}, alpha = 0.2},
            {
                imgId = 103,
                duration = 0.2,
                pos = {0, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 330,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [34] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.3,
                pos = {-100, -50, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 103,
                duration = 0.2,
                pos = {50, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 340,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [35] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.3,
                pos = {-50, -50, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 350,
        contentType = 2
    },
    [36] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {0, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 360,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [37] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {50, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 370,
        contentType = 2
    },
    [38] = {content = 380, contentType = 2},
    [39] = {
        imgTween = {
            {imgId = 4, pos = {-100, -50, 0}, alpha = 0.2},
            {
                imgId = 4,
                duration = 0.5,
                pos = {-50, -50, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 390,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [40] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.5,
                pos = {-50, 50, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 400,
        contentType = 2,
        contentShake = true
    },
    [41] = {
        imgTween = {
            {imgId = 103, pos = {450, -300, 0}, alpha = 0.2},
            {
                imgId = 103,
                duration = 0.2,
                pos = {400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 410,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [42] = {
        imgTween = {{imgId = 103, duration = 1, shake = true}},
        content = 420,
        contentType = 2
    },
    [43] = {
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [44] = {
        imgTween = {
            {imgId = 4, pos = {-400, 50, 0}, alpha = 0.2},
            {
                imgId = 4,
                duration = 0.5,
                pos = {-400, -50, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 103, isDark = true}
        },
        content = 440,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [45] = {
        imgTween = {
            {
                imgId = 4,
                duration = 2,
                pos = {-50, -50, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 103,
                duration = 0.2,
                pos = {450, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 450,
        contentType = 2
    },
    [46] = {
        imgTween = {
            {imgId = 4, alpha = 0},
            {imgId = 103, pos = {0, -300, 0}, alpha = 1, isDark = false}
        },
        content = 460,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [47] = {
        imgTween = {{imgId = 4, alpha = 1}, {imgId = 103, alpha = 0}},
        content = 470,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [48] = {
        content = 480,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [49] = {imgTween = {{imgId = 4, alpha = 0}}, content = 490, contentType = 2},
    [50] = {
        imgTween = {{imgId = 4, alpha = 1}},
        content = 500,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [51] = {
        imgTween = {{imgId = 4, alpha = 0}, {imgId = 103, alpha = 1}},
        content = 510,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [52] = {
        imgTween = {{imgId = 4, alpha = 1}, {imgId = 103, alpha = 0}},
        content = 520,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [53] = {
        imgTween = {{imgId = 4, duration = 1, pos = {-100, -50, 0}, alpha = 0}},
        content = 530,
        contentType = 2
    },
    [54] = {
        imgTween = {
            {imgId = 103, pos = {400, -300, 0}, alpha = 1, isDark = false}
        },
        content = 540,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [55] = {
        imgTween = {
            {imgId = 103, isDark = true},
            {
                imgId = 113,
                pos = {-400, 0, 0},
                alpha = 1,
                scale = {1, 1, 1},
                isDark = false
            }
        },
        content = 550,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [56] = {
        imgTween = {{imgId = 103, isDark = false}, {imgId = 113, isDark = true}},
        content = 560,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [57] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg002",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {{imgId = 103, alpha = 0}, {imgId = 113, alpha = 0}},
        content = 570,
        contentType = 1
    },
    [58] = {
        imgTween = {{imgId = 4, duration = 0.2, pos = {-50, -50, 0}, alpha = 1}},
        content = 580,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [59] = {
        content = 590,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [60] = {
        content = 600,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [61] = {
        imgTween = {
            {imgId = 4, duration = 0.2, pos = {-100, -50, 0}, alpha = 0}
        },
        content = 610,
        contentType = 2,
        contentShake = true
    },
    [62] = {content = 620, contentType = 2},
    [63] = {content = 630, contentType = 2, contentShake = true},
    [64] = {
        imgTween = {
            {imgId = 4, pos = {-300, -50, 0}, alpha = 0},
            {imgId = 4, duration = 1, pos = {-400, -50, 0}, alpha = 1}
        },
        content = 640,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [65] = {
        imgTween = {
            {imgId = 4, duration = 0.2, pos = {-500, -50, 0}, alpha = 0},
            {imgId = 103, pos = {450, -300, 0}, alpha = 0.2},
            {
                imgId = 103,
                duration = 0.2,
                pos = {400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 650,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [66] = {
        content = 660,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [67] = {
        imgTween = {
            {imgId = 4, duration = 0.2, pos = {-400, -50, 0}, alpha = 1},
            {
                imgId = 103,
                duration = 0.2,
                pos = {450, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 670,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [68] = {
        imgTween = {
            {imgId = 4, duration = 0.2, pos = {-300, -50, 0}, alpha = 0}
        },
        content = 680,
        contentType = 2
    },
    [69] = {
        imgTween = {
            {
                imgId = 103,
                duration = 0.2,
                pos = {400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 690,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [70] = {
        content = 700,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [71] = {
        imgTween = {
            {imgId = 103, isDark = true},
            {imgId = 113, alpha = 1, isDark = false}
        },
        content = 710,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [72] = {
        imgTween = {{imgId = 103, isDark = false}, {imgId = 113, alpha = 0}},
        content = 720,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [73] = {
        images = {
            {
                imgId = 9,
                imgPath = "cpt02/cpt02_e_bg001",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {{imgId = 103, alpha = 0}},
        content = 730,
        contentType = 1,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [74] = {
        images = {
            {
                imgId = 34,
                imgPath = "abigail_avg",
                imgType = 3,
                pos = {-400, 0, 0},
                scale = {1, 1, 1},
                alpha = 1,
                isDark = true
            }
        },
        content = 740,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_Funny", sheet = "Music"}}
    },
    [75] = {
        imgTween = {{imgId = 34, alpha = 0}},
        content = 750,
        contentType = 2
    },
    [76] = {
        images = {
            {
                imgId = 13,
                imgPath = "betty_avg",
                imgType = 3,
                scale = {1, 1, 1},
                pos = {400, 0, 0},
                alpha = 1,
                isDark = true
            }
        },
        content = 760,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [77] = {
        imgTween = {{imgId = 13, alpha = 0}},
        content = 770,
        contentType = 2
    },
    [78] = {
        imgTween = {{imgId = 34, alpha = 1}},
        content = 780,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [79] = {
        imgTween = {{imgId = 34, alpha = 0}},
        content = 790,
        contentType = 2
    },
    [80] = {
        imgTween = {{imgId = 13, alpha = 1}},
        content = 800,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt02_h_04_01

