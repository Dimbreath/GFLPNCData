-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_16_01 = {
    [1] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt01/cpt01_e_bg005",
                imgType = 2,
                order = 97,
                fullScreen = true,
                delete = false
            }, {
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
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [2] = {
        images = {
            {
                imgId = 111,
                imgPath = "faith_avg",
                imgType = 3,
                pos = {0, 0, 0},
                rot = {0, 0, 0},
                scale = {1, 1, 1},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 111, duration = 0.2, alpha = 1, isDark = false},
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 20,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [3] = {
        content = 30,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [4] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}
        },
        content = 40,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [6] = {
        content = 60,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [7] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 111, alpha = 1}
        },
        content = 70,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [8] = {
        imgTween = {{imgId = 111, duration = 1.5, shake = true}},
        content = 80,
        contentType = 2
    },
    [9] = {
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
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}
        },
        content = 90,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [10] = {
        content = 100,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [11] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 110,
        contentType = 2
    },
    [12] = {
        images = {
            {
                imgId = 120,
                imgPath = "anna_hood_avg",
                imgType = 3,
                pos = {0, 0, 0},
                order = 11,
                rot = {0, 0, 0},
                scale = {1, 1, 1},
                alpha = 1,
                isDark = false
            }
        },
        content = 120,
        contentType = 2
    },
    [13] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 120,
                duration = 0.2,
                pos = {400, 0, 0},
                alpha = 1,
                isDark = true
            }
        },
        content = 130,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [14] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 120, isDark = false}},
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [15] = {
        imgTween = {{imgId = 1, isDark = false}},
        content = 150,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [16] = {
        imgTween = {{imgId = 1, alpha = 0}, {imgId = 120, alpha = 0}},
        content = 160,
        contentType = 2
    },
    [17] = {
        images = {
            {
                imgId = 102,
                imgPath = "riko_avg",
                imgType = 3,
                pos = {475, -300, 0},
                rot = {0, 0, 0},
                order = 11,
                scale = {-1.05, 1.05, 1.05},
                alpha = 0
            }
        },
        imgTween = {
            {
                imgId = 102,
                duration = 0.2,
                pos = {400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 170,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [18] = {
        content = 180,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {{imgId = 1, alpha = 1}, {imgId = 102, isDark = true}},
        content = 190,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [20] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 102,
                duration = 0.2,
                pos = {475, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 200,
        contentType = 2
    },
    [21] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 210,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [22] = {
        content = 220,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [23] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-200, -400, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 111, alpha = 1}
        },
        content = 230,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [24] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}
        },
        content = 240,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-200, -400, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 111, alpha = 1}
        },
        content = 250,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [26] = {
        imgTween = {{imgId = 111, duration = 1.5, shake = true}},
        content = 260,
        contentType = 2
    },
    [27] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}
        },
        content = 270,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [28] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 280,
        contentType = 2,
        contentShake = true
    },
    [29] = {content = 290, contentType = 2},
    [30] = {content = 300, contentType = 2},
    [31] = {
        imgTween = {{imgId = 111, alpha = 1}},
        content = 310,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [32] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [34] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.5,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 340,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.5,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 350,
        contentType = 2
    },
    [36] = {
        imgTween = {
            {imgId = 120, pos = {0, 0, 0}, alpha = 1, isDark = true},
            {
                imgId = 120,
                duration = 0.5,
                pos = {0, 0, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 360,
        contentType = 4,
        speakerName = 361
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [38] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 120, alpha = 0}
        },
        content = 380,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [39] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.5,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 3,
                duration = 0.5,
                pos = {-270, -400, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 390,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [40] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.5,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 111, alpha = 1}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [41] = {
        imgTween = {{imgId = 111, alpha = 0}},
        content = 410,
        contentType = 2,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [42] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt01/cpt01_e_cg001",
                imgType = 2,
                scale = {2, 2, 2},
                pos = {500, 100, 0},
                fullScreen = true,
                delete = false
            }
        },
        imgTween = {
            {
                imgId = 99,
                duration = 3,
                pos = {-800, -350, 0},
                alpha = 1,
                isDark = false
            }, {
                imgId = 99,
                duration = 3,
                delay = 2.8,
                pos = {500, -200, 0},
                alpha = 1,
                isDark = false
            }, {
                imgId = 99,
                duration = 5,
                delay = 5.5,
                pos = {0, 0, 0},
                alpha = 1,
                scale = {1.1, 1.1, 1.1},
                isDark = false
            }
        },
        content = 420,
        contentType = 4,
        speakerName = 362
    },
    [43] = {
        content = 430,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [44] = {
        content = 440,
        contentType = 4,
        speakerName = 363,
        contentShake = true
    },
    [45] = {
        content = 450,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 2
    },
    [46] = {content = 460, contentType = 4, speakerName = 363},
    [47] = {
        content = 470,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 2
    },
    [48] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt01/cpt01_e_bg005",
                imgType = 2,
                order = 97,
                fullScreen = true,
                delete = false
            }
        },
        imgTween = {{imgId = 111, alpha = 1}},
        content = 480,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [49] = {
        imgTween = {
            {imgId = 3, pos = {-270, -400, 0}, alpha = 1},
            {imgId = 111, alpha = 0}
        },
        content = 490,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [50] = {
        imgTween = {{imgId = 111, alpha = 1}, {imgId = 3, alpha = 0}},
        content = 500,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [51] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.5,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}
        },
        content = 510,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [52] = {
        imgTween = {
            {imgId = 3, isDark = true},
            {imgId = 120, pos = {400, 0, 0}, alpha = 1, isDark = false}
        },
        content = 520,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [53] = {
        imgTween = {{imgId = 3, alpha = 0}, {imgId = 120, alpha = 0}},
        content = 530,
        contentType = 2
    },
    [54] = {
        imgTween = {{imgId = 120, alpha = 1}},
        content = 540,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [55] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false}, {imgId = 120, isDark = true}
        },
        content = 550,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [56] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 120, isDark = false}},
        content = 560,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [57] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 120, isDark = true}},
        content = 570,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    }
}
return AvgCfg_cpt01_e_16_01

