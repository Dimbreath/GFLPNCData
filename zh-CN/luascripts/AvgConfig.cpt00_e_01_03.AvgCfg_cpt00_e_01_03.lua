-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt00_e_01_03 = {
[1] = {
images = {
{imgId = 99, imgType = 1, alpha = 0, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 98, imgType = 4, alpha = 0, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "croque_avg"}
}
, 
imgTween = {
{imgId = 99, duration = 1, alpha = 0.4}
, 
{imgId = 99, delay = 1, duration = 1, alpha = 0}
, 
{imgId = 99, delay = 2, duration = 1, alpha = 0.6}
, 
{imgId = 99, delay = 3, duration = 1, alpha = 0.3}
, 
{imgId = 99, delay = 4, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {stop = true}
, 
sfx = {cue = "AVG_Heartbeat", sheet = "AVG_gf"}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[2] = {
audio = {
sfx = {cue = "AVG_tinnitus", sheet = "AVG_gf", audioId = 1}
}
, content = 20, contentType = 4, speakerName = 11}
, 
[3] = {content = 30, contentType = 4, speakerName = 11}
, 
[4] = {
audio = {
stopAudioId = {1}
}
, content = 40, contentType = 4, speakerName = 11}
, 
[5] = {vedioPath = "avg/cpt00_pv", 
effect = {
effect1 = {prefabName = "avg/ui_avg"}
}
, autoContinue = true}
, 
[6] = {content = 60, contentType = 4, speakerName = 11}
, 
[7] = {
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 4, fadeOut = 3}
}
, content = 70, contentType = 4, speakerName = 11}
, 
[8] = {content = 80, contentType = 4, speakerName = 11}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[10] = {content = 100, contentType = 4, speakerName = 11}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[12] = {content = 120, contentType = 4, speakerName = 11}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[14] = {content = 140, contentType = 4, speakerName = 11}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[18] = {content = 180, contentType = 4, speakerName = 11}
, 
[19] = {
audio = {
sfx = {cue = "AVG_door_elecport", sheet = "AVG_gf"}
}
, content = 190, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[24] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, content = 240, contentType = 2, scrambleTypeWriter = true}
, 
[25] = {content = 250, contentType = 2, scrambleTypeWriter = true}
, 
[26] = {
ppv = {
cg = {saturation = -80}
}
, content = 260, contentType = 2, scrambleTypeWriter = true}
, 
[27] = {
imgTween = {
{imgId = 1, posId = 2, alpha = 0}
, 
{imgId = 1, duration = 0.8, alpha = 1, isDark = false}
, 
{imgId = 5, posId = 4, alpha = 0}
, 
{imgId = 5, duration = 0.8, alpha = 1, isDark = true}
, 
{imgId = 99, duration = 1, alpha = 0}
}
, 
effect = {
stopList = {"effect1"}
, 
effect2 = {prefabName = "avg/fxp_avg-screen", layer = 1}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 270, contentType = 2, scrambleTypeWriter = true}
, 
[28] = {
ppv = {
cg = {saturation = 0}
}
, 
imgTween = {
{imgId = 1, delay = 1, duration = 1, alpha = 0.99}
}
, content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[29] = {content = 290, contentType = 4, speakerName = 11}
, 
[30] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 5, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
, content = 300, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[33] = {
imgTween = {
{imgId = 5, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[34] = {
imgTween = {
{imgId = 1, isDark = true}
, 
{imgId = 5, isDark = false}
}
, content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[35] = {
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
, 
{imgId = 98, duration = 1, delay = 1, alpha = 0}
, 
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 5, duration = 0.5, alpha = 0}
}
}
, 
[36] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, duration = 0.2, delay = 0.5, posId = 4}
}
, content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[37] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, posId = 1}
, 
{imgId = 1, duration = 0.2, posId = 2, isDark = false}
}
, content = 370, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[40] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 400, contentType = 4, speakerName = 11}
, 
[41] = {
imgTween = {
{imgId = 3, isDark = false}
}
, content = 410, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 430, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true}
}
}
, 
[45] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, duration = 1, shake = true}
, 
{imgId = 3, duration = 1, shake = true}
, 
{imgId = 1, isDark = true, delay = 1.5}
, 
{imgId = 3, isDark = false, delay = 1.5}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
, content = 450, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, contentShake = true}
, 
[46] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
}
, 
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[47] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 470, contentType = 4, speakerName = 11}
, 
[48] = {
imgTween = {
{imgId = 3, isDark = false}
}
, content = 480, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 3, isDark = true}
}
, content = 520, contentType = 4, speakerName = 11}
, 
[53] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[54] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 540, contentType = 4, speakerName = 11}
, 
[55] = {
imgTween = {
{imgId = 3, isDark = false}
}
, content = 550, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 3, isDark = true}
, 
{imgId = 1, isDark = false}
}
, content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
}
return AvgCfg_cpt00_e_01_03

