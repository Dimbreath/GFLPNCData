-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_10_01 = {
    [1] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt01/cpt01_e_bg003",
                imgType = 2,
                order = 97,
                fullScreen = true,
                delete = false
            }, {
                imgId = 1,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-500, -310, 0},
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
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [2] = {
        images = {
            {
                imgId = 3,
                imgPath = "sol",
                imgType = 3,
                pos = {570, -400, 0},
                rot = {0, 0, 0},
                scale = {1.45, 1.45, 1.45},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {500, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 1, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [3] = {
        content = 30,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [4] = {
        content = 40,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [5] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, isDark = false}},
        content = 50,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [6] = {
        images = {
            {
                imgId = 6,
                imgPath = "fresnel_avg",
                imgType = 3,
                pos = {-460, -300, 0},
                rot = {0, 0, 0},
                scale = {1.2, 1.2, 1.2},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-500, -310, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 60,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [7] = {
        imgTween = {{imgId = 6, isDark = true}, {imgId = 3, isDark = false}},
        content = 70,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [8] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-460, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 80,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [9] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = false}},
        content = 90,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [10] = {
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-500, -310, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 3, isDark = true}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [11] = {
        content = 110,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [12] = {
        images = {
            {
                imgId = 102,
                imgPath = "riko_avg",
                imgType = 3,
                pos = {-475, -300, 0},
                rot = {0, 0, 0},
                order = 11,
                scale = {1.05, 1.05, 1.05},
                alpha = 0
            }
        },
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-460, -300, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 102,
                duration = 0.2,
                pos = {-400, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [13] = {
        content = 130,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        branch = {{content = 131, jumpAct = 14}, {content = 132, jumpAct = 15}}
    },
    [14] = {
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1,
        nextId = 16
    },
    [15] = {
        content = 150,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [16] = {
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [17] = {
        content = 170,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [18] = {
        content = 180,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 1
    },
    [19] = {
        imgTween = {
            {imgId = 3, pos = {500, -400, 0}, alpha = 1, isDark = false},
            {
                imgId = 102,
                duration = 0.2,
                pos = {-475, -300, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 190,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [20] = {
        content = 200,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [21] = {
        imgTween = {
            {imgId = 3, duration = 0.5, pos = {0, -400, 0}, isDark = false}
        },
        content = 210,
        contentType = 2,
        contentShake = true
    },
    [22] = {
        imgTween = {
            {imgId = 3, duration = 0.5, pos = {500, -400, 0}, isDark = false}
        },
        content = 220,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [23] = {
        imgTween = {{imgId = 3, isDark = true}},
        content = 230,
        contentType = 4,
        speakerName = 231
    },
    [24] = {content = 240, contentType = 4, speakerName = 231},
    [25] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 250,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [26] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-500, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 260,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-460, -300, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 270,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [28] = {
        content = 280,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [29] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-500, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 290,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {
            {
                imgId = 6,
                duration = 0.2,
                pos = {-460, -300, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 300,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [31] = {
        content = 310,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [32] = {
        images = {
            {
                imgId = 98,
                imgPath = "cpt01/cpt01_e_bg004",
                imgType = 2,
                order = 97,
                alpha = 0,
                fullScreen = true,
                delete = false
            }, {
                imgId = 50,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 4,
                fullScreen = true,
                alpha = 0
            }
        },
        imgTween = {
            {imgId = 1, pos = {-500, -310, 0}, alpha = 0, isDark = false},
            {imgId = 50, duration = 0.5, alpha = 1},
            {imgId = 50, delay = 0.5, duration = 0.5, alpha = 0},
            {imgId = 98, delay = 0.5, alpha = 1},
            {imgId = 99, delay = 0.5, alpha = 0}, {imgId = 3, alpha = 0}
        },
        content = 320,
        contentType = 2
    },
    [33] = {
        images = {{imgId = 50, delete = true}, {imgId = 99, delete = true}},
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {500, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 330,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [34] = {
        imgTween = {
            {imgId = 1, pos = {-400, -310, 0}, alpha = 1, isDark = false},
            {imgId = 3, isDark = true}
        },
        content = 340,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [35] = {
        content = 350,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [36] = {
        content = 360,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [37] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 1, isDark = true}},
        content = 370,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [38] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 3, isDark = true}},
        content = 380,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [39] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 1, isDark = true}},
        content = 390,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [40] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-500, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 6,
                duration = 0.2,
                pos = {-390, -300, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 3, isDark = true}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = 1006,
        speakerHeroPosId = 1
    },
    [41] = {
        images = {
            {
                imgId = 120,
                imgPath = "anna_hood_avg",
                imgType = 3,
                pos = {0, 0, 0},
                rot = {0, 0, 0},
                scale = {1, 1, 1},
                alpha = 0,
                isDark = true
            }
        },
        imgTween = {
            {imgId = 6, pos = {-460, -300, 0}, alpha = 0, isDark = false},
            {imgId = 3, pos = {550, -400, 0}, alpha = 0, isDark = false},
            {imgId = 120, duration = 1, alpha = 1}
        },
        content = 410,
        contentType = 2
    },
    [42] = {
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [43] = {
        imgTween = {{imgId = 120, alpha = 0}},
        content = 430,
        contentType = 2
    },
    [44] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 440,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [45] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-500, -310, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 120, alpha = 1}, {imgId = 120, duration = 1, alpha = 0}
        },
        content = 450,
        contentType = 2
    },
    [46] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {500, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 460,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [47] = {
        imgTween = {
            {imgId = 3, pos = {5500, -400, 0}, alpha = 0, isDark = false}
        },
        content = 470,
        contentType = 2,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [48] = {
        imgTween = {
            {imgId = 3, pos = {500, -400, 0}, alpha = 1, isDark = false}
        },
        content = 480,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [49] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 3, isDark = true}
        },
        content = 490,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [50] = {
        imgTween = {
            {imgId = 1, alpha = 0}, {imgId = 3, alpha = 0, isDark = true},
            {imgId = 98, duration = 1, shake = true}
        },
        content = 500,
        contentType = 2
    },
    [51] = {
        images = {
            {
                imgId = 97,
                imgPath = "cpt00/cpt00_e_bg004",
                imgType = 4,
                order = 99,
                fullScreen = true,
                delete = false,
                alpha = 0
            }, {
                imgId = 96,
                imgPath = "cpt01/cpt01_e_bg004_2",
                imgType = 2,
                order = 100,
                fullScreen = true,
                delete = false,
                alpha = 0
            }
        },
        imgTween = {
            {imgId = 97, duration = 1, alpha = 1},
            {imgId = 96, delay = 1, alpha = 1},
            {imgId = 97, duration = 1, delay = 1, alpha = 0},
            {imgId = 98, delay = 1, alpha = 0},
            {imgId = 96, delay = 1.1, duration = 3, shake = true, alpha = 1}
        },
        content = 510,
        contentType = 2,
        contentShake = true
    },
    [52] = {
        images = {{imgId = 98, delete = true}, {imgId = 97, delete = true}},
        imgTween = {
            {imgId = 96, alpha = 1},
            {
                imgId = 1,
                duration = 0.5,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 520,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [53] = {
        content = 530,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [54] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {500, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 1, isDark = true}
        },
        content = 540,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [55] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, isDark = false}},
        content = 550,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [56] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = false}},
        content = 560,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [57] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = false}},
        content = 570,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [58] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, isDark = false}},
        content = 580,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [59] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = false}},
        content = 590,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [60] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, isDark = false}},
        content = 600,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [61] = {
        content = 610,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [62] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = false}},
        content = 620,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [63] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, isDark = false}},
        content = 630,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [64] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = false}},
        content = 640,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [65] = {
        content = 650,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [66] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, isDark = false}},
        content = 660,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [67] = {
        content = 670,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [68] = {
        imgTween = {{imgId = 3, alpha = 0}, {imgId = 1, alpha = 0}},
        content = 680,
        contentType = 4,
        speakerName = 681
    },
    [69] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false}, {imgId = 1, alpha = 0}
        },
        content = 690,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [70] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, alpha = 1}},
        content = 700,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [71] = {
        content = 710,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [72] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = false}},
        content = 720,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [73] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 1, isDark = false}},
        content = 730,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    }
}
return AvgCfg_cpt01_e_10_01

