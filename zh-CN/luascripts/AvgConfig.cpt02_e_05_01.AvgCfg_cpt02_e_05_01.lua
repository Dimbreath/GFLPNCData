-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_05_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg002", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg003", fullScreen = true}
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
{imgId = 13, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "betty_avg"}
, 
{imgId = 34, imgType = 3, alpha = 0, imgPath = "abigail_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "arrow_avg"}
, 
{imgId = 102, imgType = 3, 
rot = {0, 180, 0}
, alpha = 0, imgPath = "cyclopes_npc_02_avg"}
, 
{imgId = 103, imgType = 3, 
rot = {0, 180, 0}
, alpha = 0, imgPath = "cyclopes_npc_03_avg"}
}
, 
imgTween = {
{imgId = 102, posId = 1}
, 
{imgId = 98, duration = 1, alpha = 1}
, 
{imgId = 102, duration = 0.5, delay = 1, posId = 2}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
}
, content = 10, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 1}
, 
[2] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, duration = 0.2, posId = 4}
, 
{imgId = 102, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[3] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 102, duration = 0.5, shake = true}
}
, content = 40, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 1}
, 
[5] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[7] = {
imgTween = {
{imgId = 103, duration = 0.5, posId = 5}
, 
{imgId = 102, duration = 0.5, posId = 1}
, 
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
}
, content = 70, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[8] = {
imgTween = {
{imgId = 3, isDark = true}
}
, content = 80, contentType = 4, speakerName = 11}
, 
[9] = {
imgTween = {
{imgId = 3, isDark = false}
}
, content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[10] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
}
, content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[11] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 110, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[12] = {
imgTween = {
{imgId = 3, isDark = true}
}
, content = 120, contentType = 4, speakerName = 11}
, 
[13] = {
imgTween = {
{imgId = 3, isDark = false}
}
, content = 130, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[14] = {
imgTween = {
{imgId = 3, isDark = true}
}
, content = 140, contentType = 4, speakerName = 11}
, 
[15] = {
imgTween = {
{imgId = 4, posId = 1}
, 
{imgId = 4, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[16] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 4, posId = 1, isDark = false, duration = 0.2}
}
, content = 160, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[17] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[18] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 180, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[19] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[20] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[21] = {
imgTween = {
{imgId = 4, posId = 1}
, 
{imgId = 4, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 210, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 4, duration = 0.5, posId = 1}
, 
{imgId = 1, duration = 0.5, posId = 5}
, 
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2, delay = 0.5}
}
, content = 230, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[25] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 260, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[28] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[29] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 3, posId = 1, isDark = false, duration = 0.2}
}
, content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[31] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[32] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 320, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[34] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 340, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 3}
, 
[36] = {
imgTween = {
{imgId = 101, duration = 0.2, posId = 5}
, 
{imgId = 2, duration = 0.2, posId = 1}
}
, content = 360, contentType = 4, speakerName = 361}
, 
[37] = {
imgTween = {
{imgId = 2, duration = 0.2, posId = 2, isDark = false}
}
, content = 370, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[38] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[39] = {
imgTween = {
{imgId = 4, duration = 0.2, posId = 5}
, 
{imgId = 2, isDark = false}
}
, content = 390, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf", audioId = 0}
}
}
, 
[40] = {
imgTween = {
{imgId = 2, duration = 0.2, posId = 1}
, 
{imgId = 98, duration = 2, alpha = 0}
, 
{imgId = 98, duration = 2, delay = 2, alpha = 1}
}
}
, 
[41] = {
imgTween = {
{imgId = 98, duration = 0.5, shake = true}
, 
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, delay = 0.5, isDark = false, duration = 0.2}
}
, content = 410, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol", audioId = 1}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
}
, content = 430, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[44] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 13, posId = 1}
, 
{imgId = 13, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 450, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 34, posId = 1}
, 
{imgId = 34, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 13, posId = 1, isDark = false, duration = 0.2}
}
, content = 460, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 1}
, 
[47] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 34, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 13, posId = 1}
, 
{imgId = 13, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 34, posId = 1, isDark = false, duration = 0.2}
}
, content = 480, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 13, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 13, posId = 1, isDark = false, duration = 0.2}
}
, content = 500, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[51] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 13, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 13, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 520, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[55] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[57] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 570, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[58] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 580, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[59] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 590, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[60] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 600, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[63] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 630, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 650, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[70] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 700, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[71] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 710, contentType = 4, speakerName = 11}
, 
[72] = {
imgTween = {
{imgId = 2, isDark = false}
}
, content = 720, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[73] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 730, contentType = 4, speakerName = 11}
, 
[74] = {
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[75] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 750, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[76] = {
images = {
{imgId = 401, imgType = 3, alpha = 1, 
pos = {430, -250, 0}
, 
rot = {0, 180, 0}
, imgPath = "simo_avg", comm = true}
}
, 
imgTween = {
{imgId = 2, alpha = 0}
}
, content = 760, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[77] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 401, isDark = true}
}
, content = 770, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[78] = {
imgTween = {
{imgId = 401, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
}
return AvgCfg_cpt02_e_05_01

-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_05_01 = {
    [1] = {
        bgColor = 2,
        images = {
            {
                imgId = 97,
                imgType = 2,
                alpha = 0,
                imgPath = "cpt02/cpt02_e_bg002",
                fullScreen = true
            }, {
                imgId = 98,
                imgType = 2,
                alpha = 0,
                imgPath = "cpt02/cpt02_e_bg003",
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
            },
            {
                imgId = 13,
                imgType = 3,
                alpha = 0,
                rot = {0, 180, 0},
                imgPath = "betty_avg"
            }, {imgId = 34, imgType = 3, alpha = 0, imgPath = "abigail_avg"},
            {
                imgId = 101,
                imgType = 3,
                alpha = 0,
                rot = {0, 180, 0},
                imgPath = "arrow_avg"
            }, {
                imgId = 102,
                imgType = 3,
                rot = {0, 180, 0},
                alpha = 0,
                imgPath = "cyclopes_npc_02_avg"
            }, {
                imgId = 103,
                imgType = 3,
                rot = {0, 180, 0},
                alpha = 0,
                imgPath = "cyclopes_npc_03_avg"
            }
        },
        imgTween = {
            {imgId = 102, posId = 1}, {imgId = 98, duration = 1, alpha = 1},
            {imgId = 102, duration = 0.5, delay = 1, posId = 2}
        },
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}},
        content = 10,
        contentType = 3,
        speakerHeroId = 14,
        speakerHeroPosId = 1
    },
    [2] = {
        imgTween = {
            {imgId = 103, posId = 5}, {imgId = 103, duration = 0.2, posId = 4},
            {imgId = 102, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 14,
        speakerHeroPosId = 3
    },
    [3] = {
        imgTween = {{imgId = 102, isDark = false}, {imgId = 103, isDark = true}},
        content = 30,
        contentType = 3,
        speakerHeroId = 14,
        speakerHeroPosId = 1
    },
    [4] = {
        imgTween = {{imgId = 102, duration = 0.5, shake = true}},
        content = 40,
        contentType = 3,
        speakerHeroId = 14,
        speakerHeroPosId = 1
    },
    [5] = {
        imgTween = {{imgId = 103, isDark = false}, {imgId = 102, isDark = true}},
        content = 50,
        contentType = 3,
        speakerHeroId = 14,
        speakerHeroPosId = 3
    },
    [6] = {
        content = 60,
        contentType = 3,
        speakerHeroId = 14,
        speakerHeroPosId = 3
    },
    [7] = {
        imgTween = {
            {imgId = 103, duration = 0.5, posId = 5},
            {imgId = 102, duration = 0.5, posId = 1}, {imgId = 3, posId = 5},
            {imgId = 3, posId = 4, isDark = false, duration = 0.2}
        },
        content = 70,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [8] = {
        imgTween = {{imgId = 3, isDark = true}},
        content = 80,
        contentType = 4,
        speakerName = 11
    },
    [9] = {
        imgTween = {{imgId = 3, isDark = false}},
        content = 90,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [10] = {
        imgTween = {
            {imgId = 1, posId = 1},
            {imgId = 1, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true}
        },
        content = 100,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [11] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 1, isDark = true}},
        content = 110,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [12] = {
        imgTween = {{imgId = 3, isDark = true}},
        content = 120,
        contentType = 4,
        speakerName = 11
    },
    [13] = {
        imgTween = {{imgId = 3, isDark = false}},
        content = 130,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [14] = {
        imgTween = {{imgId = 3, isDark = true}},
        content = 140,
        contentType = 4,
        speakerName = 11
    },
    [15] = {
        imgTween = {
            {imgId = 4, posId = 1},
            {imgId = 4, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true},
            {imgId = 1, posId = 1, isDark = false, duration = 0.2}
        },
        content = 150,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [16] = {
        imgTween = {
            {imgId = 2, posId = 1},
            {imgId = 2, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true},
            {imgId = 4, posId = 1, isDark = false, duration = 0.2}
        },
        content = 160,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [17] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 170,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [18] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 180,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [19] = {
        imgTween = {
            {imgId = 1, posId = 5},
            {imgId = 1, posId = 4, isDark = false, duration = 0.2},
            {imgId = 2, isDark = true},
            {imgId = 3, posId = 5, isDark = false, duration = 0.2}
        },
        content = 190,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3
    },
    [20] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 1, isDark = true}},
        content = 200,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [21] = {
        imgTween = {
            {imgId = 4, posId = 1},
            {imgId = 4, posId = 2, isDark = false, duration = 0.2},
            {imgId = 1, isDark = true},
            {imgId = 2, posId = 1, isDark = false, duration = 0.2}
        },
        content = 210,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [22] = {
        content = 220,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 1
    },
    [23] = {
        imgTween = {
            {imgId = 4, duration = 0.5, posId = 1},
            {imgId = 1, duration = 0.5, posId = 5}, {imgId = 101, posId = 5},
            {
                imgId = 101,
                posId = 4,
                isDark = false,
                duration = 0.2,
                delay = 0.5
            }
        },
        content = 230,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [24] = {
        content = 240,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [25] = {
        imgTween = {
            {imgId = 1, posId = 1},
            {imgId = 1, posId = 2, isDark = false, duration = 0.2},
            {imgId = 101, isDark = true}
        },
        content = 250,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [26] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 260,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [27] = {
        content = 270,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [28] = {
        imgTween = {
            {imgId = 3, posId = 1},
            {imgId = 3, posId = 2, isDark = false, duration = 0.2},
            {imgId = 101, isDark = true},
            {imgId = 1, posId = 1, isDark = false, duration = 0.2}
        },
        content = 280,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 1
    },
    [29] = {
        imgTween = {
            {imgId = 1, posId = 1},
            {imgId = 1, posId = 2, isDark = false, duration = 0.2},
            {imgId = 101, isDark = true},
            {imgId = 3, posId = 1, isDark = false, duration = 0.2}
        },
        content = 290,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [30] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 300,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [31] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 101, isDark = true}},
        content = 310,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [32] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 1, isDark = true}},
        content = 320,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [34] = {
        imgTween = {
            {imgId = 2, posId = 1},
            {imgId = 2, posId = 2, isDark = false, duration = 0.2},
            {imgId = 101, isDark = true},
            {imgId = 1, posId = 1, isDark = false, duration = 0.2}
        },
        content = 340,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [35] = {
        imgTween = {{imgId = 101, isDark = false}, {imgId = 2, isDark = true}},
        content = 350,
        contentType = 3,
        speakerHeroId = 20,
        speakerHeroPosId = 3
    },
    [36] = {
        imgTween = {
            {imgId = 101, duration = 0.2, posId = 5},
            {imgId = 2, duration = 0.2, posId = 1}
        },
        content = 360,
        contentType = 4,
        speakerName = 361
    },
    [37] = {
        imgTween = {{imgId = 2, duration = 0.2, posId = 2, isDark = false}},
        content = 370,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [38] = {
        imgTween = {
            {imgId = 4, posId = 5},
            {imgId = 4, posId = 4, isDark = false, duration = 0.2},
            {imgId = 2, isDark = true}
        },
        content = 380,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [39] = {
        imgTween = {
            {imgId = 4, duration = 0.2, posId = 5}, {imgId = 2, isDark = false}
        },
        content = 390,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1,
        audio = {sfx = {cue = "AVG_RunStep", sheet = "AVG_gf", audioId = 0}}
    },
    [40] = {
        imgTween = {
            {imgId = 2, duration = 0.2, posId = 1},
            {imgId = 98, duration = 2, alpha = 0},
            {imgId = 98, duration = 2, delay = 2, alpha = 1}
        }
    },
    [41] = {
        imgTween = {
            {imgId = 98, duration = 0.5, shake = true}, {imgId = 3, posId = 5},
            {imgId = 3, posId = 4, delay = 0.5, isDark = false, duration = 0.2}
        },
        content = 410,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3,
        audio = {
            sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol", audioId = 1}
        }
    },
    [42] = {
        content = 420,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [43] = {
        imgTween = {
            {imgId = 2, posId = 1},
            {imgId = 2, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true}
        },
        content = 430,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [44] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 440,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [45] = {
        imgTween = {
            {imgId = 13, posId = 1},
            {imgId = 13, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true},
            {imgId = 2, posId = 1, isDark = false, duration = 0.2}
        },
        content = 450,
        contentType = 3,
        speakerHeroId = 1013,
        speakerHeroPosId = 1
    },
    [46] = {
        imgTween = {
            {imgId = 34, posId = 1},
            {imgId = 34, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true},
            {imgId = 13, posId = 1, isDark = false, duration = 0.2}
        },
        content = 460,
        contentType = 3,
        speakerHeroId = 1034,
        speakerHeroPosId = 1
    },
    [47] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 34, isDark = true}},
        content = 470,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [48] = {
        imgTween = {
            {imgId = 13, posId = 1},
            {imgId = 13, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true},
            {imgId = 34, posId = 1, isDark = false, duration = 0.2}
        },
        content = 480,
        contentType = 3,
        speakerHeroId = 1013,
        speakerHeroPosId = 1
    },
    [49] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 13, isDark = true}},
        content = 490,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [50] = {
        imgTween = {
            {imgId = 2, posId = 1},
            {imgId = 2, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true},
            {imgId = 13, posId = 1, isDark = false, duration = 0.2}
        },
        content = 500,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [51] = {
        imgTween = {
            {imgId = 1, posId = 1},
            {imgId = 1, posId = 2, isDark = false, duration = 0.2},
            {imgId = 13, isDark = true},
            {imgId = 2, posId = 1, isDark = false, duration = 0.2}
        },
        content = 510,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [52] = {
        imgTween = {
            {imgId = 2, posId = 1},
            {imgId = 2, posId = 2, isDark = false, duration = 0.2},
            {imgId = 13, isDark = true},
            {imgId = 1, posId = 1, isDark = false, duration = 0.2}
        },
        content = 520,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [53] = {
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
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 550,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [56] = {
        content = 560,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [57] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 570,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [58] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 580,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [59] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 590,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [60] = {
        imgTween = {{imgId = 3, isDark = false}, {imgId = 2, isDark = true}},
        content = 600,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [61] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 3, isDark = true}},
        content = 610,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [62] = {
        content = 620,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 1
    },
    [63] = {
        imgTween = {
            {imgId = 1, posId = 1},
            {imgId = 1, posId = 2, isDark = false, duration = 0.2},
            {imgId = 3, isDark = true},
            {imgId = 2, posId = 1, isDark = false, duration = 0.2}
        },
        content = 630,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [64] = {
        content = 640,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [65] = {
        imgTween = {
            {imgId = 2, posId = 5},
            {imgId = 2, posId = 4, isDark = false, duration = 0.2},
            {imgId = 1, isDark = true},
            {imgId = 3, posId = 5, isDark = false, duration = 0.2}
        },
        content = 650,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [66] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 2, isDark = true}},
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
        content = 680,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [69] = {
        content = 690,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [70] = {
        imgTween = {{imgId = 2, isDark = false}, {imgId = 1, isDark = true}},
        content = 700,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [71] = {
        imgTween = {{imgId = 2, isDark = true}},
        content = 710,
        contentType = 4,
        speakerName = 11
    },
    [72] = {
        imgTween = {{imgId = 2, isDark = false}},
        content = 720,
        contentType = 3,
        speakerHeroId = 1002,
        speakerHeroPosId = 3
    },
    [73] = {
        imgTween = {{imgId = 2, isDark = true}},
        content = 730,
        contentType = 4,
        speakerName = 11
    },
    [74] = {audio = {sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}}},
    [75] = {
        imgTween = {{imgId = 1, isDark = false}},
        content = 750,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [76] = {
        images = {
            {
                imgId = 401,
                imgType = 3,
                alpha = 1,
                pos = {430, -250, 0},
                rot = {0, 180, 0},
                imgPath = "simo_avg",
                comm = true
            }
        },
        imgTween = {{imgId = 2, alpha = 0}},
        content = 760,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    },
    [77] = {
        imgTween = {{imgId = 1, isDark = false}, {imgId = 401, isDark = true}},
        content = 770,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [78] = {
        imgTween = {{imgId = 401, isDark = false}, {imgId = 1, isDark = true}},
        content = 780,
        contentType = 3,
        speakerHeroId = 1004,
        speakerHeroPosId = 3
    }
}
return AvgCfg_cpt02_e_05_01

