-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_08_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 12, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 36, imgType = 3, alpha = 0, imgPath = "lam_avg"}
}
, 
imgTween = {
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, delay = 1, duration = 0.2}
, 
{imgId = 99, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[2] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
}
, content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[3] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[4] = {
audio = {
sfx = {cue = "AVG_Battlefield", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[7] = {
imgTween = {
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 70, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[10] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 12, posId = 1, isDark = false, duration = 0.2}
}
, content = 100, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[11] = {
imgTween = {
{imgId = 12, posId = 5}
, 
{imgId = 12, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 110, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[12] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 120, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[13] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 130, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[14] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[15] = {
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[16] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[18] = {
imgTween = {
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 99, duration = 0.2, alpha = 0}
, 
{imgId = 12, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 99, duration = 0.2, delay = 0.5, alpha = 1}
}
, autoContinue = true}
, 
[19] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
}
, content = 190, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[22] = {
imgTween = {
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 36, posId = 3, alpha = 0}
, 
{imgId = 36, alpha = 1, isDark = false, duration = 0.2}
}
, content = 220, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 2}
, 
[23] = {
imgTween = {
{imgId = 1, posId = 3, alpha = 0}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 36, alpha = 0, isDark = false, duration = 0.2}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 1, posId = 2, duration = 0.2, isDark = true}
, 
{imgId = 12, posId = 5}
, 
{imgId = 12, posId = 4, isDark = false, duration = 0.2}
}
, content = 250, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[26] = {
imgTween = {
{imgId = 12, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 260, contentType = 2}
, 
[27] = {
imgTween = {
{imgId = 5, posId = 3, alpha = 0}
, 
{imgId = 5, alpha = 1, isDark = false, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[29] = {
imgTween = {
{imgId = 5, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 5}
, 
{imgId = 1, posId = 4, isDark = false, duration = 0.2}
}
, content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[30] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[31] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[35] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[36] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[37] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[38] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, content = 380, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[41] = {
imgTween = {
{imgId = 36, posId = 5}
, 
{imgId = 36, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
, 
{imgId = 1, posId = 5, isDark = false, duration = 0.2}
}
, content = 410, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 12, posId = 1}
, 
{imgId = 12, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 36, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 430, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 1}
, 
[44] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 36, isDark = true}
, 
{imgId = 12, posId = 1, isDark = false, duration = 0.2}
}
, content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[48] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 36, isDark = true}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
}
, content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[53] = {
imgTween = {
{imgId = 36, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[56] = {autoContinue = true, 
imgTween = {
{imgId = 36, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 99, duration = 0.2, alpha = 0}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[57] = {content = 570, contentType = 4, speakerName = 11}
, 
[58] = {content = 580, contentType = 4, speakerName = 11}
, 
[59] = {content = 590, contentType = 4, speakerName = 11}
, 
[60] = {content = 600, contentType = 4, speakerName = 11}
, 
[61] = {content = 610, contentType = 4, speakerName = 11}
, 
[62] = {
imgTween = {
{imgId = 2, posId = 3, isDark = true}
}
, content = 620, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[66] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 660, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
}
return AvgCfg_cpt04_e_08_01

