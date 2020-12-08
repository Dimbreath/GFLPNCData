-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_03_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg002", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 4, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 12, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "adele_avg"}
}
, 
imgTween = {
{imgId = 99, duration = 1, alpha = 1}
, 
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, duration = 0.2, delay = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[2] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[3] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 40, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1, contentShake = true}
, 
[6] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 60, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[9] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 90, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[11] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 110, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[12] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 12, duration = 0.1, shake = true}
, 
{imgId = 3, isDark = true}
}
, content = 120, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[13] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[15] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[16] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[17] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 170, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 12, isDark = true}
}
, content = 230, contentType = 4, speakerName = 11}
, 
[24] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[25] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 12, posId = 1, isDark = false, duration = 0.2}
}
, content = 250, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[26] = {
imgTween = {
{imgId = 3, posId = 1, duration = 0.2}
, 
{imgId = 1, posId = 5, duration = 0.2}
, 
{imgId = 101, posId = 3, isDark = true}
}
, content = 260, contentType = 2}
, 
[27] = {
imgTween = {
{imgId = 12, posId = 2, duration = 0.2}
, 
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[28] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[29] = {
imgTween = {
{imgId = 101, posId = 3, duration = 1}
, 
{imgId = 12, posId = 1, duration = 0.2}
, 
{imgId = 101, delay = 1, duration = 0.2, isDark = true}
}
, content = 290, contentType = 2}
, 
[30] = {
imgTween = {
{imgId = 12, posId = 3, alpha = 0}
, 
{imgId = 12, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 101, duration = 0.2, alpha = 0}
}
, content = 300, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
, 
[31] = {
imgTween = {
{imgId = 1, posId = 3, alpha = 0}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 12, duration = 0.2, alpha = 0}
}
, content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[34] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 340, contentType = 4, speakerName = 11}
, 
[35] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[36] = {
audio = {
bgm = {stop = true}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[37] = {
imgTween = {
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 101, duration = 0.5, alpha = 1, isDark = false}
}
, content = 370, contentType = 2, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[38] = {content = 380, contentType = 4, speakerName = 361, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[39] = {content = 390, contentType = 4, speakerName = 361, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[40] = {content = 400, contentType = 4, speakerName = 361, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[41] = {content = 410, contentType = 4, speakerName = 361, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[42] = {
imgTween = {
{imgId = 101, duration = 0.5, alpha = 0}
, 
{imgId = 1, duration = 0.5, alpha = 1, isDark = false}
}
, content = 420, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[44] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 440, contentType = 4, speakerName = 11}
, 
[45] = {content = 450, contentType = 4, speakerName = 11}
, 
[46] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[47] = {
imgTween = {
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, duration = 0.2}
}
, content = 470, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 12, isDark = true}
}
, content = 500, contentType = 4, speakerName = 11}
, 
[51] = {
imgTween = {
{imgId = 12, isDark = false}
}
, content = 510, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[53] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[54] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 540, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[56] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[58] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 580, contentType = 4, speakerName = 11}
, 
[59] = {
imgTween = {
{imgId = 1, isDark = false}
}
, content = 590, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 610, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[62] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 620, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[63] = {
imgTween = {
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
}
, content = 630, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[64] = {
imgTween = {
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 640, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[65] = {
imgTween = {
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[67] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
}
, content = 670, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[68] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[70] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 700, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[71] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 710, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[72] = {
imgTween = {
{imgId = 99, duration = 1, alpha = 0}
, 
{imgId = 98, duration = 1, delay = 1, alpha = 1}
, 
{imgId = 12, duration = 0.2, alpha = 0}
, 
{imgId = 3, duration = 0.2, alpha = 0}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[73] = {
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 730, contentType = 2}
, 
[74] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
}
, content = 740, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[75] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, content = 750, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[77] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 770, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[78] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[79] = {
imgTween = {
{imgId = 3, duration = 1, posId = 3}
, 
{imgId = 101, isDark = false}
, 
{imgId = 101, duration = 0.2, delay = 1, shake = true}
, 
{imgId = 101, duration = 0.2, delay = 1.2, alpha = 0}
, 
{imgId = 3, duration = 0.2, delay = 1.5, isDark = true}
}
, content = 790, contentType = 2}
, 
[80] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0}
, 
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
}
, content = 800, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[81] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, content = 810, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[82] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, content = 820, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[83] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 830, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[84] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 840, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, contentShake = true}
, 
[85] = {
imgTween = {
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 3, posId = 1, isDark = false, duration = 0.2}
}
, content = 850, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[86] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 860, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[87] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 870, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[88] = {
imgTween = {
{imgId = 12, duration = 0.2, posId = 1}
, 
{imgId = 5, duration = 0.2, posId = 5}
, 
{imgId = 4, posId = 3, alpha = 0}
, 
{imgId = 4, alpha = 1, isDark = false, duration = 0.2}
}
, content = 880, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[89] = {
imgTween = {
{imgId = 4, alpha = 0, isDark = false, duration = 0.2}
}
, content = 890, contentType = 2}
, 
[90] = {content = 900, contentType = 2}
, 
[91] = {
imgTween = {
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, duration = 0.2}
}
, content = 910, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[92] = {
imgTween = {
{imgId = 101, posId = 4}
, 
{imgId = 101, duration = 0.2, shake = true}
, 
{imgId = 12, isDark = true}
}
, content = 920, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[93] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 930, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[94] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 940, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[95] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 950, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[96] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 960, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[97] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 970, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[98] = {
imgTween = {
{imgId = 5, duration = 0.2, posId = 5}
, 
{imgId = 12, duration = 0.2, posId = 1}
}
, 
audio = {
bgm = {stop = true}
, 
sfx = {cue = "Atk_Guardian_02", sheet = "Mon_Guardian"}
}
, content = 980, contentType = 4, speakerName = 981}
, 
[99] = {
imgTween = {
{imgId = 5, duration = 0.2, posId = 4}
, 
{imgId = 12, duration = 0.2, posId = 2}
}
, content = 990, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[100] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 12, duration = 0.2, shake = true}
, 
{imgId = 5, isDark = true}
}
, content = 1000, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[101] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 1010, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 3}
, 
[102] = {
imgTween = {
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 1020, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[103] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 1030, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[104] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 1040, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
}
return AvgCfg_cpt04_e_03_01

