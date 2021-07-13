-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_e_03_01 = {
[1] = {content = 10, contentType = 4, speakerName = 11, bgColor = 2, 
images = {
{imgId = 2, imgType = 2, alpha = -1, imgPath = "cpt00/cpt00_e_bg005_2", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = -1, imgPath = "cpt05/cpt05_e_bg001", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = -1, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = -1, imgPath = "anna_avg"}
, 
{imgId = 103, imgType = 3, alpha = -1, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = -1, imgPath = "simo_avg"}
, 
{imgId = 105, imgType = 3, alpha = -1, imgPath = "croque_avg"}
, 
{imgId = 117, imgType = 3, alpha = -1, imgPath = "angela_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0.6, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "Skill_Refactorer_01_Start", sheet = "Mon_Refactorer"}
}
}
, 
[2] = {content = 20, contentType = 4, speakerName = 11, contentShake = true}
, 
[3] = {content = 30, contentType = 2, 
audio = {
sfx = {cue = "Atk_Raider_02", sheet = "Mon_Raider"}
}
}
, 
[4] = {content = 40, contentType = 2}
, 
[5] = {content = 50, contentType = 4, speakerName = 51, contentShake = true}
, 
[6] = {
images = {
{imgId = 99, imgPath = "cpt00/cpt00_e_bg004", imgType = 4, fullScreen = true, alpha = 0, delete = false}
}
, 
imgTween = {
{imgId = 99, duration = 0.2, alpha = 1}
, 
{imgId = 99, duration = 0.2, delay = 0.5, alpha = 0}
}
, content = 60, contentType = 2, 
audio = {
sfx = {cue = "Skill_Persicaria_01", sheet = "Chara_Persicaria"}
}
}
, 
[7] = {
images = {
{imgId = 99, delete = true}
}
, content = 70, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false, 
rot = {0, 0, 0}
}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false, 
rot = {0, 0, 0}
}
}
}
, 
[9] = {autoContinue = true, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_BattleTension"}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
branch = {
{content = 141, jumpAct = 15}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[27] = {autoContinue = true, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
images = {
{imgId = 2, alpha = 0, delete = true}
, 
{imgId = 33, imgType = 3, alpha = 0, imgPath = "odette_avg"}
, 
{imgId = 34, imgType = 3, alpha = 0, imgPath = "odile_w_avg"}
}
, 
imgTween = {
{imgId = 3, delay = 0, duration = 1.5, alpha = 1, isDark = false}
, 
{imgId = 117, delay = 1.5, duration = 0, posId = 1, alpha = 0, isDark = true, 
rot = {0, 0, 0}
}
, 
{imgId = 117, delay = 1.5, duration = 0.2, posId = 2, alpha = 1, isDark = true, 
rot = {0, 0, 0}
}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 1.5, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[30] = {content = 300, contentType = 4, speakerName = 51, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_Door_Open_Close", sheet = "AVG_gf"}
}
}
, 
[31] = {content = 310, contentType = 4, speakerName = 51}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[33] = {content = 330, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 3, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 3, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 33, posId = 2, delay = 3, duration = 0.5, isDark = true}
, 
{imgId = 34, delay = 3, posId = 4, duration = 0.5, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_footsteps_cave", sheet = "AVG_gf"}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 2, 
imgTween = {
{imgId = 33, isDark = false}
, 
{imgId = 33, duration = 0.5, 
pos = {-200, -340, 0}
}
, 
{imgId = 33, duration = 0.5, 
pos = {-200, -400, 0}
, delay = 1}
, 
{imgId = 33, duration = 0.2, 
pos = {-200, -340, 0}
, delay = 1.5}
, 
{imgId = 33, duration = 0.2, isDark = true, delay = 2}
, 
{imgId = 34, duration = 0.5, 
pos = {200, -340, 0}
}
, 
{imgId = 34, duration = 0.5, 
pos = {200, -400, 0}
, delay = 1}
, 
{imgId = 34, duration = 0.2, 
pos = {200, -340, 0}
, delay = 1.5}
, 
{imgId = 34, duration = 0.2, isDark = true, delay = 2}
}
}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false, 
rot = {0, 180, 0}
}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true, 
rot = {0, 180, 0}
}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true, 
rot = {0, 180, 0}
}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 2, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2, 
imgTween = {
{imgId = 33, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 3, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false, 
rot = {0, 180, 0}
}
}
}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3, 
branch = {
{content = 641, jumpAct = 65}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true, 
rot = {0, 0, 0}
}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true, 
rot = {0, 0, 0}
}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[73] = {content = 730, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[74] = {content = 740, contentType = 4, speakerName = 743, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
branch = {
{content = 741, jumpAct = 75}
, 
{content = 742, jumpAct = 76}
}
}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, nextId = 78}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[77] = {content = 770, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[78] = {content = 780, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[79] = {content = 790, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true, sheet = "Mus_YT_Story_General"}
}
}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[88] = {content = 880, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 1, 
imgTween = {
{imgId = 117, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[89] = {content = 890, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2}
, 
[93] = {content = 930, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2}
, 
[94] = {content = 940, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
}
}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[96] = {content = 960, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[97] = {content = 970, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[98] = {content = 980, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
branch = {
{content = 981, jumpAct = 99}
, 
{content = 982, jumpAct = 101}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[99] = {content = 990, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[100] = {content = 1000, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, nextId = 103}
, 
[101] = {content = 1010, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[102] = {content = 1020, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2}
, 
[103] = {content = 1030, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 33, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[105] = {content = 1050, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[106] = {content = 1060, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[107] = {contentShake = true, autoContinue = true, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[108] = {content = 1080, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[109] = {content = 1090, contentType = 4, speakerName = 1091, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[110] = {content = 1100, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 104, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
}
, 
[111] = {content = 1110, contentType = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
}
, 
[112] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 1120, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, posId = 3, alpha = 1, isDark = false}
}
}
, 
[113] = {content = 1130, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
}
, 
[114] = {content = 1140, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[115] = {content = 1150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[116] = {content = 1160, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[117] = {content = 1170, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2}
, 
[118] = {content = 1180, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 1, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 33, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[119] = {content = 1190, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 33, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
}
return AvgCfg_cpt05_e_03_01

