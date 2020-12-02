-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_03_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg002", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg003", fullScreen = true}
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
}
, 
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
}
, content = 10, contentType = 2, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[2] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
}
, content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[3] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[4] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 40, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 3, duration = 0.2, posId = 5}
, 
{imgId = 2, duration = 0.2, posId = 1}
}
, content = 50, contentType = 2, 
audio = {
sfx = {cue = "AVG_Door_Hit", sheet = "AVG_gf"}
}
}
, 
[6] = {
imgTween = {
{imgId = 98, duration = 0.5, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_bigglassbreak", sheet = "AVG_gf"}
}
}
, 
[7] = {
imgTween = {
{imgId = 3, duration = 0.2, posId = 4}
}
, content = 70, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, contentShake = true}
, 
[8] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 4, posId = 1}
, 
{imgId = 4, duration = 0.2, posId = 2}
}
, content = 80, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, contentShake = true}
, 
[9] = {
imgTween = {
{imgId = 4, duration = 0.2, alpha = 0}
, 
{imgId = 3, duration = 0.2, alpha = 0}
}
, content = 90, contentType = 2, 
audio = {
sfx = {cue = "Skill_Simo_01", sheet = "Chara_Simo"}
}
}
, 
[10] = {
imgTween = {
{imgId = 98, duration = 0.5, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Broken_Glass", sheet = "AVG_gf"}
}
, content = 100, contentType = 4, speakerName = 11}
, 
[11] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, duration = 0.2, posId = 2, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_door_storehouse", sheet = "AVG_gf", audioId = 2}
}
, content = 110, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[12] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 2, duration = 0.2, posId = 1}
, 
{imgId = 97, duration = 0.5, delay = 0.5, alpha = 1}
}
, 
audio = {
sfx = {cue = "AVG_BaseDoor_Close", sheet = "AVG_gf"}
, 
stopAudioId = {2}
}
}
, 
[13] = {
imgTween = {
{imgId = 97, duration = 2, shake = true}
}
, content = 130, contentType = 2, 
audio = {
sfx = {cue = "AVG_Door_Hit", sheet = "AVG_gf"}
}
}
, 
[14] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
}
, content = 140, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[15] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[16] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[18] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[19] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 190, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 200, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[22] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[23] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 230, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[24] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 4, posId = 5, isDark = false, duration = 0.2}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[25] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 250, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[28] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[29] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[30] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[31] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 320, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 330, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[34] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[35] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[39] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 4, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 390, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[40] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 400, contentType = 4, speakerName = 11}
, 
[41] = {
imgTween = {
{imgId = 2, isDark = false}
}
, content = 410, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[43] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 430, contentType = 4, speakerName = 11}
, 
[44] = {
imgTween = {
{imgId = 2, isDark = false}
}
, content = 440, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[45] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 450, contentType = 4, speakerName = 11}
, 
[46] = {
imgTween = {
{imgId = 2, isDark = false}
}
, content = 460, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[47] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 470, contentType = 4, speakerName = 11}
, 
[48] = {
imgTween = {
{imgId = 2, isDark = false}
}
, content = 480, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 4, posId = 5, isDark = false, duration = 0.2}
}
, content = 500, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 510, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 520, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[54] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
}
}
, 
[55] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[57] = {
imgTween = {
{imgId = 3, duration = 1, alpha = 0}
, 
{imgId = 1, duration = 1, alpha = 0}
}
, content = 570, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 3}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 3}
, 
[61] = {
imgTween = {
{imgId = 3, posId = 3}
, 
{imgId = 3, duration = 0.5, shake = true}
}
, 
audio = {
sfx = {cue = "Atk_Sol_01", sheet = "Chara_Sol"}
, 
bgm = {stop = true}
}
, content = 610, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[62] = {
imgTween = {
{imgId = 3, duration = 0.2, alpha = 0}
, 
{imgId = 34, posId = 5}
, 
{imgId = 34, posId = 4, isDark = false, duration = 0.2}
}
, content = 620, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 3}
, 
[63] = {
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 630, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 3}
, 
[64] = {
imgTween = {
{imgId = 34, isDark = true}
, 
{imgId = 13, posId = 1}
, 
{imgId = 13, posId = 2, isDark = false, duration = 0.2}
}
, content = 640, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 13, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 34, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
}
, content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 2, duration = 0.2, posId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[68] = {
imgTween = {
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 34, posId = 4, isDark = false, duration = 0.2}
}
, content = 680, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3}
, 
[69] = {
imgTween = {
{imgId = 13, duration = 0.2, posId = 2, isDark = false}
, 
{imgId = 34, isDark = true}
}
, content = 690, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[70] = {
imgTween = {
{imgId = 13, isDark = true}
}
, content = 700, contentType = 4, speakerName = 11}
, 
[71] = {content = 710, contentType = 4, speakerName = 11}
}
return AvgCfg_cpt02_e_03_01

