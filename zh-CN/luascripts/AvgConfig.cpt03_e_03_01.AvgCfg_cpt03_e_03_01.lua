-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_03_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg004", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 127, imgType = 3, alpha = 0, imgPath = "zion_avg"}
, 
{imgId = 24, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
, 
{imgId = 23, imgType = 3, alpha = 0, imgPath = "choco_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0.5}
, 
{imgId = 127, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[2] = {content = 20, contentType = 4, speakerName = 21, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[6] = {content = 60, contentType = 4, speakerName = 21, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[9] = {content = 90, contentType = 2, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_Fir_Bonfire", sheet = "AVG_gf", audioId = 0}
}
}
, 
[16] = {
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, contentShake = true}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
imgTween = {
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
stopAudioId = {0}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 127, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "Atk_Persicaria_01", sheet = "Chara_Persicaria"}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[29] = {content = 290, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 127, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[32] = {content = 320, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 2, delay = 0, duration = 2, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
}
, 
[33] = {content = 330, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.2, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_tinnitus", sheet = "AVG_gf"}
}
}
, 
[34] = {content = 340, contentType = 2}
, 
[35] = {content = 350, contentType = 4, speakerName = 351, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 0.1, isDark = false}
}
}
, 
[36] = {
imgTween = {
{imgId = 2, duration = 0.5, shake = true}
}
, content = 360, contentType = 4, speakerName = 361, 
audio = {
sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
}
}
, 
[37] = {
audio = {
sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
}
, content = 370, contentType = 4, speakerName = 371}
, 
[38] = {
audio = {
sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
}
, content = 380, contentType = 4, speakerName = 381}
, 
[39] = {content = 390, contentType = 4, speakerName = 371}
, 
[40] = {content = 400, contentType = 4, speakerName = 21}
, 
[41] = {
audio = {
bgm = {stop = true}
}
, content = 410, contentType = 2}
, 
[42] = {content = 420, contentType = 2}
, 
[43] = {
imgTween = {
{imgId = 2, delay = 0, duration = 3, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 3, alpha = 1, isDark = false}
}
, content = 430, contentType = 2}
, 
[44] = {content = 440, contentType = 4, speakerName = 441}
, 
[45] = {content = 450, contentType = 4, speakerName = 21, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[46] = {content = 460, contentType = 4, speakerName = 361, 
imgTween = {
{imgId = 2, delay = 0, duration = 3, alpha = 1, isDark = false}
, 
{imgId = 3, delay = 0, duration = 3, alpha = 0, isDark = false}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 23, duration = 0.2, shake = true}
}
, content = 520, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 3}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
imgTween = {
{imgId = 23, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 24, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
}
return AvgCfg_cpt03_e_03_01

