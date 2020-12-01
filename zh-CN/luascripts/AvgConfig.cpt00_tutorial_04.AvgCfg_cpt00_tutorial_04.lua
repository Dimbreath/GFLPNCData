-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_tutorial_04 = {
[1] = {
images = {
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg", order = 2}
, 
{imgId = 5, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "croque_avg"}
}
, 
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[2] = {
images = {
{imgId = 99, imgPath = "cpt00/cpt00_e_bg001", imgType = 4, alpha = 0, fullScreen = true}
}
, 
imgTween = {
{imgId = 99, duration = 0.7, alpha = 0.2}
, 
{imgId = 99, delay = 0.7, duration = 0.7, alpha = 0}
}
, content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 99, duration = 0.7, alpha = 0.4}
, 
{imgId = 99, delay = 0.7, duration = 0.7, alpha = 0}
}
, content = 30, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, duration = 0.2, posId = 4}
, 
{imgId = 1, isDark = true}
}
, content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 5, duration = 0.6, alpha = 0}
, 
{imgId = 1, isDark = false}
}
, content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[6] = {customCode = "AvgUtil.ChangeUltSkillOrder(true)", content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[8] = {customCode = "AvgUtil.ChangeUltSkillOrder(false)", autoContinue = true}
}
return AvgCfg_cpt00_tutorial_04

-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_tutorial_04 = {
    [1] = {
        images = {
            {
                imgId = 1,
                imgType = 3,
                alpha = 0,
                imgPath = "persicaria_avg",
                order = 2
            },
            {
                imgId = 5,
                imgType = 3,
                alpha = 0,
                rot = {0, 180, 0},
                imgPath = "croque_avg"
            }
        },
        imgTween = {
            {imgId = 1, posId = 1}, {imgId = 1, duration = 0.2, posId = 2}
        },
        content = 10,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [2] = {
        images = {
            {
                imgId = 99,
                imgPath = "cpt00/cpt00_e_bg001",
                imgType = 4,
                alpha = 0,
                fullScreen = true
            }
        },
        imgTween = {
            {imgId = 99, duration = 0.7, alpha = 0.2},
            {imgId = 99, delay = 0.7, duration = 0.7, alpha = 0}
        },
        content = 20,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [3] = {
        imgTween = {
            {imgId = 99, duration = 0.7, alpha = 0.4},
            {imgId = 99, delay = 0.7, duration = 0.7, alpha = 0}
        },
        content = 30,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [4] = {
        imgTween = {
            {imgId = 5, posId = 5}, {imgId = 5, duration = 0.2, posId = 4},
            {imgId = 1, isDark = true}
        },
        content = 40,
        contentType = 3,
        speakerHeroId = 1005,
        speakerHeroPosId = 3
    },
    [5] = {
        imgTween = {
            {imgId = 5, duration = 0.6, alpha = 0}, {imgId = 1, isDark = false}
        },
        content = 50,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [6] = {
        customCode = "AvgUtil.ChangeUltSkillOrder(true)",
        content = 60,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [7] = {
        content = 70,
        contentType = 3,
        speakerHeroId = 1001,
        speakerHeroPosId = 1
    },
    [8] = {
        customCode = "AvgUtil.ChangeUltSkillOrder(false)",
        autoContinue = true
    }
}
return AvgCfg_cpt00_tutorial_04

