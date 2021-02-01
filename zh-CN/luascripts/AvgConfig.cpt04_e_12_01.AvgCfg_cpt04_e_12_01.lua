-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_12_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg006", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 12, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "adele_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "eniac_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
imgTween = {
{imgId = 99, alpha = 1, duration = 0.2}
, 
{imgId = 102, posId = 3, alpha = 0}
, 
{imgId = 102, alpha = 1, delay = 0.2, isDark = false, duration = 0.5}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 102, faceId = 3}
}
, content = 10, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, contentShake = true}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[3] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 30, contentType = 2}
, 
[4] = {
audio = {
sfx = {cue = "Atk_Sol_01", sheet = "Chara_Sol"}
}
, 
imgTween = {
{imgId = 3, posId = 3}
, 
{imgId = 3, shake = true, duration = 0.5}
}
, 
heroFace = {
{imgId = 3, faceId = 6}
}
, content = 40, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[5] = {
audio = {
sfx = {cue = "Skill_Sol_01", sheet = "Chara_Sol"}
}
, 
imgTween = {
{imgId = 3, alpha = 0, isDark = false, duration = 0.2}
}
, content = 50, contentType = 2}
, 
[6] = {
heroFace = {
{imgId = 102, faceId = 1}
}
, 
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
}
, content = 60, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[7] = {
heroFace = {
{imgId = 102, faceId = 3}
}
, content = 70, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[8] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 80, contentType = 2}
, 
[9] = {
imgTween = {
{imgId = 3, alpha = 1, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 3, faceId = 3}
}
, content = 90, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[10] = {
heroFace = {
{imgId = 3, faceId = 4}
}
, content = 100, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[12] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 0, isDark = false, duration = 0.2}
}
, content = 120, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[13] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, posId = 3}
}
, 
heroFace = {
{imgId = 1, faceId = 4}
}
, content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[15] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 102, faceId = 4}
}
, content = 150, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[16] = {
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 160, contentType = 2}
, 
[17] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 1, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 3, faceId = 5}
}
, content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
branch = {
{content = 171, jumpAct = 18}
, 
{content = 172, jumpAct = 18}
}
}
, 
[18] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 0, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 102, faceId = 3}
}
, content = 180, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[19] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 190, contentType = 4, speakerName = 11}
, 
[20] = {content = 200, contentType = 4, speakerName = 11}
, 
[21] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
}
, content = 210, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[25] = {
heroFace = {
{imgId = 102, faceId = 0}
}
, content = 250, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[27] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[28] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 102, faceId = 4}
}
, content = 280, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[29] = {
audio = {
bgm = {stop = true}
}
, 
images = {
{imgId = 102, delete = true}
, 
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
}
, 
imgTween = {
{imgId = 99, alpha = 0, duration = 0.2}
, 
{imgId = 97, alpha = 1, duration = 0.2}
}
, content = 290, contentType = 2}
, 
[30] = {
imgTween = {
{imgId = 97, alpha = 0, duration = 0.3}
, 
{imgId = 98, alpha = 1, delay = 0.3, duration = 0.3}
}
, autoContinue = true}
, 
[31] = {
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
images = {
{imgId = 99, delete = true}
, 
{imgId = 97, delete = true}
}
, 
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 3, faceId = 3}
}
, content = 310, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
branch = {
{content = 311, jumpAct = 32}
, 
{content = 312, jumpAct = 34}
}
}
, 
[32] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
}
, 
heroFace = {
{imgId = 1, faceId = 0}
}
, content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[34] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 1, isDark = true}
}
, 
heroFace = {
{imgId = 3, faceId = 0}
}
, content = 340, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[36] = {
heroFace = {
{imgId = 3, faceId = 5}
}
, content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[37] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Loop", sheet = "Mon_Guardian", audioId = 37}
}
, 
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
}
, content = 370, contentType = 2}
, 
[38] = {
audio = {
stopAudioId = {37}
}
, content = 380, contentType = 2}
, 
[39] = {
imgTween = {
{imgId = 12, posId = 4}
, 
{imgId = 12, duration = 0.5, shake = true}
}
, content = 390, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[40] = {
heroFace = {
{imgId = 12, faceId = 1}
}
, content = 400, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[41] = {
imgTween = {
{imgId = 104, posId = 1}
, 
{imgId = 104, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 12, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[42] = {
imgTween = {
{imgId = 104, isDark = true}
}
, content = 420, contentType = 2}
, 
[43] = {
imgTween = {
{imgId = 104, isDark = false}
}
, 
heroFace = {
{imgId = 104, faceId = 1}
}
, content = 430, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1, contentShake = true}
, 
[44] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 104, isDark = true}
}
, 
heroFace = {
{imgId = 12, faceId = 1}
}
, content = 440, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[45] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 12, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 1, isDark = false, duration = 0.2}
}
, content = 450, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[46] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 3, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[47] = {
heroFace = {
{imgId = 3, faceId = 0}
}
, 
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 5, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 12, posId = 4, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 12, faceId = 0}
}
, content = 480, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 104, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 12, posId = 5, isDark = false, duration = 0.2}
}
, content = 490, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 104, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 103, posId = 3}
}
, content = 500, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[54] = {
imgTween = {
{imgId = 103, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 3}
}
, content = 540, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[55] = {
heroFace = {
{imgId = 104, faceId = 0}
}
, content = 550, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[56] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, content = 560, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 2}
, 
[59] = {
imgTween = {
{imgId = 103, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 104, alpha = 0, isDark = false, duration = 0.2}
}
, content = 590, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[60] = {
heroFace = {
{imgId = 1, faceId = 5}
}
, 
imgTween = {
{imgId = 1, posId = 2, isDark = false}
, 
{imgId = 103, posId = 4, isDark = true, duration = 0.5}
}
, content = 600, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[61] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 3, 
branch = {
{content = 611, jumpAct = 62}
, 
{content = 612, jumpAct = 76}
}
}
, 
[62] = {
imgTween = {
{imgId = 103, isDark = true}
}
, content = 620, contentType = 4, speakerName = 11}
, 
[63] = {content = 630, contentType = 2}
, 
[64] = {
imgTween = {
{imgId = 103, isDark = false}
}
, content = 640, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 3}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 3}
, 
[66] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[73] = {
heroFace = {
{imgId = 1, faceId = 0}
}
, 
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 730, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, nextId = 88}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 3}
, 
[77] = {content = 770, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 3}
, 
[78] = {content = 780, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 3}
, 
[79] = {content = 790, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 3}
, 
[80] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, content = 800, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[82] = {
heroFace = {
{imgId = 1, faceId = 5}
}
, 
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 820, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[84] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 840, contentType = 4, speakerName = 11}
, 
[85] = {
heroFace = {
{imgId = 1, faceId = 0}
}
, 
imgTween = {
{imgId = 1, isDark = false}
}
, content = 850, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[88] = {
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 2, posId = 5, isDark = false, duration = 0.2}
}
, content = 880, contentType = 2}
, 
[89] = {
imgTween = {
{imgId = 103, posId = 3, alpha = 1}
}
, content = 890, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[93] = {
heroFace = {
{imgId = 1, faceId = 0}
}
, 
imgTween = {
{imgId = 103, duration = 0.2, alpha = 0}
, 
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 930, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[94] = {content = 940, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[95] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, 
heroFace = {
{imgId = 2, faceId = 5}
}
, content = 950, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[96] = {
heroFace = {
{imgId = 1, faceId = 2}
}
, 
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 960, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[97] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 970, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[98] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 980, contentType = 2, 
branch = {
{content = 981, jumpAct = 99}
}
}
, 
[99] = {content = 990, contentType = 4, speakerName = 11}
, 
[100] = {
heroFace = {
{imgId = 2, faceId = 2}
}
, 
imgTween = {
{imgId = 2, isDark = false}
}
, content = 1000, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[101] = {
heroFace = {
{imgId = 2, faceId = 1}
}
, content = 1010, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[102] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 1020, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[103] = {
imgTween = {
{imgId = 1, duration = 0.5, 
pos = {300, -310, 0}
}
, 
{imgId = 2, isDark = false}
, 
{imgId = 2, shake = true, duration = 0.2, delay = 0.6}
, 
{imgId = 1, alpha = 0, delay = 0.8, duration = 0.2}
, 
{imgId = 2, alpha = 0, delay = 0.8, duration = 0.2}
}
, content = 1030, contentType = 2}
, 
[104] = {
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 1, posId = 3, alpha = 0}
, 
{imgId = 1, alpha = 1, duration = 1}
}
, content = 1040, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[105] = {
imgTween = {
{imgId = 2, 
pos = {0, -330, 0}
, 
rot = {0, 0, 0}
, alpha = 0, isDark = false}
, 
{imgId = 2, duration = 0.5, alpha = 1, isDark = false}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 1050, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[106] = {
imgTween = {
{imgId = 3, posId = 1}
, 
{imgId = 3, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 2, posId = 4, isDark = true, duration = 0.2}
}
, content = 1060, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, contentShake = true}
, 
[107] = {
heroFace = {
{imgId = 2, faceId = 5}
, 
{imgId = 3, faceId = 0}
}
, content = 1070, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[108] = {content = 1080, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[109] = {content = 1090, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[110] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 3, isDark = true}
}
, 
heroFace = {
{imgId = 2, faceId = 1}
}
, content = 1100, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[111] = {content = 1110, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[112] = {
imgTween = {
{imgId = 3, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 1120, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[113] = {content = 1130, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1}
, 
[114] = {
imgTween = {
{imgId = 3, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 2, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 1}
, 
{imgId = 104, posId = 2, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
, content = 1140, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[115] = {content = 1150, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[116] = {
imgTween = {
{imgId = 12, posId = 5}
, 
{imgId = 12, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 104, isDark = true}
}
, content = 1160, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[117] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 12, isDark = true}
}
, content = 1170, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[118] = {
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 104, isDark = true}
}
, 
heroFace = {
{imgId = 12, faceId = 1}
}
, content = 1180, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[119] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 12, isDark = true}
}
, 
heroFace = {
{imgId = 104, faceId = 1}
}
, content = 1190, contentType = 3, speakerHeroId = 27, speakerHeroPosId = 1}
, 
[120] = {
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 12, isDark = false}
, 
{imgId = 104, isDark = true}
, 
{imgId = 12, duration = 0.2, shake = true}
}
, 
heroFace = {
{imgId = 12, faceId = 0}
}
, content = 1200, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 3}
, 
[121] = {
imgTween = {
{imgId = 1, posId = 3}
, 
{imgId = 12, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 1, isDark = false, duration = 0.2}
}
, content = 1210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[122] = {
imgTween = {
{imgId = 103, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 1220, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[123] = {
imgTween = {
{imgId = 103, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 1230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[124] = {content = 1240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[125] = {
imgTween = {
{imgId = 103, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 1250, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[126] = {
audio = {
bgm = {stop = true}
}
, 
imgTween = {
{imgId = 103, isDark = true}
}
, content = 1260, contentType = 2}
, 
[127] = {
imgTween = {
{imgId = 103, alpha = 0, isDark = false, duration = 1}
, 
{imgId = 98, alpha = 0, isDark = false, duration = 2}
}
, content = 1270, contentType = 1}
, 
[128] = {content = 1280, contentType = 1}
, 
[129] = {content = 1290, contentType = 1}
}
return AvgCfg_cpt04_e_12_01

