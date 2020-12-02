-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_06_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg002", fullScreen = true}
, 
{imgId = 96, imgType = 4, alpha = 0, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
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
{imgId = 102, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
}
, 
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
, 
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 6}
}
}
, 
[2] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[3] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 40, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
audio = {
bgm = {stop = true}
}
}
, 
[5] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 96, duration = 0.5, alpha = 1}
, 
{imgId = 96, duration = 0.5, delay = 0.5, alpha = 0}
, 
{imgId = 101, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 3, fadeOut = 3}
, 
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf", audioId = 5}
}
}
, 
[6] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 60, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, duration = 0.1, shake = true}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[14] = {
imgTween = {
{imgId = 101, duration = 0.1, shake = true}
}
, content = 140, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[16] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[21] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[22] = {
imgTween = {
{imgId = 98, duration = 1, alpha = 0}
, 
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 101, duration = 0.5, alpha = 0}
, 
{imgId = 97, duration = 1, delay = 1, alpha = 1}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
, 
bgm = {stop = true}
}
}
, 
[23] = {
imgTween = {
{imgId = 101, duration = 0.5, alpha = 1}
}
, content = 230, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 4}
}
}
, 
[24] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 250, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[27] = {
imgTween = {
{imgId = 27, posId = 1}
, 
{imgId = 27, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[28] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[29] = {
imgTween = {
{imgId = 27, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 290, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[31] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 27, posId = 1, isDark = false, duration = 0.2}
}
, content = 310, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[32] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 320, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[33] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 27, posId = 1}
, 
{imgId = 27, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 350, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[36] = {
imgTween = {
{imgId = 97, duration = 1, shake = true}
, 
{imgId = 27, isDark = true}
, 
{imgId = 27, duration = 1, shake = true}
, 
{imgId = 102, duration = 1, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
}
, 
[37] = {
imgTween = {
{imgId = 27, isDark = false}
}
, content = 370, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[38] = {
imgTween = {
{imgId = 27, duration = 0.2, posId = 1}
, 
{imgId = 102, duration = 0.2, posId = 5}
, 
{imgId = 97, duration = 0.5, alpha = 0}
, 
{imgId = 98, duration = 0.5, alpha = 1}
, 
{imgId = 98, duration = 1, delay = 0.5, shake = true}
}
, content = 380, contentType = 2}
, 
[39] = {
imgTween = {
{imgId = 97, duration = 0.5, alpha = 1}
, 
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 102, duration = 0.2, posId = 4, isDark = false}
}
, content = 390, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[40] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 102, duration = 0.5, alpha = 0}
, 
{imgId = 5, duration = 0.5, alpha = 0}
}
, content = 410, contentType = 2, 
audio = {
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf", audioId = 1}
}
}
, 
[42] = {
imgTween = {
{imgId = 102, duration = 0.5, alpha = 1, isDark = false}
, 
{imgId = 5, duration = 0.5, alpha = 0}
}
, content = 420, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 5, duration = 0.5, alpha = 1, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[44] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[54] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[55] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[57] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 570, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[59] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 590, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[60] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 600, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[62] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 620, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[64] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 102, duration = 0.5, posId = 5}
}
, content = 640, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
}
, 
[65] = {
imgTween = {
{imgId = 5, isDark = true}
, 
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
}
, content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[67] = {
imgTween = {
{imgId = 27, posId = 1}
, 
{imgId = 27, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 670, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1, contentShake = true}
, 
[68] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
}
return AvgCfg_cpt03_e_06_01

