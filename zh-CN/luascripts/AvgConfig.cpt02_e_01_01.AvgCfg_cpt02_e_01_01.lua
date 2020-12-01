-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_01_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg001", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg007_1", fullScreen = true}
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
{imgId = 101, imgType = 3, alpha = 0, imgPath = "riko_avg"}
}
, content = 10, contentType = 1, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {content = 20, contentType = 1}
, 
[3] = {content = 30, contentType = 1}
, 
[4] = {content = 40, contentType = 1}
, 
[5] = {content = 50, contentType = 1}
, 
[6] = {content = 60, contentType = 1}
, 
[7] = {content = 70, contentType = 1}
, 
[8] = {content = 80, contentType = 1}
, 
[9] = {content = 90, contentType = 1, scrambleTypeWriter = true}
, 
[10] = {
imgTween = {
{imgId = 97, duration = 3, alpha = 1}
, 
{imgId = 4, posId = 3, alpha = 0}
, 
{imgId = 4, duration = 1, delay = 3, posId = 3, alpha = 1}
}
, content = 100, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[13] = {
imgTween = {
{imgId = 4, duration = 0.5, alpha = 0}
}
, content = 130, contentType = 2}
, 
[14] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2}
}
, content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf", audioId = 0}
}
}
, 
[15] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, duration = 0.2, posId = 4}
, 
{imgId = 1, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[16] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[18] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 180, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[19] = {
imgTween = {
{imgId = 1, duration = 0.2, posId = 1}
, 
{imgId = 2, posId = 1}
, 
{imgId = 2, duration = 0.2, posId = 2}
, 
{imgId = 4, isDark = true}
}
, content = 190, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 4, duration = 0.5, alpha = 0}
, 
{imgId = 2, duration = 0.5, alpha = 0}
, 
{imgId = 101, posId = 2, alpha = 0}
, 
{imgId = 3, posId = 4, alpha = 0}
, 
{imgId = 101, duration = 0.5, delay = 0.7, alpha = 1}
, 
{imgId = 3, duration = 0.5, delay = 0.7, alpha = 1}
, 
{imgId = 3, duration = 0.2, delay = 1, alpha = 1, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 1}
, 
[22] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[23] = {
imgTween = {
{imgId = 101, duration = 0.2, posId = 3, isDark = false}
, 
{imgId = 3, duration = 0.2, posId = 5, isDark = true}
}
, content = 230, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 2, contentShake = true}
, 
[24] = {
imgTween = {
{imgId = 101, duration = 0.2, posId = 1}
, 
{imgId = 3, duration = 0.2, posId = 5}
, 
{imgId = 1, duration = 0.2, posId = 2, delay = 0.5, isDark = false}
, 
{imgId = 4, duration = 0.2, posId = 4, delay = 0.5, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[28] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[29] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 290, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[30] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[31] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 310, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, duration = 0.2, posId = 4}
, 
{imgId = 4, duration = 0.2, posId = 5}
, 
{imgId = 1, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf", audioId = 0}
}
}
, 
[34] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[36] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[38] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[41] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[42] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 420, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 4, posId = 1}
, 
{imgId = 4, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 1, duration = 0.2, posId = 1}
}
, content = 450, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[53] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[54] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[55] = {
imgTween = {
{imgId = 4, duration = 0.2, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[56] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[58] = {
imgTween = {
{imgId = 97, duration = 3, alpha = 0}
, 
{imgId = 5, duration = 2, alpha = 0}
, 
{imgId = 1, duration = 2, alpha = 0}
, 
{imgId = 98, duration = 3, alpha = 1, delay = 3}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[59] = {
imgTween = {
{imgId = 4, posId = 3, alpha = 0}
, 
{imgId = 4, duration = 0.5, posId = 3, alpha = 1, isDark = false}
}
, content = 590, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_AMB_Street", sheet = "AVG_gf", audioId = 1}
}
}
, 
[60] = {
imgTween = {
{imgId = 4, duration = 0.5, alpha = 0}
, 
{imgId = 3, posId = 5}
, 
{imgId = 3, duration = 0.5, posId = 4, isDark = false}
}
, content = 600, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[63] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2}
, 
{imgId = 3, isDark = true}
}
, content = 630, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[64] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 640, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[65] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 650, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[66] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 660, contentType = 4, speakerName = 11}
, 
[67] = {
imgTween = {
{imgId = 5, isDark = false}
}
, content = 670, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[70] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 3, posId = 5, duration = 0.2}
}
, content = 700, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[71] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 710, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 4}
, 
stopAudioId = {1}
}
}
, 
[72] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 720, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[73] = {content = 730, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
branch = {
{content = 741, jumpAct = 75}
, 
{content = 742, jumpAct = 76}
}
}
, 
[75] = {
imgTween = {
{imgId = 1, posId = 3, isDark = false}
, 
{imgId = 1, duration = 0.2, shake = true}
, 
{imgId = 4, duration = 0.1, posId = 5}
, 
{imgId = 5, duration = 0.1, posId = 1}
}
, content = 750, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, nextId = 77, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf", audioId = 0}
}
}
, 
[76] = {
imgTween = {
{imgId = 1, posId = 3, isDark = false}
, 
{imgId = 1, delay = 0.1, duration = 0.3, shake = true}
, 
{imgId = 1, delay = 0.3, isDark = true, alpha = 1}
, 
{imgId = 4, duration = 0.1, posId = 5}
, 
{imgId = 5, duration = 0.1, posId = 1}
}
, content = 760, contentType = 2, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf", audioId = 0}
}
}
, 
[77] = {
imgTween = {
{imgId = 1, duration = 0.2, posId = 2, isDark = true}
, 
{imgId = 4, duration = 0.2, posId = 4, isDark = false}
}
, content = 770, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[78] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[79] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 790, contentType = 4, speakerName = 11}
, 
[80] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 800, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[81] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 810, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[83] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 830, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[84] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, duration = 0.2, posId = 5}
, 
{imgId = 1, isDark = true}
}
, content = 840, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[85] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 850, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[86] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 4, duration = 0.2, posId = 5}
, 
{imgId = 1, isDark = true}
}
, content = 860, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
}
return AvgCfg_cpt02_e_01_01

