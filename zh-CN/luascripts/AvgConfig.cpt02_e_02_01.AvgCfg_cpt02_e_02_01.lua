-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_02_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg001", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg002", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 4, imgType = 3, 
rot = {0, 180, 0}
, alpha = 0, imgPath = "simo_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "croque_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "olivia_avg"}
}
, 
imgTween = {
{imgId = 98, duration = 0.5, alpha = 1}
}
, content = 10, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 3, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[2] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
}
, content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, duration = 0.2, posId = 4}
, 
{imgId = 5, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[4] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[5] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 5, duration = 0.2, alpha = 0}
, 
{imgId = 98, delay = 0.5, duration = 0.5, alpha = 1}
}
}
, 
[6] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1, isDark = false}
, 
{imgId = 5, duration = 0.2, alpha = 1, isDark = true}
}
, content = 60, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[7] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 70, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[8] = {
imgTween = {
{imgId = 5, duration = 0.2, posId = 1}
, 
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2}
}
, content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[9] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 101, isDark = false}
}
, content = 90, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[15] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[16] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[18] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[19] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 190, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[24] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 250, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[27] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[29] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 290, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 320, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[35] = {
imgTween = {
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 350, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[40] = {
imgTween = {
{imgId = 4, posId = 1}
, 
{imgId = 4, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 400, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 4, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 420, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[43] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[44] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[45] = {
imgTween = {
{imgId = 4, duration = 0.2, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2}
}
, content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[47] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 470, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 98, duration = 1, alpha = 0}
, 
{imgId = 101, duration = 0.5, alpha = 0}
, 
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 97, delay = 1, duration = 1, alpha = 1}
}
}
, 
[49] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 1}
}
, content = 490, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, duration = 0.2, posId = 2}
, 
{imgId = 101, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[51] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 510, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[53] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 3, posId = 1, isDark = false, duration = 0.2}
}
, content = 530, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[55] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[57] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 570, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[58] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 580, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[59] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 590, contentType = 3, speakerHeroId = 19, speakerHeroPosId = 3}
, 
[60] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 1, duration = 0.2, alpha = 0}
, 
{imgId = 97, duration = 1, alpha = 0}
, 
{imgId = 98, duration = 1, delay = 1, alpha = 1}
}
}
, 
[61] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, duration = 0.2, posId = 4, isDark = false}
}
, content = 610, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[62] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 620, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[63] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 630, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 670, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
}
return AvgCfg_cpt02_e_02_01

