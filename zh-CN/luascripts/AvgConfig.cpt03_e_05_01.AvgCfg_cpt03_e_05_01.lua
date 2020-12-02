-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_05_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg002", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 27, imgType = 3, alpha = 0, imgPath = "zion_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "choco_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "beelneith_avg"}
}
, 
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
, 
{imgId = 102, duration = 1, alpha = 1}
}
, content = 10, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 4}
}
}
, 
[2] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
, 
{imgId = 5, posId = 3, alpha = 0}
, 
{imgId = 5, duration = 0.2, alpha = 1}
}
, content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[3] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 1}
, 
{imgId = 5, duration = 0.2, alpha = 0}
}
, content = 30, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[8] = {
imgTween = {
{imgId = 102, duration = 0.2, 
scale = {1.2, 1.2, 1.2}
}
, 
{imgId = 102, duration = 0.5, delay = 0.3, shake = true}
, 
{imgId = 102, delay = 1, isDark = true}
}
, content = 80, contentType = 2, 
audio = {
sfx = {cue = "AVG_Door_Hit", sheet = "AVG_gf", audioId = 0}
}
}
, 
[9] = {
imgTween = {
{imgId = 102, duration = 0.2, 
scale = {1, 1, 1}
, 
pos = {100, -150, 0}
, alpha = 0}
, 
{imgId = 27, posId = 2}
, 
{imgId = 27, posId = 3, isDark = false, duration = 0.2}
}
, content = 90, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "Atk_Croque_01", sheet = "Chara_Croque"}
}
}
, 
[10] = {
imgTween = {
{imgId = 102, duration = 0.2, 
pos = {-180, -150, 0}
, alpha = 1, isDark = false}
, 
{imgId = 27, duration = 0.2, alpha = 0}
}
, content = 100, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[12] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
}
, content = 120, contentType = 2}
, 
[13] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 130, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[14] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
, 
{imgId = 1, posId = 3, alpha = 0}
, 
{imgId = 1, duration = 0.2, alpha = 1}
}
, content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[15] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 1, isDark = true}
, 
{imgId = 1, duration = 0.2, alpha = 0}
}
, content = 150, contentType = 2}
, 
[16] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 160, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[17] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
, 
{imgId = 1, duration = 0.2, alpha = 1}
}
, content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[18] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 1}
, 
{imgId = 1, duration = 0.2, alpha = 0}
}
, content = 180, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
audio = {
bgm = {stop = true}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[23] = {
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0, 
pos = {180, -150, 0}
}
, 
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[24] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 4}
}
}
, 
[25] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[26] = {
imgTween = {
{imgId = 27, posId = 5}
, 
{imgId = 27, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 260, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[27] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 27, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[31] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[32] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 1, duration = 0.2, alpha = 0}
, 
{imgId = 27, duration = 0.2, alpha = 0}
, 
{imgId = 97, duration = 0.5, delay = 0.5, alpha = 1}
}
}
, 
[33] = {
imgTween = {
{imgId = 1, duration = 0.2, alpha = 1}
}
, content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf", audioId = 0}
}
}
, 
[34] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[35] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 350, contentType = 4, speakerName = 11}
, 
[36] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 370, contentType = 4, speakerName = 11}
, 
[38] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[39] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[40] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 420, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[45] = {
imgTween = {
{imgId = 27, posId = 5}
, 
{imgId = 27, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 450, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[46] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 27, posId = 5, isDark = false, duration = 0.2}
}
, content = 480, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
branch = {
{content = 491, jumpAct = 50}
, 
{content = 492, jumpAct = 52}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, nextId = 53}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[53] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[55] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 560, contentType = 4, speakerName = 11}
, 
[57] = {
imgTween = {
{imgId = 5, isDark = false}
}
, content = 570, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[62] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 620, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
branch = {
{content = 641, jumpAct = 65}
, 
{content = 642, jumpAct = 68}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, nextId = 71}
, 
[68] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[71] = {
imgTween = {
{imgId = 1, isDark = false, duration = 0.5, alpha = 0}
, 
{imgId = 5, isDark = false, duration = 0.5, alpha = 0}
, 
{imgId = 97, duration = 0.5, alpha = 0}
}
, content = 710, contentType = 2}
, 
[72] = {
imgTween = {
{imgId = 27, delay = 0.5, duration = 0.5, posId = 4}
, 
{imgId = 97, duration = 0.5, alpha = 1}
}
, content = 720, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[73] = {
imgTween = {
{imgId = 27, isDark = true}
}
, content = 730, contentType = 4, speakerName = 12, 
audio = {
sfx = {cue = "AVG_ElecSpace", sheet = "AVG_gf", audioId = 1}
}
}
, 
[74] = {
imgTween = {
{imgId = 27, duration = 0.2, posId = 5}
, 
{imgId = 5, duration = 0.2, posId = 4}
}
, content = 740, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[75] = {
imgTween = {
{imgId = 1, duration = 0.2, alpha = 1}
, 
{imgId = 5, isDark = true}
}
, content = 750, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[76] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 760, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[77] = {content = 770, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[78] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
}
return AvgCfg_cpt03_e_05_01

