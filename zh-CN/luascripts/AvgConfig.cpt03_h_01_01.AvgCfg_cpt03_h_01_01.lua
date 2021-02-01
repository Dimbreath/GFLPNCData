-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_h_01_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg008", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "sisy_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "helios_npc_01_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "choco_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "phus_avg"}
}
, content = 10, contentType = 1, nextId = 131, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {
imgTween = {
{imgId = 99, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 20, contentType = 2}
, 
[3] = {
imgTween = {
{imgId = 101, posId = 2}
, 
{imgId = 101, posId = 3, isDark = false, duration = 0.5}
, 
{imgId = 101, alpha = 0, isDark = false, duration = 0.2, delay = 0.6}
}
, content = 30, contentType = 2}
, 
[4] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
}
, content = 40, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[6] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 60, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[7] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 70, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[8] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 80, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[10] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 100, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[11] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 110, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[12] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
}
, content = 120, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[13] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 130, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[15] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[16] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[17] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 170, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[19] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 190, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 25, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 99, duration = 0.5, alpha = 0}
, 
{imgId = 98, duration = 0.5, delay = 0.5, alpha = 1}
}
, content = 210, contentType = 2, autoContinue = true}
, 
[22] = {
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 220, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[24] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, content = 240, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[27] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 270, contentType = 2}
, 
[28] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 280, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 2}
, 
[30] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, 
audio = {
bgm = {stop = true}
}
, content = 300, contentType = 2}
, 
[31] = {
imgTween = {
{imgId = 98, alpha = 0, duration = 0.5}
}
, autoContinue = true}
, 
[32] = {content = 320, contentType = 4, speakerName = 321}
, 
[33] = {content = 330, contentType = 4, speakerName = 321}
, 
[34] = {
imgTween = {
{imgId = 98, alpha = 1, duration = 0.5}
, 
{imgId = 104, posId = 3, alpha = 0}
, 
{imgId = 104, alpha = 1, isDark = false, duration = 0.2}
}
, autoContinue = true}
, 
[35] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 350, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[36] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 104, posId = 2, isDark = true, duration = 0.5}
, 
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
}
, content = 360, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[37] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 1}
, 
[38] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[41] = {
audio = {
bgm = {cue = "Mus_Story_Funny", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 410, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[42] = {
heroFace = {
{imgId = 104, faceId = 7}
}
, 
imgTween = {
{imgId = 104, duration = 0.1, shake = true}
}
, content = 420, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[43] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 430, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[46] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 460, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[47] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 470, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1, contentShake = true}
, 
[48] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[49] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[50] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 500, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[54] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
, 
{imgId = 101, shake = true, duration = 0.2}
}
, content = 540, contentType = 2}
, 
[55] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 550, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[56] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 560, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[57] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 570, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[59] = {
heroFace = {
{imgId = 104, faceId = 4}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 590, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[60] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 600, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[61] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 610, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[62] = {
imgTween = {
{imgId = 104, isDark = true}
, 
{imgId = 101, isDark = true}
}
, content = 620, contentType = 2}
, 
[63] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 101, shake = true, duration = 0.2}
}
, content = 630, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[64] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 640, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[65] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 650, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[66] = {
heroFace = {
{imgId = 104, faceId = 4}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 660, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[67] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 670, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[68] = {
heroFace = {
{imgId = 104, faceId = 4}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 680, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[69] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 690, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[70] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 700, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[71] = {
heroFace = {
{imgId = 104, faceId = 7}
}
, 
imgTween = {
{imgId = 104, duration = 0.1, shake = true}
}
, content = 710, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[72] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 720, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[73] = {
heroFace = {
{imgId = 104, faceId = 5}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 730, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[74] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 740, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[75] = {
heroFace = {
{imgId = 104, faceId = 4}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 750, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[76] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 760, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[77] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 770, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[78] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[79] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 790, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[81] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 810, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[82] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 820, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[83] = {
heroFace = {
{imgId = 104, faceId = 0}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 830, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[84] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 840, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[86] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 860, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[87] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 870, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[88] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 880, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[89] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 890, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[93] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 930, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[94] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 940, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[96] = {
heroFace = {
{imgId = 104, faceId = 5}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 960, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[97] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 970, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[98] = {
imgTween = {
{imgId = 101, duration = 0.1, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, autoContinue = true}
, 
[99] = {content = 990, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[100] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1000, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[101] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1010, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[102] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1020, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[103] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1030, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[105] = {
heroFace = {
{imgId = 104, faceId = 7}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1050, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[106] = {
heroFace = {
{imgId = 104, faceId = 0}
}
, content = 1060, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[107] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1070, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[108] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1080, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[109] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, content = 1090, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[110] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1100, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[111] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1110, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[112] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1120, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[113] = {
heroFace = {
{imgId = 104, faceId = 5}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1130, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[114] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1140, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[115] = {content = 1150, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[116] = {content = 1160, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[117] = {content = 1170, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[118] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 1180, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[119] = {content = 1190, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[120] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1200, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[121] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1210, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[122] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1220, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[123] = {
heroFace = {
{imgId = 101, faceId = 4}
}
, 
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1230, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[124] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1240, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[125] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1250, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[126] = {
heroFace = {
{imgId = 104, faceId = 6}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1260, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[127] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 1270, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[128] = {content = 1280, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3}
, 
[129] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 1290, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[130] = {content = 1300, contentType = 3, speakerHeroId = 24, speakerHeroPosId = 3, isEnd = true}
, 
[131] = {content = 1310, contentType = 1, scrambleTypeWriter = true, nextId = 2}
}
return AvgCfg_cpt03_h_01_01

