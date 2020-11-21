-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_14_01 = {
    [1] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt02/cpt02_e_cg001",
                imgType = 2,
                scale = {2, 2, 2},
                fullScreen = true,
                pos = {300, 200, 0}
            }
        },
        content = 10,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [2] = {
        imgTween = {
            {imgId = 99, duration = 1, scale = {2, 2, 2}, pos = {-1000, 200, 0}}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [3] = {
        imgTween = {
            {imgId = 99, duration = 1, scale = {2, 2, 2}, pos = {-800, -350, 0}}
        },
        content = 30,
        contentType = 2
    },
    [4] = {
        images = {
            {
                imgId = 4,
                imgPath = "simo",
                imgType = 3,
                pos = {-500, -50, 0},
                scale = {-1.15, 1.15, 1.15},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, -50, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 40,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [5] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, 0, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 50,
        contentType = 2
    },
    [6] = {
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
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 60,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [7] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, -50, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0}
        },
        content = 70,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [8] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, -50, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 80,
        contentType = 2,
        contentShake = true
    },
    [9] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 90,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [10] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0},
            {imgId = 99, duration = 1, pos = {-1000, 200, 0}}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        contentShake = true
    },
    [11] = {
        imgTween = {{imgId = 99, duration = 1, pos = {300, 200, 0}}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [12] = {
        imgTween = {
            {imgId = 99, duration = 1, scale = {1, 1, 1}, pos = {0, 0, 0}}
        },
        content = 120,
        contentType = 2
    },
    [13] = {
        images = {
            {
                imgId = 98,
                imgPath = "cpt02/cpt02_e_bg004",
                imgType = 2,
                fullScreen = true
            }
        },
        imgTween = {
            {imgId = 99, alpha = 0, duration = 1},
            {imgId = 102, duration = 1.5, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 130,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [14] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, -50, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0}
        },
        content = 140,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [15] = {
        imgTween = {
            {
                imgId = 4,
                duration = 0.2,
                pos = {-430, -50, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 150,
        contentType = 2
    },
    [16] = {
        imgTween = {
            {imgId = 102, duration = 1, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [17] = {
        imgTween = {{imgId = 102, alpha = 0}},
        content = 170,
        contentType = 2
    },
    [18] = {
        images = {
            {
                imgId = 1,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {500, -310, 0},
                rot = {0, 180, 0},
                scale = {1.7, 1.7, 1.7},
                alpha = 0.2
            }
        },
        imgTween = {
            {imgId = 1, duration = 0.5, pos = {400, -310, 0}, alpha = 1},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0}
        },
        content = 180,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {
            {imgId = 1, duration = 0.5, pos = {400, -310, 0}, alpha = 0}
        },
        content = 190,
        contentType = 2
    },
    [20] = {
        images = {
            {
                imgId = 3,
                imgPath = "sol",
                imgType = 3,
                pos = {600, -400, 0},
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
            }
        },
        content = 200,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [22] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {500, -350, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 220,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [23] = {
        imgTween = {
            {imgId = 1, duration = 0.5, pos = {400, -310, 0}, alpha = 1},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 0}
        },
        content = 230,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        audio = {bgm = {stop = true, sheet = "Music"}}
    },
    [24] = {
        imgTween = {
            {imgId = 1, duration = 0.2, pos = {500, -310, 0}, alpha = 0}
        },
        content = 240,
        contentType = 2
    },
    [25] = {
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
        content = 250,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [26] = {
        imgTween = {
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1},
            {imgId = 101, duration = 0.2, pos = {450, -350, 0}, alpha = 0}
        },
        content = 260,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [27] = {
        content = 270,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [28] = {
        imgTween = {
            {imgId = 1, duration = 0.2, pos = {400, -310, 0}, alpha = 1},
            {imgId = 102, duration = 0.2, pos = {-150, -400, 0}, alpha = 0}
        },
        content = 280,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [29] = {
        imgTween = {
            {imgId = 1, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 290,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [30] = {
        imgTween = {
            {imgId = 1, duration = 0.2, pos = {500, -310, 0}, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-150, -400, 0}, alpha = 0},
            {imgId = 101, duration = 0.2, pos = {400, -350, 0}, alpha = 1}
        },
        content = 300,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 3
    },
    [31] = {
        {imgId = 101, duration = 1, pos = {600, -350, 0}, alpha = 0},
        content = 310,
        contentType = 2
    },
    [32] = {
        imgTween = {
            {imgId = 1, duration = 0.2, pos = {500, -310, 0}, alpha = 0},
            {imgId = 101, pos = {0, -350, 0}, alpha = 1}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [33] = {
        imgTween = {{imgId = 101, pos = {0, -350, 0}, alpha = 0}},
        content = 330,
        contentType = 2
    },
    [34] = {
        imgTween = {{imgId = 98, duration = 2, shake = true}},
        content = 340,
        contentType = 2
    },
    [35] = {
        content = 350,
        contentType = 2,
        audio = {bgm = {cue = "Mus_Story_Purifier", sheet = "Music"}}
    },
    [36] = {
        imgTween = {{imgId = 101, pos = {0, -350, 0}, alpha = 1}},
        content = 360,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [38] = {
        imgTween = {{imgId = 101, pos = {0, -350, 0}, alpha = 0}},
        content = 380,
        contentType = 2
    },
    [39] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {400, -310, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 390,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [40] = {
        imgTween = {
            {imgId = 1, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [41] = {
        imgTween = {
            {imgId = 1, alpha = 1},
            {imgId = 102, duration = 0.2, pos = {-150, -400, 0}, alpha = 0}
        },
        content = 410,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [42] = {
        imgTween = {
            {imgId = 1, alpha = 0},
            {imgId = 102, duration = 0.2, pos = {-100, -400, 0}, alpha = 1}
        },
        content = 420,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    }
}
return AvgCfg_cpt02_e_14_01