-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_01_01 = {
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
                imgPath = "cpt00/cpt00_e_bg007_1",
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
            }, {imgId = 101, imgType = 3, alpha = 0, imgPath = "riko_avg"}
        },
        content = 10,
        contentType = 1,
        audio = {bgm = {stop = true}}
    },
    [2] = {content = 20, contentType = 1},
    [3] = {content = 30, contentType = 1},
    [4] = {content = 40, contentType = 1},
    [5] = {content = 50, contentType = 1},
    [6] = {content = 60, contentType = 1},
    [7] = {content = 70, contentType = 1},
    [8] = {content = 80, contentType = 1},
    [9] = {content = 90, contentType = 1, scrambleTypeWriter = true},
    [10] = {
        imgTween = {
            {imgId = 97, duration = 3, alpha = 1},
            {imgId = 4, posId = 3, alpha = 0},
            {imgId = 4, duration = 1, delay = 3, posId = 3, alpha = 1}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2,
        audio = {
            bgm = {
                cue = "Mus_Story_Relax",
                sheet = "Music",
                fadeIn = 2,
                fadeOut = 3
            }
        }
    },
    [11] = {
        content = 110,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [12] = {
        content = 120,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2
    },
    [13] = {
        imgTween = {{imgId = 4, duration = 0.5, alpha = 0}},
        content = 130,
        contentType = 2
    },
    [14] = {
        imgTween = {
            {imgId = 1, posId = 1}, {imgId = 1, duration = 0.2, posId = 2}
        },
        content = 140,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        audio = {
            sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf", audioId = 0}
        }
    },
    [15] = {
        imgTween = {
            {imgId = 4, posId = 5}, {imgId = 4, duration = 0.2, posId = 4},
            {imgId = 1, isDark = true}
        },
        content = 150,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [16] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 4, isDark = true}},
        content = 160,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [17] = {
        content = 170,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [18] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 1, isDark = true}},
        content = 180,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [19] = {
        imgTween = {
            {imgId = 1, duration = 0.2, posId = 1}, {imgId = 2, posId = 1},
            {imgId = 2, duration = 0.2, posId = 2}, {imgId = 4, isDark = true}
        },
        content = 190,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [20] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 2, isDark = true}},
        content = 200,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [21] = {
        imgTween = {
            {imgId = 4, duration = 0.5, alpha = 0},
            {imgId = 2, duration = 0.5, alpha = 0},
            {imgId = 101, posId = 2, alpha = 0},
            {imgId = 3, posId = 4, alpha = 0},
            {imgId = 101, duration = 0.5, delay = 0.7, alpha = 1},
            {imgId = 3, duration = 0.5, delay = 0.7, alpha = 1},
            {imgId = 3, duration = 0.2, delay = 1, alpha = 1, isDark = true}
        },
        content = 210,
        contentType = 3,
        speakerHeroId = 13,
        speakerHeroPosId = 1
    },
    [22] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 101, isDark = true}},
        content = 220,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [23] = {
        imgTween = {
            {imgId = 101, duration = 0.2, posId = 3, isDark = false},
            {imgId = 3, duration = 0.2, posId = 5, isDark = true}
        },
        content = 230,
        contentType = 3,
        speakerHeroId = 13,
        speakerHeroPosId = 2,
        contentShake = true
    },
    [24] = {
        imgTween = {
            {imgId = 101, duration = 0.2, posId = 1},
            {imgId = 3, duration = 0.2, posId = 5},
            {imgId = 1, duration = 0.2, posId = 2, delay = 0.5, isDark = false},
            {imgId = 4, duration = 0.2, posId = 4, delay = 0.5, isDark = true}
        },
        content = 240,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [25] = {
        content = 250,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [26] = {
        content = 260,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [27] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 1, isDark = true}},
        content = 270,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [28] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 4, isDark = true}},
        content = 280,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [29] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 1, isDark = true}},
        content = 290,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [30] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 4, isDark = true}},
        content = 300,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [31] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 1, isDark = true}},
        content = 310,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [32] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 4, isDark = true}},
        content = 320,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [33] = {
        imgTween = {
            {imgId = 5, posId = 5}, {imgId = 5, duration = 0.2, posId = 4},
            {imgId = 4, duration = 0.2, posId = 5}, {imgId = 1, isDark = true}
        },
        content = 330,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3,
        audio = {
            sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf", audioId = 0}
        }
    },
    [34] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 5, isDark = true}},
        content = 340,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 1, isDark = true}},
        content = 350,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [36] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 5, isDark = true}},
        content = 360,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 1, isDark = true}},
        content = 380,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [39] = {
        content = 390,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [40] = {
        content = 400,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [41] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 5, isDark = true}},
        content = 410,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [42] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 1, isDark = true}},
        content = 420,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [43] = {
        content = 430,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [44] = {
        content = 440,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [45] = {
        imgTween = {
            {imgId = 4, posId = 1},
            {imgId = 4, posId = 2, isDark = false, duration = 0.2},
            {imgId = 5, isDark = true}, {imgId = 1, duration = 0.2, posId = 1}
        },
        content = 450,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [46] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 4, isDark = true}},
        content = 460,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [47] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 5, isDark = true}},
        content = 470,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [48] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 4, isDark = true}},
        content = 480,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [49] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 5, isDark = true}},
        content = 490,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [50] = {
        content = 500,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [51] = {
        content = 510,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [52] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 4, isDark = true}},
        content = 520,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [53] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 5, isDark = true}},
        content = 530,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [54] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 4, isDark = true}},
        content = 540,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [55] = {
        imgTween = {
            {imgId = 4, duration = 0.2, posId = 1},
            {imgId = 1, duration = 0.2, posId = 2, isDark = false},
            {imgId = 5, isDark = true}
        },
        content = 550,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [56] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 1, isDark = true}},
        content = 560,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [57] = {
        content = 570,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [58] = {
        imgTween = {
            {imgId = 97, duration = 3, alpha = 0},
            {imgId = 5, duration = 2, alpha = 0},
            {imgId = 1, duration = 2, alpha = 0},
            {imgId = 98, duration = 3, alpha = 1, delay = 3}
        },
        audio = {bgm = {stop = true}}
    },
    [59] = {
        imgTween = {
            {imgId = 4, posId = 3, alpha = 0},
            {imgId = 4, duration = 0.5, posId = 3, alpha = 1, isDark = false}
        },
        content = 590,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 2,
        audio = {sfx = {cue = "AVG_AMB_Street", sheet = "AVG_gf", audioId = 1}}
    },
    [60] = {
        imgTween = {
            {imgId = 4, duration = 0.5, alpha = 0}, {imgId = 3, posId = 5},
            {imgId = 3, duration = 0.5, posId = 4, isDark = false}
        },
        content = 600,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [61] = {
        content = 610,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [62] = {
        content = 620,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [63] = {
        imgTween = {
            {imgId = 5, posId = 1}, {imgId = 5, posId = 2},
            {imgId = 3, isDark = true}
        },
        content = 630,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [64] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 5, isDark = true}},
        content = 640,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [65] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 3, isDark = true}},
        content = 650,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [66] = {
        imgTween = {{imgId = 5, isDark = true}},
        content = 660,
        contentType = 4,
        speakerName = 11
    },
    [67] = {
        imgTween = {{imgId = 5, isDark = false}},
        content = 670,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [68] = {
        content = 680,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [69] = {
        content = 690,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1
    },
    [70] = {
        imgTween = {
            {imgId = 4, posId = 5},
            {imgId = 4, posId = 4, isDark = false, duration = 0.2},
            {imgId = 5, isDark = true}, {imgId = 3, posId = 5, duration = 0.2}
        },
        content = 700,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [71] = {
        imgTween = {{imgId = 5, isDark = false}, {imgId = 4, isDark = true}},
        content = 710,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 1,
        audio = {
            bgm = {
                cue = "Mus_Story_BattleTension",
                sheet = "Music",
                fadeIn = 3,
                fadeOut = 4
            },
            stopAudioId = {1}
        }
    },
    [72] = {
        imgTween = {{imgId = 4, isDark = false}, {imgId = 5, isDark = true}},
        content = 720,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [73] = {
        content = 730,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [74] = {
        content = 740,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3,
        branch = {{content = 741, jumpAct = 75}, {content = 742, jumpAct = 76}}
    },
    [75] = {
        imgTween = {
            {imgId = 1, posId = 3, isDark = false},
            {imgId = 1, duration = 0.2, shake = true},
            {imgId = 4, duration = 0.1, posId = 5},
            {imgId = 5, duration = 0.1, posId = 1}
        },
        content = 750,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 2,
        nextId = 77,
        audio = {sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf", audioId = 0}}
    },
    [76] = {
        imgTween = {
            {imgId = 1, posId = 3, isDark = false},
            {imgId = 1, delay = 0.1, duration = 0.3, shake = true},
            {imgId = 1, delay = 0.3, isDark = true, alpha = 1},
            {imgId = 4, duration = 0.1, posId = 5},
            {imgId = 5, duration = 0.1, posId = 1}
        },
        content = 760,
        contentType = 2,
        audio = {sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf", audioId = 0}}
    },
    [77] = {
        imgTween = {
            {imgId = 1, duration = 0.2, posId = 2, isDark = true},
            {imgId = 4, duration = 0.2, posId = 4, isDark = false}
        },
        content = 770,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [78] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 4, isDark = true}},
        content = 780,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [79] = {
        imgTween = {{imgId = 1, isDark = true}},
        content = 790,
        contentType = 4,
        speakerName = 11
    },
    [80] = {
        imgTween = {{imgId = 1, isDark = false}},
        content = 800,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [81] = {
        imgTween = {
            {imgId = 5, posId = 5},
            {imgId = 5, posId = 4, isDark = false, duration = 0.2},
            {imgId = 1, isDark = true}
        },
        content = 810,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [82] = {
        content = 820,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [83] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 5, isDark = true}},
        content = 830,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [84] = {
        imgTween = {
            {imgId = 4, posId = 5},
            {imgId = 4, posId = 4, isDark = false, duration = 0.2},
            {imgId = 5, duration = 0.2, posId = 5}, {imgId = 1, isDark = true}
        },
        content = 840,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [85] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 4, isDark = true}},
        content = 850,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [86] = {
        imgTween = {
            {imgId = 5, posId = 5},
            {imgId = 5, posId = 4, isDark = false, duration = 0.2},
            {imgId = 4, duration = 0.2, posId = 5}, {imgId = 1, isDark = true}
        },
        content = 860,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt02_e_01_01

