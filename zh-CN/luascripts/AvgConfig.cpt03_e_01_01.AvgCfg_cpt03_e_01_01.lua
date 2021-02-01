-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_e_01_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 98, imgType = 4, alpha = 0, imgPath = "cpt00/cpt00_e_bg004", fullScreen = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg008", fullScreen = true}
, 
{imgId = 96, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg005", fullScreen = true}
, 
{imgId = 95, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg001", fullScreen = true}
, 
{imgId = 94, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "helios_npc_01_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "choco_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "phus_avg"}
}
, 
imgTween = {
{imgId = 97, delay = 1, duration = 2, alpha = 1}
, 
{imgId = 101, posId = 1}
, 
{imgId = 101, duration = 0.5, delay = 3, posId = 2}
}
, 
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 10, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 104, posId = 5}
, 
{imgId = 104, duration = 0.5, posId = 4}
}
, 
heroFace = {
{imgId = 104, faceId = 1}
}
, content = 20, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[3] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 30, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[4] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 104, isDark = false}
}
, content = 40, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = false}
}
, content = 50, contentType = 4, speakerName = 12, 
audio = {
sfx = {cue = "Skill_Hubble_Ex_Cast", sheet = "Chara_Hubble"}
}
}
, 
[6] = {
imgTween = {
{imgId = 97, duration = 2, shake = true}
, 
{imgId = 101, isDark = true}
, 
{imgId = 101, delay = 2, duration = 0.2, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 60, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_Relax", sheet = "Music", fadeIn = 2, fadeOut = 2}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[8] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 104, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
, content = 80, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[9] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 90, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[10] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 104, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 1}
}
, content = 100, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[11] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 110, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[12] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 120, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[14] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[15] = {
imgTween = {
{imgId = 101, duration = 0.5, posId = 1}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 4, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
, content = 150, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3, 
audio = {
bgm = {stop = true}
}
}
, 
[16] = {
imgTween = {
{imgId = 104, posId = 3, isDark = false, duration = 0.5}
}
, content = 160, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 2}
, 
[17] = {
imgTween = {
{imgId = 104, alpha = 0}
}
, content = 170, contentType = 1}
, 
[18] = {
imgTween = {
{imgId = 97, duration = 1, alpha = 0}
, 
{imgId = 96, duration = 1, delay = 1, alpha = 1}
}
}
, 
[19] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
}
, content = 190, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_Door_Open_Close", sheet = "AVG_gf"}
}
}
, 
[20] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, posId = 1}
, 
{imgId = 103, duration = 0.2, posId = 2}
}
, 
heroFace = {
{imgId = 103, faceId = 1}
}
, content = 200, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 4}
}
}
, 
[21] = {
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 210, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[22] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[23] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 230, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[25] = {
imgTween = {
{imgId = 102, isDark = true}
, 
{imgId = 103, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 1}
}
, content = 250, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[26] = {
imgTween = {
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 103, isDark = true}
}
, content = 260, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[27] = {
imgTween = {
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
}
, 
[29] = {
imgTween = {
{imgId = 102, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 290, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[30] = {
imgTween = {
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 103, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[31] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 0}
}
, content = 310, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 330, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[34] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 340, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[37] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[39] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 1}
}
, content = 390, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[40] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 400, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 420, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[43] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 430, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 1}
}
, content = 480, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 103, duration = 0.1, shake = true}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 490, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 1}
}
, content = 510, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[52] = {
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 520, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1, 
audio = {
bgm = {stop = true}
}
}
, 
[53] = {
imgTween = {
{imgId = 96, duration = 1.5, shake = true}
, 
{imgId = 101, isDark = false}
, 
{imgId = 101, duration = 1.5, shake = true}
, 
{imgId = 103, isDark = false}
, 
{imgId = 103, duration = 1.5, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
}
, 
[54] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 7}
}
, content = 540, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1, contentShake = true}
, 
[55] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 96, duration = 0.5, alpha = 0}
, 
{imgId = 94, duration = 0.5, alpha = 1}
, 
{imgId = 101, alpha = 0}
, 
{imgId = 103, alpha = 0}
}
, content = 560, contentType = 2, 
audio = {
sfx = {cue = "AVG_Crowd_Run", sheet = "AVG_gf", audioId = 1}
}
}
, 
[57] = {
imgTween = {
{imgId = 96, duration = 0.5, alpha = 1}
, 
{imgId = 94, duration = 0.5, alpha = 0}
, 
{imgId = 101, duration = 0.7, alpha = 1}
, 
{imgId = 103, duration = 0.7, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
, 
{imgId = 103, faceId = 6}
}
, content = 570, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, contentShake = true, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 4}
, 
stopAudioId = {1}
}
}
, 
[58] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 580, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[59] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 590, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[60] = {
imgTween = {
{imgId = 101, isDark = true}
, 
{imgId = 103, isDark = false}
}
, content = 600, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[61] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, contentShake = true}
, 
[62] = {
imgTween = {
{imgId = 101, duration = 1, 
pos = {-250, -300, 0}
}
, 
{imgId = 101, delay = 1, duration = 0.1, 
pos = {-251, -300, 0}
}
, 
{imgId = 101, delay = 1.5, duration = 0.2, 
pos = {-500, -300, 0}
, alpha = 0}
, 
{imgId = 103, alpha = 1, 
pos = {-400, -350, 0}
, isDark = false}
, 
{imgId = 103, delay = 1.1, duration = 0.3, shake = true}
, 
{imgId = 103, delay = 1.5, duration = 0.2, 
pos = {-500, -350, 0}
, alpha = 0}
}
, content = 620, contentType = 2, 
audio = {
sfx = {cue = "AVG_Door_Open_Close", sheet = "AVG_gf"}
}
}
, 
[63] = {
images = {
{imgId = 101, delete = true}
, 
{imgId = 104, delete = true}
}
, 
imgTween = {
{imgId = 96, duration = 1, alpha = 0}
, 
{imgId = 95, duration = 1, delay = 1, alpha = 1}
}
}
, 
[64] = {
images = {
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
}
, 
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
}
, content = 640, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[66] = {
heroFace = {
{imgId = 5, faceId = 5}
}
, content = 660, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[67] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, 
heroFace = {
{imgId = 5, faceId = 5}
, 
{imgId = 1, faceId = 5}
}
, content = 670, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[68] = {
imgTween = {
{imgId = 95, duration = 1, shake = true}
, 
{imgId = 5, isDark = false}
, 
{imgId = 1, duration = 1, shake = true}
, 
{imgId = 5, duration = 1, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
}
, 
[69] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 690, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[70] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 700, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[71] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, 
heroFace = {
{imgId = 5, faceId = 6}
}
, content = 710, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[72] = {
imgTween = {
{imgId = 5, isDark = true}
}
, content = 720, contentType = 4, speakerName = 11}
, 
[73] = {
imgTween = {
{imgId = 5, duration = 0.2, 
pos = {0, -300, 0}
, isDark = false}
, 
{imgId = 1, duration = 0.2, posId = 1}
}
, 
heroFace = {
{imgId = 5, faceId = 0}
}
, content = 730, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
}
return AvgCfg_cpt03_e_01_01

