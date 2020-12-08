-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_02_01 = {
[1] = {
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg002", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg003", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 112, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 28, imgType = 3, alpha = 0, imgPath = "adele_avg"}
}
, 
imgTween = {
{imgId = 1, delay = 0, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = true}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_Door_Hit", sheet = "AVG_gf", audioId = 8}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.6, alpha = 0.8, isDark = false}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.6, alpha = 0.6, isDark = false}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[18] = {content = 180, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 4, speakerHeroId = 4, speakerName = 211, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 4, speakerHeroId = 4, speakerName = 211, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[27] = {content = 270, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[32] = {content = 320, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 4, speakerName = 12, contentShake = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[36] = {content = 360, contentType = 4, speakerName = 12, speakerHeroPosId = 2}
, 
[37] = {content = 370, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_footsteps_cave", sheet = "AVG_gf"}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[49] = {content = 490, contentType = 4, speakerHeroId = 2, speakerName = 491, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[50] = {content = 500, contentType = 4, speakerHeroId = 2, speakerName = 491}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 4, speakerHeroId = 2, speakerName = 491, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[53] = {content = 530, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
}
return AvgCfg_cpt04_e_02_01

