-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_18_01 = {
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
                imgId = 111,
                imgPath = "faith_avg",
                imgType = 3,
                pos = {0, 0, 0},
                rot = {0, 0, 0},
                scale = {1, 1, 1},
                alpha = 0.2
            }
        },
        imgTween = {{imgId = 111, duration = 0.2, alpha = 1, isDark = false}},
        content = 10,
        contentType = 3,
        speakerHeroId = -1,
        audio = {bgm = {stop = true, cue = "", sheet = "Music"}}
    },
    [2] = {imgTween = {{imgId = 111, alpha = 0}}, content = 20, contentType = 2},
    [3] = {
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
            }
        },
        content = 30,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}}
    },
    [4] = {
        images = {
            {
                imgId = 2,
                imgPath = "anna_avg",
                imgType = 3,
                pos = {-475, -330, 0},
                rot = {0, 0, 0},
                scale = {1.6, 1.6, 1.6},
                alpha = 0.2
            }
        },
        imgTween = {
            {
                imgId = 2,
                duration = 0.2,
                pos = {-400, -330, 0},
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
        content = 40,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [6] = {
        imgTween = {
            {
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
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
                pos = {-200, -400, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 70,
        contentType = 2
    },
    [8] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 0,
                isDark = true
            }, {imgId = 111, alpha = 1}
        },
        content = 80,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [9] = {
        content = 90,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [10] = {
        imgTween = {
            {imgId = 3, alpha = 1, isDark = false}, {imgId = 111, alpha = 0}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [11] = {
        content = 110,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [12] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 2,
                duration = 0.2,
                pos = {-400, -330, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 120,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [13] = {
        content = 130,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [14] = {
        imgTween = {
            {
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 140,
        contentType = 2
    },
    [15] = {
        imgTween = {{imgId = 111, alpha = 1}},
        content = 150,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [16] = {
        content = 160,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [17] = {
        imgTween = {{imgId = 111, alpha = 0}},
        content = 170,
        contentType = 2
    },
    [18] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 180,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [19] = {
        imgTween = {{imgId = 3, alpha = 0}, {imgId = 111, alpha = 1}},
        content = 190,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [20] = {
        content = 200,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [21] = {
        images = {
            {
                imgId = 1,
                imgPath = "persicaria_avg",
                imgType = 3,
                pos = {-470, -310, 0},
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
            }, {imgId = 111, alpha = 0}
        },
        content = 210,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [22] = {
        imgTween = {
            {
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 220,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [23] = {
        imgTween = {
            {
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
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
        imgTween = {{imgId = 111, alpha = 0}},
        content = 240,
        contentType = 2,
        contentShake = true
    },
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
        speakerHeroPosId = 1
    },
    [26] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 260,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1,
        contentShake = true
    },
    [27] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            }, {imgId = 111, alpha = 1}
        },
        content = 270,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [28] = {
        imgTween = {{imgId = 111, duration = 1.2, shake = true}},
        content = 280,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [29] = {
        content = 290,
        contentType = 3,
        speakerHeroId = -1,
        speakerHeroPosId = 2
    },
    [30] = {
        imgTween = {{imgId = 111, alpha = 0}},
        content = 300,
        contentType = 2
    },
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
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            }, {imgId = 111, alpha = 0}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [33] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 2,
                duration = 0.2,
                pos = {-400, -330, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 330,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [34] = {
        content = 340,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-400, -310, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 350,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [36] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 360,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
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
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 370,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {
            {
                imgId = 1,
                duration = 0.2,
                pos = {-475, -310, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 380,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [39] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-345, -400, 0},
                alpha = 0,
                isDark = false
            },
            {
                imgId = 2,
                duration = 0.2,
                pos = {-400, -330, 0},
                alpha = 1,
                isDark = false
            }
        },
        content = 390,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [40] = {
        imgTween = {
            {
                imgId = 3,
                duration = 0.2,
                pos = {-270, -400, 0},
                alpha = 1,
                isDark = false
            },
            {
                imgId = 2,
                duration = 0.2,
                pos = {-475, -330, 0},
                alpha = 0,
                isDark = false
            }
        },
        content = 400,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    }
}
return AvgCfg_cpt01_e_18_01

