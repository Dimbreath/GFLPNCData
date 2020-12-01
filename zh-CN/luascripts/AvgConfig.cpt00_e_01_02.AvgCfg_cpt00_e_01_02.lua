-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_02 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 1, order = 1, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, order = 1, imgPath = "cpt00/cpt00_e_bg008", 
scale = {1.5, 1.5, 1.5}
, 
pos = {500, -100, 0}
, fullScreen = true}
, 
{imgId = 1, imgType = 3, order = 2, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, order = 1, imgPath = "sol_avg"}
}
, 
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, duration = 0.2, posId = 4}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
}
, content = 10, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[2] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2}
, 
{imgId = 3, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 3, isDark = true}
}
, content = 30, contentType = 4, speakerName = 11}
, 
[4] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[6] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 60, contentType = 4, speakerName = 11}
, 
[7] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[9] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 3, isDark = false}
}
, content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[10] = {
imgTween = {
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 3, duration = 0.5, alpha = 0}
}
, content = 100, contentType = 4, speakerName = 15}
, 
[11] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 97, duration = 0.5, alpha = 1}
, 
{imgId = 97, duration = 1.5, delay = 0.6, 
pos = {-500, -100, 0}
}
, 
{imgId = 97, duration = 1.5, delay = 2.2, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Explosion", sheet = "AVG_gf"}
}
, content = 110, contentType = 2}
, 
[12] = {
imgTween = {
{imgId = 97, duration = 1, 
pos = {0, 100, 0}
}
}
, content = 120, contentType = 4, speakerName = 12}
, 
[13] = {content = 130, contentType = 4, speakerName = 14}
, 
[14] = {content = 140, contentType = 4, speakerName = 14}
, 
[15] = {content = 150, contentType = 4, speakerName = 13}
, 
[16] = {content = 160, contentType = 4, speakerName = 13}
, 
[17] = {content = 170, contentType = 4, speakerName = 14}
, 
[18] = {content = 180, contentType = 4, speakerName = 14}
, 
[19] = {
imgTween = {
{imgId = 97, duration = 1, 
pos = {0, 0, 0}
, 
scale = {1, 1, 1}
}
}
, content = 190, contentType = 4, speakerName = 14}
, 
[20] = {content = 200, contentType = 4, speakerName = 12}
}
return AvgCfg_cpt00_e_01_02

-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_02 = {
    [1] = {
        bgColor = 2,
        images = {
            {
                imgId = 98,
                imgType = 2,
                alpha = 1,
                order = 1,
                imgPath = "cpt00/cpt00_e_bg005",
                fullScreen = true
            }, {
                imgId = 97,
                imgType = 2,
                alpha = 0,
                order = 1,
                imgPath = "cpt00/cpt00_e_bg008",
                scale = {1.5, 1.5, 1.5},
                pos = {500, -100, 0},
                fullScreen = true
            },
            {
                imgId = 1,
                imgType = 3,
                order = 2,
                alpha = 0,
                imgPath = "persicaria_avg"
            },
            {imgId = 3, imgType = 3, alpha = 0, order = 1, imgPath = "sol_avg"}
        },
        imgTween = {
            {imgId = 3, posId = 5}, {imgId = 3, duration = 0.2, posId = 4}
        },
        audio = {bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}},
        content = 10,
        contentType = 3,
        speakerHeroId = 1003,
        speakerHeroPosId = 3
    },
    [2] = {
        imgTween = {
            {imgId = 1, posId = 1}, {imgId = 1, duration = 0.2, posId = 2},
            {imgId = 3, isDark = true}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [3] = {
        imgTween = {{imgId = 1, isDark = true}, {imgId = 3, isDark = true}},
        content = 30,
        contentType = 4,
        speakerName = 11
    },
    [4] = {
        imgTween = {{imgId = 1, isDark = false}},
        content = 40,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [5] = {
        content = 50,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [6] = {
        imgTween = {{imgId = 1, isDark = true}},
        content = 60,
        contentType = 4,
        speakerName = 11
    },
    [7] = {
        imgTween = {{imgId = 1, isDark = false}},
        content = 70,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [8] = {
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
            {imgId = 1, duration = 0.5, alpha = 0},
            {imgId = 3, duration = 0.5, alpha = 0}
        },
        content = 100,
        contentType = 4,
        speakerName = 15
    },
    [11] = {
        imgTween = {
            {imgId = 98, duration = 0.5, alpha = 0},
            {imgId = 97, duration = 0.5, alpha = 1},
            {imgId = 97, duration = 1.5, delay = 0.6, pos = {-500, -100, 0}},
            {imgId = 97, duration = 1.5, delay = 2.2, shake = true}
        },
        audio = {sfx = {cue = "AVG_Explosion", sheet = "AVG_gf"}},
        content = 110,
        contentType = 2
    },
    [12] = {
        imgTween = {{imgId = 97, duration = 1, pos = {0, 100, 0}}},
        content = 120,
        contentType = 4,
        speakerName = 12
    },
    [13] = {content = 130, contentType = 4, speakerName = 14},
    [14] = {content = 140, contentType = 4, speakerName = 14},
    [15] = {content = 150, contentType = 4, speakerName = 13},
    [16] = {content = 160, contentType = 4, speakerName = 13},
    [17] = {content = 170, contentType = 4, speakerName = 14},
    [18] = {content = 180, contentType = 4, speakerName = 14},
    [19] = {
        imgTween = {
            {imgId = 97, duration = 1, pos = {0, 0, 0}, scale = {1, 1, 1}}
        },
        content = 190,
        contentType = 4,
        speakerName = 14
    },
    [20] = {content = 200, contentType = 4, speakerName = 12}
}
return AvgCfg_cpt00_e_01_02

