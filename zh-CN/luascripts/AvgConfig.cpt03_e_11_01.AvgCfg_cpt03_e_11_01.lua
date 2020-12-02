-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_11_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg008", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg003", fullScreen = true}
, 
{imgId = 96, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 95, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg006", fullScreen = true}
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
{imgId = 102, imgType = 3, alpha = 0, imgPath = "helios_npc_01_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "phus_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "beelneith_avg"}
}
, 
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
, 
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, delay = 1, posId = 2}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 6}
}
}
, 
[2] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 20, contentType = 4, speakerName = 11}
, 
[3] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
}
, content = 30, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[4] = {
imgTween = {
{imgId = 27, posId = 1}
, 
{imgId = 27, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 40, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[5] = {
imgTween = {
{imgId = 27, duration = 0.2, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 104, duration = 0.2, alpha = 1}
}
, content = 50, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "Atk_Sol_02", sheet = "Chara_Sol"}
}
}
, 
[6] = {
imgTween = {
{imgId = 27, duration = 0.2, alpha = 1}
, 
{imgId = 104, duration = 0.2, alpha = 0}
}
, content = 60, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[7] = {
imgTween = {
{imgId = 104, duration = 0.2, alpha = 1}
, 
{imgId = 27, duration = 0.2, alpha = 0}
}
, content = 70, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[9] = {
imgTween = {
{imgId = 103, duration = 0.2, alpha = 1}
, 
{imgId = 104, duration = 0.2, alpha = 0}
}
, content = 90, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[10] = {
imgTween = {
{imgId = 104, duration = 0.2, alpha = 1}
, 
{imgId = 103, duration = 0.2, alpha = 0}
}
, content = 100, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[11] = {
imgTween = {
{imgId = 104, duration = 0.2, alpha = 0}
, 
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 97, duration = 0.5, delay = 0.5, alpha = 1}
, 
{imgId = 97, duration = 0.5, delay = 1, shake = true}
}
, content = 110, contentType = 2, 
audio = {
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf"}
}
}
, 
[12] = {
imgTween = {
{imgId = 103, duration = 0.2, delay = 0.5, alpha = 1}
, 
{imgId = 97, duration = 0.2, alpha = 0}
, 
{imgId = 98, duration = 0.2, delay = 0.2, alpha = 1}
}
, content = 120, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[16] = {
imgTween = {
{imgId = 104, duration = 0.2, alpha = 1}
, 
{imgId = 103, duration = 0.2, alpha = 0}
}
, content = 160, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[18] = {
imgTween = {
{imgId = 103, duration = 0.2, alpha = 1}
, 
{imgId = 104, duration = 0.2, alpha = 0}
}
, content = 180, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[21] = {
imgTween = {
{imgId = 104, duration = 0.2, alpha = 1}
, 
{imgId = 103, duration = 0.2, alpha = 0}
}
, content = 210, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[22] = {
imgTween = {
{imgId = 103, duration = 0.2, alpha = 1}
, 
{imgId = 104, duration = 0.2, alpha = 0}
}
, content = 220, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[23] = {
imgTween = {
{imgId = 104, duration = 0.2, alpha = 1}
, 
{imgId = 103, duration = 0.2, alpha = 0}
}
, content = 230, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[29] = {
imgTween = {
{imgId = 1, posId = 3}
, 
{imgId = 104, duration = 0.2, alpha = 0}
}
, content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[30] = {
imgTween = {
{imgId = 1, duration = 0.2, alpha = 0}
, 
{imgId = 104, duration = 0.2, alpha = 1}
}
, content = 300, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[32] = {
imgTween = {
{imgId = 103, duration = 0.2, alpha = 1}
, 
{imgId = 104, duration = 0.2, alpha = 0}
}
, content = 320, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[33] = {
imgTween = {
{imgId = 104, duration = 0.2, alpha = 1}
, 
{imgId = 103, duration = 0.2, alpha = 0}
}
, content = 330, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 26, speakerHeroPosId = 2}
, 
[35] = {
imgTween = {
{imgId = 104, duration = 0.5, 
pos = {180, -150, 0}
, alpha = 0}
}
, content = 350, contentType = 2}
, 
[36] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 27, posId = 5}
, 
{imgId = 27, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 27, duration = 0.5, shake = true}
}
, content = 380, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
}
}
, 
[39] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true}
}
}
, 
[41] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 27, posId = 5, isDark = false, duration = 0.2}
}
, content = 410, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 420, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 4}
}
}
, 
[43] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 430, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 27, posId = 1}
, 
{imgId = 27, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 103, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 480, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 103, duration = 0.5, posId = 3}
, 
{imgId = 27, duration = 0.2, alpha = 0}
}
, content = 500, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[51] = {
imgTween = {
{imgId = 103, duration = 3, alpha = 0}
, 
{imgId = 98, duration = 3, alpha = 0.5}
, 
{imgId = 96, duration = 3, alpha = 0.5}
}
, content = 510, contentType = 2, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[52] = {
imgTween = {
{imgId = 98, duration = 3, shake = true}
, 
{imgId = 96, duration = 3, shake = true}
, 
{imgId = 98, duration = 2, delay = 3, alpha = 0}
, 
{imgId = 96, duration = 3, delay = 5, alpha = 0}
, 
{imgId = 98, delay = 7, duration = 3, alpha = 0.3}
, 
{imgId = 96, delay = 10, duration = 3, alpha = 0}
, 
{imgId = 98, delay = 10, duration = 3, alpha = 1}
}
, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[53] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[55] = {
imgTween = {
{imgId = 27, posId = 5}
, 
{imgId = 27, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 27, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[57] = {
imgTween = {
{imgId = 1, duration = 0.2, posId = 1}
, 
{imgId = 27, duration = 0.2, posId = 5}
}
, content = 570, contentType = 2}
, 
[58] = {
imgTween = {
{imgId = 103, alpha = 0, posId = 3}
, 
{imgId = 103, duration = 3, alpha = 1}
}
, content = 580, contentType = 2, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[59] = {content = 590, contentType = 2}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[62] = {
imgTween = {
{imgId = 103, duration = 0.2, isDark = true}
}
, content = 620, contentType = 2, 
audio = {
sfx = {cue = "Skill_Anna_01", sheet = "Chara_Anna"}
}
}
, 
[63] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.5}
, 
{imgId = 103, posId = 2, isDark = true, duration = 0.5}
}
, content = 630, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 1}
, 
[67] = {
imgTween = {
{imgId = 102, posId = 5, isDark = false, duration = 0.5}
, 
{imgId = 103, posId = 3, isDark = false, duration = 0.5}
, 
{imgId = 103, isDark = true, duration = 0.1, delay = 0.5}
}
, content = 670, contentType = 2}
, 
[68] = {
imgTween = {
{imgId = 103, duration = 1.5, alpha = 0}
}
, content = 680, contentType = 2, 
audio = {
sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
}
}
, 
[69] = {content = 690, contentType = 4, speakerName = 12}
, 
[70] = {
imgTween = {
{imgId = 98, duration = 1.5, alpha = 0}
, 
{imgId = 95, duration = 1.5, alpha = 1, delay = 1.5}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[71] = {content = 710, contentType = 4, speakerName = 13}
, 
[72] = {content = 720, contentType = 4, speakerName = 13}
, 
[73] = {content = 730, contentType = 4, speakerName = 14}
, 
[74] = {content = 740, contentType = 4, speakerName = 13}
, 
[75] = {content = 750, contentType = 4, speakerName = 13}
, 
[76] = {content = 760, contentType = 4, speakerName = 14}
, 
[77] = {content = 770, contentType = 4, speakerName = 13}
, 
[78] = {content = 780, contentType = 4, speakerName = 13}
, 
[79] = {content = 790, contentType = 4, speakerName = 13}
, 
[80] = {content = 800, contentType = 4, speakerName = 14}
}
return AvgCfg_cpt03_e_11_01