-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_02_01 = {
    [1] = {
        bgColor = 2,
        images = {
            {
                imgId = 98,
                imgType = 2,
                alpha = 0,
                imgPath = "cpt02/cpt02_e_bg001",
                fullScreen = true
            }, {
                imgId = 97,
                imgType = 2,
                alpha = 0,
                imgPath = "cpt02/cpt02_e_bg002",
                fullScreen = true
            }, {imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"},
            {imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"},
            {imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"},
            {
                imgId = 4,
                imgType = 3,
                rot = {0, 180, 0},
                alpha = 0,
                imgPath = "simo_avg"
            },
            {
                imgId = 5,
                imgType = 3,
                alpha = 0,
                rot = {0, 180, 0},
                imgPath = "croque_avg"
            }, {imgId = 101, imgType = 3, alpha = 0, imgPath = "olivia_avg"}
        },
        imgTween = {{imgId = 98, duration = 0.5, alpha = 1}},
        content = 10,
        contentType = 3,
        speakerHeroId = 1,
        speakerHeroPosId = 3,
        audio = {
            bgm = {
                cue = "Mus_Story_Relax",
                sheet = "Music",
                fadeIn = 2,
                fadeOut = 3
            }
        }
    },
    [2] = {
        imgTween = {
            {imgId = 5, posId = 1},
            {imgId = 5, posId = 2, isDark = false, duration = 0.2}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [3] = {
        imgTween = {
            {imgId = 101, posId = 5}, {imgId = 101, duration = 0.2, posId = 4},
            {imgId = 5, isDark = true}
        },
        content = 30,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [4] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 101, isDark = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [5] = {
        imgTween = {
            {imgId = 98, duration = 0.5, alpha = 0},
            {imgId = 101, duration = 0.2, alpha = 0},
            {imgId = 5, duration = 0.2, alpha = 0},
            {imgId = 98, delay = 0.5, duration = 0.5, alpha = 1}
        }
    },
    [6] = {
        imgTween = {
            {imgId = 101, duration = 0.2, alpha = 1, isDark = false},
            {imgId = 5, duration = 0.2, alpha = 1, isDark = true}
        },
        content = 60,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [7] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 101, isDark = true}},
        content = 70,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [8] = {
        imgTween = {
            {imgId = 5, duration = 0.2, posId = 1}, {imgId = 1, posId = 1},
            {imgId = 1, duration = 0.2, posId = 2}
        },
        content = 80,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [9] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 101, isDark = false}},
        content = 90,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [10] = {
        content = 100,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [11] = {
        content = 110,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [12] = {
        content = 120,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [13] = {
        content = 130,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [14] = {
        content = 140,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [15] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 101, isDark = true}},
        content = 150,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [16] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 160,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [17] = {
        content = 170,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [18] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 101, isDark = true}},
        content = 180,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [19] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 190,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [20] = {
        content = 200,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [22] = {
        content = 220,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [23] = {
        content = 230,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [24] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 101, isDark = true}},
        content = 240,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [25] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 250,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [26] = {
        content = 260,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [27] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 101, isDark = true}},
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
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 290,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [30] = {
        content = 300,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [31] = {
        content = 310,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [32] = {
        imgTween = {
            {imgId = 5, posId = 5},
            {imgId = 5, posId = 4, isDark = false, duration = 0.2},
            {imgId = 1, isDark = true},
            {imgId = 101, posId = 5, isDark = false, duration = 0.2}
        },
        content = 320,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [34] = {
        content = 340,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [35] = {
        imgTween = {
            {imgId = 101, posId = 4, isDark = false, duration = 0.2},
            {imgId = 5, posId = 5, isDark = false, duration = 0.2}
        },
        content = 350,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [36] = {
        content = 360,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [38] = {
        content = 380,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [39] = {
        content = 390,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [40] = {
        imgTween = {
            {imgId = 4, posId = 1},
            {imgId = 4, posId = 2, isDark = false, duration = 0.2},
            {imgId = 101, isDark = true},
            {imgId = 1, posId = 1, isDark = false, duration = 0.2}
        },
        content = 400,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [41] = {
        imgTween = {
            {imgId = 5, posId = 4, isDark = false, duration = 0.2},
            {imgId = 101, posId = 5, isDark = false, duration = 0.2},
            {imgId = 4, isDark = true}
        },
        content = 410,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [42] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 5, isDark = true}},
        content = 420,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [43] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 4, isDark = true}},
        content = 430,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [44] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 5, isDark = true}},
        content = 440,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [45] = {
        imgTween = {
            {imgId = 4, duration = 0.2, posId = 1},
            {imgId = 1, duration = 0.2, posId = 2}
        },
        content = 450,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [46] = {
        content = 460,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [47] = {
        imgTween = {
            {imgId = 101, posId = 5},
            {imgId = 101, posId = 4, isDark = false, duration = 0.2},
            {imgId = 1, isDark = true},
            {imgId = 5, posId = 5, isDark = false, duration = 0.2}
        },
        content = 470,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [48] = {
        imgTween = {
            {imgId = 98, duration = 1, alpha = 0},
            {imgId = 101, duration = 0.5, alpha = 0},
            {imgId = 1, duration = 0.5, alpha = 0},
            {imgId = 97, delay = 1, duration = 1, alpha = 1}
        }
    },
    [49] = {
        imgTween = {{imgId = 101, duration = 0.2, alpha = 1}},
        content = 490,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [50] = {
        imgTween = {
            {imgId = 3, posId = 1}, {imgId = 3, duration = 0.2, posId = 2},
            {imgId = 101, isDark = true}
        },
        content = 500,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [51] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 3, isDark = true}},
        content = 510,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [52] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 101, isDark = true}},
        content = 520,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [53] = {
        imgTween = {
            {imgId = 2, posId = 1},
            {imgId = 2, posId = 2, isDark = false, duration = 0.2},
            {imgId = 101, isDark = true},
            {imgId = 3, posId = 1, isDark = false, duration = 0.2}
        },
        content = 530,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [54] = {
        content = 540,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [55] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 2, isDark = true}},
        content = 550,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [56] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 101, isDark = true}},
        content = 560,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [57] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 2, isDark = true}},
        content = 570,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [58] = {
        imgTween = {
            {imgId = 1, posId = 1},
            {imgId = 1, posId = 2, isDark = false, duration = 0.2},
            {imgId = 101, isDark = true},
            {imgId = 2, posId = 1, isDark = false, duration = 0.2}
        },
        content = 580,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [59] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 590,
        contentType = 3,
        speakerHeroId = 19,
        speakerHeroPosId = 3
    },
    [60] = {
        imgTween = {
            {imgId = 101, duration = 0.2, alpha = 0},
            {imgId = 1, duration = 0.2, alpha = 0},
            {imgId = 97, duration = 1, alpha = 0},
            {imgId = 98, duration = 1, delay = 1, alpha = 1}
        }
    },
    [61] = {
        imgTween = {
            {imgId = 4, posId = 5},
            {imgId = 4, duration = 0.2, posId = 4, isDark = false}
        },
        content = 610,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [62] = {
        imgTween = {
            {imgId = 1, posId = 1},
            {imgId = 1, duration = 0.2, posId = 2, isDark = false},
            {imgId = 4, isDark = true}
        },
        content = 620,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [63] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 1, isDark = true}},
        content = 630,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [64] = {
        content = 640,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [65] = {
        content = 650,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [66] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 4, isDark = true}},
        content = 660,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [67] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 1, isDark = true}},
        content = 670,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [68] = {
        content = 680,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [69] = {
        content = 690,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt02_e_02_01

