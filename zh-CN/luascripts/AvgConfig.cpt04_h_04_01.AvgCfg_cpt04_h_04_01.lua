-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_h_04_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg006", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
}
, 
audio = {
bgm = {stop = true}
}
, content = 10, contentType = 1, nextId = 58}
, 
[2] = {
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 99, duration = 0.5, alpha = 0.7}
, 
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 20, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[3] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 30, contentType = 2}
, 
[4] = {content = 40, contentType = 4, speakerName = 11}
, 
[5] = {content = 50, contentType = 2}
, 
[6] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 60, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[9] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 90, contentType = 4, speakerName = 12}
, 
[10] = {content = 100, contentType = 4, speakerName = 12}
, 
[11] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2, isDark = false}
}
, content = 110, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[14] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 140, contentType = 2}
, 
[15] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 150, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[20] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 200, contentType = 2}
, 
[21] = {
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 99, alpha = 0, duration = 0.5}
}
, content = 210, contentType = 4, speakerName = 13}
, 
[22] = {
imgTween = {
{imgId = 98, alpha = 1, delay = 0.5, duration = 0.5}
}
}
, 
[23] = {content = 230, contentType = 4, speakerName = 11}
, 
[24] = {
audio = {
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2, isDark = false}
}
, content = 240, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 250, contentType = 2}
, 
[26] = {content = 260, contentType = 4, speakerName = 11}
, 
[27] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[28] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 280, contentType = 2}
, 
[29] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 290, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[30] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 300, contentType = 4, speakerName = 11}
, 
[31] = {content = 310, contentType = 4, speakerName = 11}
, 
[32] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 320, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[33] = {
audio = {
sfx = {cue = "AVG_BaseDoor_Close", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 330, contentType = 4, speakerName = 11}
, 
[34] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = false}
}
, content = 340, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[38] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 380, contentType = 4, speakerName = 12}
, 
[39] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 390, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[40] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 400, contentType = 4, speakerName = 12}
, 
[41] = {content = 410, contentType = 4, speakerName = 12}
, 
[42] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 420, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[43] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 430, contentType = 2}
, 
[44] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 440, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[46] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 460, contentType = 4, speakerName = 12}
, 
[47] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 470, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[49] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 490, contentType = 2}
, 
[50] = {content = 500, contentType = 2}
, 
[51] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 510, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[55] = {
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, isDark = true}
}
, content = 550, contentType = 4, speakerName = 12}
, 
[56] = {content = 560, contentType = 2}
, 
[57] = {
images = {
{imgId = 101, delete = true}
}
, content = 570, contentType = 2, isEnd = true}
, 
[58] = {content = 580, contentType = 1, scrambleTypeWriter = true, nextId = 2}
}
return AvgCfg_cpt04_h_04_01

