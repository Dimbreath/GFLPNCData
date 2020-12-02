-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 4, alpha = 0, imgPath = "cpt00/cpt00_e_bg004", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, order = 1, imgPath = "cpt00/cpt00_e_cg001", fullScreen = true}
, 
{imgId = 96, imgType = 2, alpha = 0, order = 1, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 1, imgType = 3, order = 2, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, order = 1, imgPath = "sol_avg"}
}
, 
imgTween = {
{imgId = 97, delay = 0.5, duration = 1.5, alpha = 0.2}
, 
{imgId = 97, delay = 2, duration = 1.5, alpha = 0}
, 
{imgId = 97, delay = 3.5, duration = 1.5, alpha = 0.5}
, 
{imgId = 97, delay = 5, duration = 1.5, alpha = 0}
, 
{imgId = 97, delay = 6.5, duration = 1.5, alpha = 1}
}
, 
audio = {
bgm = {stop = true}
, 
sfx = {cue = "AVG_Walk", sheet = "AVG_gf"}
}
, content = 10, contentType = 2}
, 
[2] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 20, contentType = 2}
, 
[3] = {content = 30, contentType = 2}
, 
[4] = {content = 40, contentType = 2}
, 
[5] = {content = 50, contentType = 2}
, 
[6] = {content = 60, contentType = 2}
, 
[7] = {content = 70, contentType = 2}
, 
[8] = {content = 80, contentType = 2}
, 
[9] = {content = 90, contentType = 2}
, 
[10] = {
imgTween = {
{imgId = 98, duration = 3, alpha = 1}
, 
{imgId = 98, duration = 3, delay = 3, alpha = 0}
, 
{imgId = 97, duration = 0.2, delay = 3, alpha = 0}
}
, 
effect = {
effect1 = {prefabName = "avg/ui_avg"}
}
, 
audio = {
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, content = 100, contentType = 2}
, 
[11] = {content = 110, contentType = 2}
, 
[12] = {content = 120, contentType = 2}
, 
[13] = {
effect = {
stopList = {"effect1"}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, content = 130, contentType = 2}
, 
[14] = {
imgTween = {
{imgId = 96, delay = 0.5, duration = 3, alpha = 1}
}
, 
audio = {
sfx = {cue = "AVG_Alarm", sheet = "AVG_gf"}
}
, content = 140, contentType = 4, speakerName = 141}
, 
[15] = {content = 150, contentType = 4, speakerName = 141}
, 
[16] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, duration = 0.2, posId = 2}
, 
{imgId = 1, posId = 5}
, 
{imgId = 1, duration = 0.2, posId = 4, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
, 
sfx = {cue = "AVG_Door_Hit", sheet = "AVG_gf"}
}
, content = 160, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, contentShake = true}
, 
[18] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, duration = 0.2, isDark = false, shake = true}
}
, content = 180, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[20] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[21] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[22] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[24] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = true}
}
, content = 250, contentType = 4, speakerName = 11}
, 
[26] = {content = 260, contentType = 4, speakerName = 11}
, 
[27] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[28] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, contentShake = true}
, 
[30] = {
imgTween = {
{imgId = 1, duration = 0.2, posId = 5}
, 
{imgId = 3, duration = 0.2, posId = 1}
, 
{imgId = 1, duration = 0.7, delay = 0.5, posId = 4, isDark = false}
, 
{imgId = 3, duration = 0.7, delay = 0.5, posId = 2, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_bigglassbreak", sheet = "AVG_gf"}
}
, content = 300, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = true}
}
, content = 320, contentType = 4, speakerName = 11}
, 
[33] = {content = 330, contentType = 4, speakerName = 11}
, 
[34] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[37] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[38] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
}
return AvgCfg_cpt00_e_01_01

