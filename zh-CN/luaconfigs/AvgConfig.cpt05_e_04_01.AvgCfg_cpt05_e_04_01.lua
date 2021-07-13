-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_e_04_01 = {
[1] = {content = 10, contentType = 2, bgColor = 2, 
images = {
{imgId = 2, imgType = 2, alpha = -1, imgPath = "cpt05/cpt05_e_bg001", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = -1, imgPath = "cpt05/cpt05_e_bg001_2", fullScreen = true}
, 
{imgId = 4, imgType = 2, alpha = -1, imgPath = "cpt05/cpt05_e_bg005", fullScreen = true}
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
, 
{imgId = 34, imgType = 3, alpha = -1, imgPath = "odile_w_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 0.8, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
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
[3] = {content = 30, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 0, 
rot = {0, 180, 0}
, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, 
rot = {0, 180, 0}
, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[4] = {content = 40, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Croque_01_Hit", sheet = "Chara_Croque"}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
rot = {0, 0, 0}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[6] = {content = 60, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[7] = {content = 70, contentType = 4, speakerName = 71, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[8] = {content = 80, contentType = 2, contentShake = true, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0, posId = 5, 
rot = {0, 180, 0}
, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, 
rot = {0, 180, 0}
, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_Gatling_gun", sheet = "AVG_gf"}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
}
, 
rot = {0, 180, 0}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 0}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 104, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 6}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
, 
{imgId = 104, faceId = 0}
}
}
, 
[18] = {content = 180, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 105, faceId = 5}
, 
{imgId = 104, faceId = 0}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_ElecSpace", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[29] = {content = 290, contentType = 2, 
imgTween = {
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[31] = {content = 310, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Refactorer_01_Loop", sheet = "Mon_Refactorer", audioId = 14}
}
}
, 
[32] = {content = 320, contentType = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 0.6, isDark = false}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
, 
audio = {
stopAudioId = {14}
}
}
, 
[34] = {content = 340, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 3, contentShake = true, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
, 
audio = {
sfx = {cue = "Atk_Guardian_02", sheet = "Mon_Guardian"}
}
}
, 
[36] = {content = 360, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 6}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
, 
{imgId = 104, faceId = 6}
}
}
, 
[40] = {content = 400, contentType = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Atk_Guardian_02", sheet = "Mon_Guardian"}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
}
, 
[41] = {content = 410, contentType = 2}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 117, delay = 0, duration = 0, posId = 5, alpha = 0, 
rot = {0, 180, 0}
, isDark = false}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 1, 
rot = {0, 180, 0}
, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 117, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, autoContinue = true, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 1, posId = 3, alpha = 0.75, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
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
[49] = {content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
, 
{imgId = 34, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 4, delay = 2, duration = 0.3, alpha = 0}
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
[53] = {
images = {
{imgId = 103, delete = true}
, 
{imgId = 110, imgType = 3, alpha = 0, imgPath = "shadow_avg"}
}
, content = 530, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[54] = {
imgTween = {
{imgId = 110, duration = 0.2, alpha = 0.2, isDark = false}
}
, content = 540, contentType = 2}
, 
[55] = {content = 550, contentType = 2, 
imgTween = {
{imgId = 110, duration = 0.5, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 1.5, alpha = 0, isDark = false}
}
}
}
return AvgCfg_cpt05_e_04_01

