-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_h_02_01 = {
[1] = {
images = {
{imgId = 99, imgPath = "cpt00/cpt00_e_bg005", imgType = 2, order = 98, fullScreen = true, delete = false}
}
, content = 10, contentType = 1, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
}
}
, 
[2] = {
images = {
{imgId = 9, imgPath = "mai_avg", imgType = 3, 
pos = {-50, 100, 0}
, 
rot = {0, 180, 0}
, 
scale = {1.6, 1.6, 1.6}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 9, duration = 0.2, 
pos = {0, 100, 0}
, alpha = 1, isDark = false}
}
, content = 20, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 2, contentShake = true}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 2}
, 
[4] = {
imgTween = {
{imgId = 9, duration = 0.2, 
pos = {-50, 100, 0}
, alpha = 0, isDark = false}
}
, content = 40, contentType = 2, contentShake = true, 
audio = {
bgm = {stop = true, cue = "", sheet = "Music"}
}
}
, 
[5] = {
images = {
{imgId = 98, imgPath = "cpt00/cpt00_e_bg001", imgType = 4, order = 99, fullScreen = true, delete = false, alpha = 0}
, 
{imgId = 95, imgPath = "cpt00/cpt00_e_bg001", imgType = 2, order = 95, fullScreen = true, delete = false, alpha = 1}
, 
{imgId = 97, imgPath = "cpt01/cpt01_e_bg003", imgType = 2, alpha = 0, order = 100, fullScreen = true, delete = false}
}
, 
imgTween = {
{imgId = 98, duration = 2, alpha = 1}
, 
{imgId = 98, delay = 2, duration = 0.5, alpha = 0}
, 
{imgId = 97, delay = 2, alpha = 0.3}
, 
{imgId = 99, delay = 2, alpha = 0}
}
, content = 50, contentType = 2, contentShake = true}
, 
[6] = {
imgTween = {
{imgId = 97, duration = 1, alpha = 0.5}
}
, content = 60, contentType = 2}
, 
[7] = {
imgTween = {
{imgId = 97, duration = 1, alpha = 1}
}
, content = 70, contentType = 2}
, 
[8] = {
images = {
{imgId = 99, delete = true}
}
, 
imgTween = {
{imgId = 9, duration = 0.2, 
pos = {0, 100, 0}
, alpha = 1, isDark = false}
}
, content = 80, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 2}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 2}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 2}
, 
[12] = {
images = {
{imgId = 101, imgPath = "42lab_npc_02_avg", imgType = 3, 
pos = {450, -200, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.2, 1.2, 1.2}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 9, duration = 0.5, 
pos = {-350, 100, 0}
, alpha = 1, isDark = true}
, 
{imgId = 101, duration = 0.2, 
pos = {400, -200, 0}
, alpha = 1, isDark = false}
}
, content = 120, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[13] = {
imgTween = {
{imgId = 9, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 130, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[14] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 9, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[15] = {
imgTween = {
{imgId = 9, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[18] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 9, isDark = true}
}
, content = 180, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[19] = {
imgTween = {
{imgId = 9, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 190, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 9, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = -1, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 9, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 210, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[22] = {
images = {
{imgId = 6, imgPath = "fresnel_avg", imgType = 3, 
pos = {450, -300, 0}
, 
rot = {0, 0, 0}
, 
scale = {1.2, 1.2, 1.2}
, alpha = 0.2}
}
, 
imgTween = {
{imgId = 6, duration = 0.2, 
pos = {390, -300, 0}
, alpha = 1, isDark = false}
, 
{imgId = 9, isDark = true}
, 
{imgId = 101, alpha = 0}
}
, content = 220, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[23] = {
imgTween = {
{imgId = 6, isDark = true}
, 
{imgId = 9, isDark = false}
}
, content = 230, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 9, isDark = true}
, 
{imgId = 6, isDark = false}
}
, content = 250, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[26] = {
imgTween = {
{imgId = 6, isDark = true}
, 
{imgId = 9, isDark = false}
}
, content = 260, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 9, isDark = true}
, 
{imgId = 6, isDark = false}
}
, content = 270, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[29] = {
imgTween = {
{imgId = 6, isDark = true}
, 
{imgId = 9, isDark = false}
}
, content = 290, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true, cue = "", sheet = "Music"}
}
}
, 
[30] = {
images = {
{imgId = 98, imgPath = "cpt00/cpt00_e_bg001", imgType = 2, order = 100, fullScreen = true, delete = false}
}
, 
imgTween = {
{imgId = 6, alpha = 0}
, 
{imgId = 9, alpha = 0}
}
, content = 300, contentType = 2}
, 
[31] = {
images = {
{imgId = 98, imgPath = "cpt01/cpt01_e_bg001", imgType = 2, order = 100, fullScreen = true, delete = false}
}
, 
imgTween = {
{imgId = 6, alpha = 1, isDark = false}
}
, content = 310, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 6, alpha = 0}
}
, content = 320, contentType = 4, speakerName = 311}
, 
[33] = {content = 330, contentType = 4, speakerName = 311}
, 
[34] = {
imgTween = {
{imgId = 9, alpha = 1}
}
, content = 340, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
}
}
, 
[35] = {
imgTween = {
{imgId = 6, alpha = 1}
, 
{imgId = 9, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[36] = {
imgTween = {
{imgId = 6, isDark = true}
, 
{imgId = 9, isDark = false}
}
, content = 360, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 9, isDark = true}
, 
{imgId = 6, isDark = false}
}
, content = 370, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 6, isDark = true}
, 
{imgId = 9, isDark = false}
}
, content = 380, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[39] = {
imgTween = {
{imgId = 9, duration = 0.5, 
pos = {-400, 100, 0}
, alpha = 0, isDark = false}
, 
{imgId = 6, isDark = false}
}
, content = 390, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[40] = {
imgTween = {
{imgId = 6, isDark = true}
}
, content = 400, contentType = 4, speakerName = 311}
, 
[41] = {
imgTween = {
{imgId = 6, isDark = false}
}
, content = 410, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 6, isDark = true}
}
, content = 420, contentType = 4, speakerName = 311}
, 
[43] = {
imgTween = {
{imgId = 6, isDark = false}
}
, content = 430, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[44] = {
imgTween = {
{imgId = 6, isDark = true}
}
, content = 440, contentType = 4, speakerName = 311}
, 
[45] = {
imgTween = {
{imgId = 6, isDark = false}
}
, content = 450, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[46] = {
imgTween = {
{imgId = 6, isDark = true}
}
, content = 460, contentType = 4, speakerName = 311}
, 
[47] = {
imgTween = {
{imgId = 6, isDark = false}
}
, content = 470, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3, contentShake = true}
, 
[48] = {
imgTween = {
{imgId = 9, duration = 0.5, 
pos = {-350, 100, 0}
, alpha = 1, isDark = false}
, 
{imgId = 6, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1, contentShake = true}
, 
[49] = {
imgTween = {
{imgId = 9, isDark = true}
, 
{imgId = 6, isDark = false}
}
, content = 490, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 6, isDark = true}
, 
{imgId = 9, isDark = false}
}
, content = 500, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1}
, 
[51] = {
imgTween = {
{imgId = 9, isDark = true}
, 
{imgId = 6, isDark = false}
}
, content = 510, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 9, alpha = 0}
, 
{imgId = 6, isDark = true}
}
, content = 520, contentType = 4, speakerName = 311}
, 
[53] = {
imgTween = {
{imgId = 6, isDark = false}
}
, content = 530, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3}
}
return AvgCfg_cpt01_h_02_01

