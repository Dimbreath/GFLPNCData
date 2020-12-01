-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_08_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2, bgColor = 2, 
images = {
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg008", fullScreen = true}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 127, imgType = 3, alpha = 0, imgPath = "zion_avg"}
, 
{imgId = 24, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
, 
{imgId = 25, imgType = 3, alpha = 0, imgPath = "phus_avg"}
, 
{imgId = 23, imgType = 3, alpha = 0, imgPath = "choco_avg"}
, 
{imgId = 26, imgType = 3, alpha = 0, imgPath = "beelneith_avg"}
, 
{imgId = 14, imgType = 3, alpha = 0, imgPath = "helios_npc_02_avg"}
}
, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 26, delay = 0.2, duration = 0.5, shake = true}
}
, 
audio = {
sfx = {cue = "Skill_Abstinence_01_Hit", sheet = "Mon_Abstinence"}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 0.5, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[9] = {content = 90, contentType = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 3, fadeOut = 4}
}
}
, 
[11] = {content = 110, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = true}
}
}
, 
[12] = {content = 120, contentType = 4, speakerName = 111}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0.75, isDark = true}
, 
{imgId = 23, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0.75, isDark = false}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0.75, isDark = true}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[22] = {content = 220, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 4, delay = 0, duration = 0.6, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 2}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 25, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "Atk_Persicaria_01", sheet = "Chara_Persicaria"}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[43] = {content = 430, contentType = 2, 
imgTween = {
{imgId = 25, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
}
, 
[44] = {content = 440, contentType = 4, speakerName = 11}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[46] = {content = 460, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 4, speakerName = 111, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
, 
bgm = {stop = true}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[53] = {content = 530, contentType = 2, 
imgTween = {
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Sol_03", sheet = "Chara_Sol"}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2, 
imgTween = {
{imgId = 127, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Persicaria_01", sheet = "Chara_Persicaria"}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 26, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
}
return AvgCfg_cpt03_e_08_01

-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_08_01 = {
    [1] = {
        content = 10,
        contentType = 3,
        speakerHeroId = 23,
        speakerHeroPosId = 2,
        bgColor = 2,
        images = {
            {
                imgId = 3,
                imgType = 2,
                alpha = 0,
                imgPath = "cpt03/cpt03_e_bg008",
                fullScreen = true
            }, {
                imgId = 4,
                imgType = 2,
                alpha = 0,
                imgPath = "cpt03/cpt03_e_bg002",
                fullScreen = true
            },
            {imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"},
            {
                imgId = 105,
                imgType = 3,
                alpha = 0,
                imgPath = "croque_avg",
                rot = {0, 180, 0}
            }, {imgId = 127, imgType = 3, alpha = 0, imgPath = "zion_avg"},
            {imgId = 24, imgType = 3, alpha = 0, imgPath = "sisy_avg"},
            {imgId = 25, imgType = 3, alpha = 0, imgPath = "phus_avg"},
            {imgId = 23, imgType = 3, alpha = 0, imgPath = "choco_avg"},
            {imgId = 26, imgType = 3, alpha = 0, imgPath = "beelneith_avg"},
            {imgId = 14, imgType = 3, alpha = 0, imgPath = "helios_npc_02_avg"}
        },
        imgTween = {
            {imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false},
            {
                imgId = 23,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            }, {
                imgId = 23,
                delay = 0,
                duration = 0.6,
                posId = 3,
                alpha = 1,
                shake = true,
                isDark = false
            }
        },
        audio = {
            bgm = {
                cue = "Mus_Story_BattleTension",
                sheet = "Music",
                fadeIn = 2,
                fadeOut = 3
            }
        }
    },
    [2] = {
        content = 20,
        contentType = 3,
        speakerHeroId = 23,
        speakerHeroPosId = 2
    },
    [3] = {
        content = 30,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0,
                posId = 4,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            }
        }
    },
    [4] = {
        content = 40,
        contentType = 3,
        speakerHeroId = 23,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 26,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 0,
                isDark = true
            },
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 26,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 26,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = false
            }, {imgId = 26, delay = 0.2, duration = 0.5, shake = true}
        },
        audio = {
            sfx = {cue = "Skill_Abstinence_01_Hit", sheet = "Mon_Abstinence"}
        }
    },
    [6] = {
        content = 60,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 26,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0,
                posId = 2,
                alpha = 0,
                isDark = true
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 105,
                delay = 0,
                duration = 0,
                posId = 4,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            }
        }
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [8] = {
        content = 80,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 0,
                isDark = true
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0.5,
                isDark = false
            }
        },
        audio = {bgm = {stop = true}}
    },
    [9] = {
        content = 90,
        contentType = 2,
        imgTween = {
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0,
                isDark = false
            }
        }
    },
    [10] = {
        content = 100,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 24,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            }, {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0.75,
                isDark = false
            }
        },
        audio = {
            bgm = {
                cue = "Mus_Story_Sad",
                sheet = "Music",
                fadeIn = 3,
                fadeOut = 4
            }
        }
    },
    [11] = {
        content = 110,
        contentType = 4,
        speakerName = 111,
        imgTween = {
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0.75,
                isDark = true
            }
        }
    },
    [12] = {content = 120, contentType = 4, speakerName = 111},
    [13] = {
        content = 130,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0.75,
                isDark = false
            }
        }
    },
    [14] = {
        content = 140,
        contentType = 3,
        speakerHeroId = 23,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 0.75,
                isDark = true
            },
            {
                imgId = 23,
                delay = 0,
                duration = 0,
                posId = 4,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            }
        }
    },
    [15] = {
        content = 150,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            }, {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 0.75,
                isDark = false
            }
        }
    },
    [16] = {
        content = 160,
        contentType = 3,
        speakerHeroId = 23,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 0.75,
                isDark = true
            }
        }
    },
    [17] = {
        content = 170,
        contentType = 3,
        speakerHeroId = 23,
        speakerHeroPosId = 3
    },
    [18] = {
        content = 180,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [19] = {
        content = 190,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 23,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 0,
                isDark = true
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0,
                posId = 4,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = true
            }
        },
        audio = {
            sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
        }
    },
    [20] = {
        content = 200,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [21] = {
        content = 210,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1
    },
    [22] = {
        content = 220,
        contentType = 2,
        imgTween = {
            {
                imgId = 101,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 0,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 0,
                isDark = false
            },
            {imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false},
            {imgId = 4, delay = 0, duration = 0.6, alpha = 1, isDark = false}
        }
    },
    [23] = {content = 230, contentType = 2},
    [24] = {
        content = 240,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {imgId = 4, delay = 0, duration = 0.6, alpha = 0, isDark = false},
            {imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false},
            {
                imgId = 24,
                delay = 0,
                duration = 0,
                posId = 2,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 25,
                delay = 0,
                duration = 0,
                posId = 4,
                alpha = 0,
                isDark = true
            },
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            }
        }
    },
    [25] = {
        content = 250,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = true
            }
        }
    },
    [26] = {
        content = 260,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [27] = {
        content = 270,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1
    },
    [28] = {
        content = 280,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1
    },
    [29] = {
        content = 290,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1
    },
    [30] = {
        content = 300,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = true
            }
        }
    },
    [31] = {
        content = 310,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3
    },
    [32] = {
        content = 320,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3
    },
    [33] = {
        content = 330,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [34] = {
        content = 340,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = true
            }
        }
    },
    [35] = {
        content = 350,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3
    },
    [36] = {
        content = 360,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3
    },
    [37] = {
        content = 370,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [38] = {
        content = 380,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1
    },
    [39] = {
        content = 390,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        audio = {sfx = {cue = "Atk_Persicaria_01", sheet = "Chara_Persicaria"}}
    },
    [40] = {
        content = 400,
        contentType = 3,
        speakerHeroId = 25,
        speakerHeroPosId = 3,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = false
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = true
            }
        }
    },
    [41] = {
        content = 410,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 1,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 1,
                isDark = false
            }
        }
    },
    [42] = {
        content = 420,
        contentType = 3,
        speakerHeroId = 24,
        speakerHeroPosId = 1
    },
    [43] = {
        content = 430,
        contentType = 2,
        imgTween = {
            {
                imgId = 25,
                delay = 0,
                duration = 0.2,
                posId = 4,
                alpha = 0,
                isDark = true
            },
            {
                imgId = 24,
                delay = 0,
                duration = 0.2,
                posId = 2,
                alpha = 0,
                isDark = false
            }
        },
        audio = {sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}}
    },
    [44] = {content = 440, contentType = 4, speakerName = 11},
    [45] = {
        content = 450,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = false
            }
        }
    },
    [46] = {
        content = 460,
        contentType = 4,
        speakerName = 111,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = true
            }
        }
    },
    [47] = {
        content = 470,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = false
            }
        }
    },
    [48] = {
        content = 480,
        contentType = 4,
        speakerName = 111,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = true
            }
        }
    },
    [49] = {
        content = 490,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = false
            }
        }
    },
    [50] = {
        content = 500,
        contentType = 3,
        speakerHeroId = 26,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 105,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 26,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 26,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = false
            }
        },
        audio = {
            sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"},
            bgm = {stop = true}
        }
    },
    [51] = {
        content = 510,
        contentType = 3,
        speakerHeroId = 26,
        speakerHeroPosId = 2
    },
    [52] = {
        content = 520,
        contentType = 3,
        speakerHeroId = 26,
        speakerHeroPosId = 2,
        audio = {
            bgm = {
                cue = "Mus_Story_BattleTension",
                sheet = "Music",
                fadeIn = 2,
                fadeOut = 3
            }
        }
    },
    [53] = {
        content = 530,
        contentType = 2,
        imgTween = {
            {
                imgId = 26,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0,
                isDark = false
            }
        },
        audio = {sfx = {cue = "Atk_Sol_03", sheet = "Chara_Sol"}}
    },
    [54] = {
        content = 540,
        contentType = 3,
        speakerHeroId = 1027,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 127,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 127,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = false
            }
        },
        audio = {sfx = {cue = "Atk_Persicaria_01", sheet = "Chara_Persicaria"}}
    },
    [55] = {
        content = 550,
        contentType = 3,
        speakerHeroId = 26,
        speakerHeroPosId = 2,
        imgTween = {
            {
                imgId = 127,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 26,
                delay = 0,
                duration = 0,
                posId = 3,
                alpha = 0,
                isDark = false
            },
            {
                imgId = 26,
                delay = 0,
                duration = 0.2,
                posId = 3,
                alpha = 1,
                isDark = false
            }
        }
    }
}
return AvgCfg_cpt03_e_08_01

