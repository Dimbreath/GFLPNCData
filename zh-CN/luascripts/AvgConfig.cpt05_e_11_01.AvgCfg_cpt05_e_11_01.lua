-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_e_11_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg001_2", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg002", fullScreen = true}
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
{imgId = 108, imgType = 3, alpha = 0, imgPath = "gin_avg"}
, 
{imgId = 117, imgType = 3, alpha = 0, imgPath = "angela_avg"}
, 
{imgId = 33, imgType = 3, alpha = 0, imgPath = "odette_avg"}
, 
{imgId = 35, imgType = 3, alpha = 0, imgPath = "wisdom_w_avg"}
}
, 
imgTween = {
{imgId = 1, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 2}
, 
[2] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, 
imgTween = {
{imgId = 103, posId = 3}
}
, content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[3] = {
audio = {
sfx = {cue = "Atk_Guardian_02", sheet = "Mon_Guardian"}
}
, 
imgTween = {
{imgId = 104, posId = 3}
, 
{imgId = 103, alpha = 0}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
, content = 30, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[4] = {
imgTween = {
{imgId = 104, alpha = 0}
, 
{imgId = 103, alpha = 1}
}
, content = 40, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
branch = {
{content = 41, jumpAct = 5}
, 
{content = 42, jumpAct = 9}
}
}
, 
[5] = {
imgTween = {
{imgId = 103, alpha = 0}
, 
{imgId = 33, posId = 3}
}
, content = 50, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 2}
, 
[6] = {
imgTween = {
{imgId = 33, alpha = 0}
, 
{imgId = 101, posId = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 60, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[7] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 70, contentType = 4, speakerName = 11}
, 
[8] = {
imgTween = {
{imgId = 101, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, nextId = 13}
, 
[9] = {
imgTween = {
{imgId = 103, alpha = 0}
, 
{imgId = 101, posId = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[12] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 120, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[13] = {
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 1, duration = 0.5, shake = true}
}
, content = 130, contentType = 2}
, 
[14] = {
audio = {
sfx = {cue = "Skill_Refactorer_01_Loop", sheet = "Mon_Refactorer", audioId = 14}
}
, content = 140, contentType = 2}
, 
[15] = {
audio = {
stopAudioId = {14}
}
, 
imgTween = {
{imgId = 117, posId = 3}
}
, content = 150, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 2}
, 
[17] = {
imgTween = {
{imgId = 104, posId = 5}
, 
{imgId = 104, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 2, duration = 0.2, isDark = true}
}
, content = 170, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[18] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 180, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[19] = {
audio = {
sfx = {cue = "Atk_Guardian_02", sheet = "Mon_Guardian"}
}
, 
imgTween = {
{imgId = 117, isDark = true}
, 
{imgId = 104, isDark = true}
}
, content = 190, contentType = 2}
, 
[20] = {
imgTween = {
{imgId = 117, isDark = false}
}
, content = 200, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1, contentShake = true}
, 
[21] = {
imgTween = {
{imgId = 108, posId = 5}
, 
{imgId = 108, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 117, isDark = true}
, 
{imgId = 104, posId = 5, isDark = false, duration = 0.2}
}
, content = 210, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[22] = {
audio = {
sfx = {cue = "Atk_Gin_02", sheet = "Chara_Gin"}
}
, 
imgTween = {
{imgId = 117, alpha = 0}
, 
{imgId = 108, alpha = 0}
}
, content = 220, contentType = 2}
, 
[23] = {
imgTween = {
{imgId = 117, alpha = 1, isDark = false}
, 
{imgId = 108, alpha = 1, isDark = true}
}
, 
audio = {
sfx = {cue = "Atk_Gin_Heal", sheet = "Chara_Gin"}
}
, content = 230, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 1}
, 
[24] = {
imgTween = {
{imgId = 103, posId = 1}
, 
{imgId = 103, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 117, posId = 1, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 240, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 108, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 250, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1008, speakerHeroPosId = 3}
, 
[28] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 108, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 280, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[29] = {
imgTween = {
{imgId = 103, isDark = true}
, 
{imgId = 108, isDark = true}
}
, content = 290, contentType = 2}
, 
[30] = {
imgTween = {
{imgId = 104, posId = 5}
, 
{imgId = 104, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 108, posId = 5, isDark = false, duration = 0.2}
}
, content = 300, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[31] = {
heroFace = {
{imgId = 104, faceId = 4}
}
, content = 310, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[32] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 104, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 320, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[36] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[38] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 103, isDark = true}
, 
{imgId = 104, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[39] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 390, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[40] = {
imgTween = {
{imgId = 33, posId = 5}
, 
{imgId = 33, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 103, isDark = true}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 400, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 33, isDark = true}
}
, content = 420, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[43] = {
audio = {
sfx = {cue = "AVG_rifle_finalshot_h", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 103, posId = 3, isDark = false, duration = 0.2}
, 
{imgId = 33, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 1, duration = 1, shake = true}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 430, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[45] = {
imgTween = {
{imgId = 103, alpha = 0}
}
, content = 450, contentType = 2}
, 
[46] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 460, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[47] = {
audio = {
sfx = {cue = "Skill_Persicaria_Ex_Start", sheet = "Chara_Persicaria"}
}
, content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 104, posId = 1}
, 
{imgId = 104, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
branch = {
{content = 501, jumpAct = 51}
, 
{content = 502, jumpAct = 56}
}
}
, 
[51] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 520, contentType = 4, speakerName = 11}
, 
[53] = {
imgTween = {
{imgId = 104, isDark = false}
}
, content = 530, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[54] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3, nextId = 62}
, 
[56] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 104, isDark = true}
}
, content = 560, contentType = 4, speakerName = 11}
, 
[57] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[58] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 580, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[60] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 600, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[63] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 1, alpha = 0, duration = 0.5}
, 
{imgId = 2, alpha = 1, duration = 0.5, delay = 0.5}
, 
{imgId = 101, alpha = 0}
, 
{imgId = 104, alpha = 0}
}
}
, 
[64] = {
imgTween = {
{imgId = 103, posId = 1}
, 
{imgId = 103, posId = 2, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 640, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 103, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[67] = {
imgTween = {
{imgId = 104, posId = 1}
, 
{imgId = 104, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
, 
{imgId = 103, posId = 1, isDark = false, duration = 0.2}
}
, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
, content = 670, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[68] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[69] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 690, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[70] = {
imgTween = {
{imgId = 104, alpha = 0}
, 
{imgId = 101, alpha = 0}
}
, content = 700, contentType = 4, speakerName = 12}
, 
[71] = {
imgTween = {
{imgId = 104, posId = 3}
}
, content = 710, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[72] = {
imgTween = {
{imgId = 35, posId = 3, isDark = true}
, 
{imgId = 104, alpha = 0}
}
, content = 720, contentType = 2}
, 
[73] = {content = 730, contentType = 2}
, 
[74] = {
imgTween = {
{imgId = 35, duration = 0.2, alpha = 0}
, 
{imgId = 104, alpha = 1}
}
, 
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 740, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, contentShake = true}
, 
[75] = {
imgTween = {
{imgId = 33, posId = 1}
, 
{imgId = 33, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 104, alpha = 0}
}
, content = 750, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[76] = {
imgTween = {
{imgId = 117, posId = 5}
, 
{imgId = 117, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 33, isDark = true}
}
, content = 760, contentType = 3, speakerHeroId = 1017, speakerHeroPosId = 3}
, 
[77] = {
imgTween = {
{imgId = 33, isDark = false}
, 
{imgId = 117, isDark = true}
}
, content = 770, contentType = 3, speakerHeroId = 33, speakerHeroPosId = 1}
, 
[78] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 33, isDark = true}
, 
{imgId = 117, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 780, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 3}
, 
[79] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 101, alpha = 0}
, 
{imgId = 33, alpha = 0}
, 
{imgId = 35, alpha = 1, isDark = false}
}
, content = 790, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[80] = {
imgTween = {
{imgId = 105, posId = 3}
, 
{imgId = 35, alpha = 0}
}
, content = 800, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[81] = {
imgTween = {
{imgId = 105, alpha = 0}
, 
{imgId = 35, alpha = 1}
}
, content = 810, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[83] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 104, alpha = 1}
, 
{imgId = 104, duration = 0.2, shake = true}
, 
{imgId = 104, delay = 1, duration = 0.1, alpha = 0}
}
, content = 830, contentType = 2}
, 
[84] = {content = 840, contentType = 4, speakerName = 13}
, 
[85] = {
imgTween = {
{imgId = 104, posId = 3}
, 
{imgId = 104, posId = 2, duration = 0.5}
, 
{imgId = 104, posId = 1, delay = 0.5, duration = 0.1}
}
, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
, content = 850, contentType = 2}
, 
[86] = {
imgTween = {
{imgId = 35, alpha = 1, duration = 0.2}
}
, content = 860, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[88] = {content = 880, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[89] = {
imgTween = {
{imgId = 35, alpha = 0}
}
, content = 890, contentType = 2}
, 
[90] = {
imgTween = {
{imgId = 35, alpha = 1}
}
, content = 900, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2, 
branch = {
{content = 911, jumpAct = 92}
, 
{content = 912, jumpAct = 96}
}
}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[93] = {content = 930, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[94] = {content = 940, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2, nextId = 98}
, 
[96] = {content = 960, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[97] = {content = 970, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[98] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 101, posId = 3}
}
, content = 980, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[99] = {
imgTween = {
{imgId = 35, alpha = 1, duration = 0.2}
, 
{imgId = 101, alpha = 0}
}
, content = 990, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[100] = {content = 1000, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[101] = {
imgTween = {
{imgId = 35, shake = true, duration = 0.2}
, 
{imgId = 35, delay = 0.5, duration = 0.1, isDark = true}
}
, content = 1010, contentType = 2}
, 
[102] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 101, alpha = 1}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, 
audio = {
sfx = {cue = "AVG_rifle_finalshot_h", sheet = "AVG_gf"}
}
, content = 1020, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[103] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 1030, contentType = 4, speakerName = 14, contentShake = true}
}
return AvgCfg_cpt05_e_11_01

