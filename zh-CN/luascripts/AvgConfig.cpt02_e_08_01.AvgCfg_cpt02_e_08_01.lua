-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_08_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, bgColor = 2, 
images = {
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg004", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg004_2", fullScreen = true}
, 
{imgId = 5, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_cg003", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "simo_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "croque_avg"}
, 
{imgId = 20, imgType = 3, alpha = 0, imgPath = "arrow_avg"}
, 
{imgId = 21, imgType = 3, alpha = 0, imgPath = "mara_weapon_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
, 
{imgId = 104, faceId = 4}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
}
, 
[4] = {content = 40, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[5] = {content = 50, contentType = 4, speakerName = 11}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[7] = {content = 70, contentType = 4, speakerName = 12, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 2, duration = 1, alpha = 0}
, 
{imgId = 5, duration = 1, alpha = 1}
}
}
, 
[8] = {content = 80, contentType = 4, speakerName = 12}
, 
[9] = {content = 90, contentType = 4, speakerName = 12, contentShake = true, 
audio = {
sfx = {cue = "Skill_Mala_01_Hit", sheet = "Mon_Mala"}
}
}
, 
[10] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 100, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 5, duration = 0.2, alpha = 0}
, 
{imgId = 2, duration = 0.2, alpha = 1}
}
}
, 
[11] = {
imgTween = {
{imgId = 104, isDark = true}
}
, content = 110, contentType = 2, 
audio = {
sfx = {cue = "Skill_Simo_01", sheet = "Chara_Simo"}
}
}
, 
[12] = {content = 120, contentType = 4, speakerName = 12, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 5, duration = 0.2, alpha = 1}
, 
{imgId = 2, duration = 0.2, alpha = 0}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
}
, 
[13] = {content = 130, contentType = 4, speakerName = 12}
, 
[14] = {content = 140, contentType = 4, speakerName = 12}
, 
[15] = {content = 150, contentType = 4, speakerName = 11}
, 
[16] = {content = 160, contentType = 4, speakerName = 12}
, 
[17] = {content = 170, contentType = 4, speakerName = 12}
, 
[18] = {content = 180, contentType = 4, speakerName = 12, contentShake = true, 
imgTween = {
{imgId = 5, duration = 0.2, shake = true}
}
, 
audio = {
sfx = {cue = "Atk_Mala_03", sheet = "Mon_Mala"}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 5, duration = 0.2, alpha = 0}
, 
{imgId = 2, duration = 0.2, alpha = 1}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 21, faceId = 4}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 21, faceId = 0}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = true, cue = "Mus_Story_BattleTension", sheet = "Music"}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 21, faceId = 4}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
, 
{imgId = 104, faceId = 6}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
, 
{imgId = 104, faceId = 0}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
}
, 
[36] = {
images = {
{imgId = 101, delete = true}
, 
{imgId = 102, delete = true}
}
, content = 360, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
}
, 
[37] = {
images = {
{imgId = 113, imgType = 3, 
rot = {0, 180, 0}
, alpha = 0, imgPath = "betty_avg"}
, 
{imgId = 134, imgType = 3, alpha = 0, imgPath = "abigail_avg"}
}
, content = 370, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1, contentShake = true, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 113, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 113, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 134, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 134, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
, 
{imgId = 113, faceId = 6}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3, contentShake = true, 
imgTween = {
{imgId = 134, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 113, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 134, faceId = 4}
, 
{imgId = 113, faceId = 6}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 134, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 113, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 113, faceId = 0}
, 
{imgId = 134, faceId = 0}
}
}
, 
[40] = {
images = {
{imgId = 5, delete = true}
, 
{imgId = 113, delete = true}
, 
{imgId = 134, delete = true}
}
, content = 400, contentType = 4, speakerName = 401, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[41] = {
images = {
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_cg001", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
}
, content = 410, contentType = 4, speakerName = 411, contentShake = true, 
imgTween = {
{imgId = 4, delay = 0, duration = 1, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {stop = false, cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[42] = {content = 420, contentType = 2, 
audio = {
sfx = {cue = "AVG_Explosion", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 4, duration = 1, shake = true}
}
}
, 
[43] = {content = 430, contentType = 4, speakerName = 431, 
audio = {
sfx = {cue = "AVG_Explosion", sheet = "AVG_gf"}
}
}
, 
[44] = {content = 440, contentType = 4, speakerName = 441}
, 
[45] = {content = 450, contentType = 4, speakerName = 441}
, 
[46] = {content = 460, contentType = 4, speakerName = 461}
, 
[47] = {content = 470, contentType = 4, speakerName = 471}
, 
[48] = {content = 480, contentType = 4, speakerName = 471}
, 
[49] = {content = 490, contentType = 4, speakerName = 471, 
audio = {
sfx = {cue = "Skill_Croque_Ex_Start", sheet = "Chara_Croque"}
}
}
, 
[50] = {content = 500, contentType = 4, speakerName = 471, contentShake = true, 
imgTween = {
{imgId = 4, delay = 0, duration = 1, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Croque_Ex_Cast", sheet = "Chara_Croque"}
}
}
, 
[51] = {content = 510, contentType = 2, 
audio = {
sfx = {cue = "Skill_Corque_Ex_End", sheet = "Chara_Croque"}
}
}
, 
[52] = {content = 520, contentType = 2, contentShake = true, 
imgTween = {
{imgId = 4, delay = 0, duration = 1, alpha = 1, shake = true, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 1, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_bigglassbreak", sheet = "AVG_gf"}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Croque_01", sheet = "Chara_Croque"}
}
, 
heroFace = {
{imgId = 105, faceId = 1}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 21, faceId = 4}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.6, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 21, faceId = 6}
}
}
, 
[61] = {content = 610, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
}
}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2}
, 
[64] = {content = 640, contentType = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Mala_Passive_Start", sheet = "Mon_Mala"}
}
}
, 
[65] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 650, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, posId = 3, alpha = 1, isDark = false}
}
}
, 
[66] = {content = 660, contentType = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 21, faceId = 4}
}
}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, shake = true, isDark = false}
}
}
, 
[73] = {content = 730, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.2, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0, alpha = 0, isDark = false}
, 
{imgId = 21, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 21, faceId = 6}
}
}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 21, speakerHeroPosId = 2, 
imgTween = {
{imgId = 21, delay = 0, duration = 0.6, alpha = 1, shake = true, isDark = false}
}
}
}
return AvgCfg_cpt02_e_08_01

