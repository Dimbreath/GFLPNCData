-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_12_01 = {
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
        content = 10,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [2] = {
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
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 102, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [3] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 30,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [4] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [5] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 50,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [6] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 60,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [7] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 70,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [8] = {
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [9] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 90,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [10] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 100,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [11] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [12] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 120,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [13] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 130,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [14] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 140,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [15] = {
        content = 150,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [16] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 160,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [17] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
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
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 190,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        branch = {{content = 191, jumpAct = 20}, {content = 192, jumpAct = 22}}
    },
    [20] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 200,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3,
        nextId = 24
    },
    [22] = {
        content = 220,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [23] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 230,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [24] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 240,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [25] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 102, isDark = true}},
        content = 250,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [26] = {
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
            },
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 260,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 102, isDark = false}},
        content = 270,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [28] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
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
        content = 280,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [29] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 290,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 102, isDark = false}},
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
        imgTween = {{imgId = 1, isDark = false}, {imgId = 102, isDark = true}},
        content = 320,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [33] = {
        imgTween = {{imgId = 102, isDark = false}, {imgId = 1, isDark = true}},
        content = 330,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 102, isDark = true}
        },
        content = 340,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {{imgId = 3, isDark = true}, {imgId = 102, isDark = false}},
        content = 350,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [36] = {
        images = {
            {
                imgId = 101,
                imgPath = "turing",
                imgType = 3,
                pos = {500, -330, 0},
                rot = {0, 0, 0},
                scale = {1.2, 1.2, 1.2},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 101,
                duration = 0.2,
                pos = {400, -330, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
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
        content = 360,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [37] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 101, isDark = true}
        },
        content = 370,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 101, isDark = false}},
        content = 380,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [39] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 101, isDark = true}},
        content = 390,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [40] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 101, isDark = false}},
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [41] = {
        images = {
            {
                imgId = 9,
                imgPath = "mai_avg",
                imgType = 3,
                pos = {-460, 100, 0},
                rot = {0, 180, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 9,
                duration = 0.2,
                pos = {-350, 100, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-470, -310, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 410,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 1
    },
    [42] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 101, isDark = false}},
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 430,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 1
    },
    [44] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 101, isDark = false}},
        content = 440,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [45] = {
        content = 450,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [46] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 460,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 1
    },
    [47] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 101, isDark = false}},
        content = 470,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [48] = {
        imgTween = {{imgId = 9, isDark = false}, {imgId = 101, isDark = true}},
        content = 480,
        contentType = 3,
        speakerHeroId = 1009,
        speakerHeroPosId = 1
    },
    [49] = {
        imgTween = {{imgId = 9, isDark = true}, {imgId = 101, isDark = false}},
        content = 490,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [50] = {
        content = 500,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [51] = {
        content = 510,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [52] = {
        imgTween = {
            {
                imgId = 9,
                duration = 0.2,
                pos = {-425, 100, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 101, isDark = true}
        },
        content = 520,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [53] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 101, isDark = false}},
        content = 530,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt01_e_12_01

