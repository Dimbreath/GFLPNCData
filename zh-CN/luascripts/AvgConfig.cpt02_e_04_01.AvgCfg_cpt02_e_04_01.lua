-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_e_04_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg002", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg003", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 4, imgType = 3, 
rot = {0, 180, 0}
, alpha = 0, imgPath = "simo_avg"}
, 
{imgId = 5, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "croque_avg"}
, 
{imgId = 13, imgType = 3, alpha = 0, 
rot = {0, 180, 0}
, imgPath = "betty_avg"}
, 
{imgId = 34, imgType = 3, alpha = 0, imgPath = "abigail_avg"}
}
, 
imgTween = {
{imgId = 98, duration = 1, alpha = 1}
, 
{imgId = 13, posId = 1}
, 
{imgId = 13, duration = 0.2, posId = 2}
}
, content = 10, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 3, fadeOut = 4}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 13, isDark = true}
, 
{imgId = 34, posId = 5}
, 
{imgId = 34, duration = 0.2, posId = 4}
}
, content = 30, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3}
, 
[4] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 13, isDark = true}
, 
{imgId = 34, posId = 5, isDark = false, duration = 0.2}
}
, content = 40, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[5] = {
imgTween = {
{imgId = 4, isDark = true}
}
, content = 50, contentType = 4, speakerName = 11}
, 
[6] = {
imgTween = {
{imgId = 4, isDark = false}
}
, content = 60, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[7] = {
imgTween = {
{imgId = 98, duration = 1, alpha = 0}
, 
{imgId = 4, duration = 0.5, alpha = 0}
, 
{imgId = 13, duration = 0.5, alpha = 0}
, 
{imgId = 97, duration = 1, delay = 1, alpha = 1}
}
, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf", audioId = 0}
}
}
, 
[8] = {
imgTween = {
{imgId = 13, posId = 1}
, 
{imgId = 13, duration = 0.2, posId = 2, isDark = false}
}
, content = 80, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[9] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, duration = 0.2, posId = 4}
, 
{imgId = 13, isDark = true}
}
, content = 90, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 2, faceId = 5}
}
}
, 
[10] = {
imgTween = {
{imgId = 13, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 100, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[11] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 13, isDark = true}
}
, content = 110, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 2, faceId = 2}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 2, faceId = 5}
}
}
, 
[13] = {
imgTween = {
{imgId = 4, posId = 1}
, 
{imgId = 4, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 13, posId = 1, isDark = false, duration = 0.2}
}
, content = 130, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[14] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
heroFace = {
{imgId = 2, faceId = 2}
}
}
, 
[15] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[16] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[17] = {
imgTween = {
{imgId = 2, isDark = true}
}
, content = 170, contentType = 4, speakerName = 11}
, 
[18] = {
imgTween = {
{imgId = 13, posId = 1}
, 
{imgId = 13, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 4, posId = 1, isDark = false, duration = 0.2}
}
, content = 180, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[19] = {
imgTween = {
{imgId = 34, posId = 5}
, 
{imgId = 34, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 13, isDark = true}
, 
{imgId = 2, posId = 5, isDark = false, duration = 0.2}
}
, content = 190, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3}
, 
[20] = {
imgTween = {
{imgId = 13, isDark = false}
, 
{imgId = 34, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[21] = {
imgTween = {
{imgId = 13, isDark = true}
}
, content = 210, contentType = 4, speakerName = 11}
, 
[22] = {
imgTween = {
{imgId = 13, isDark = false}
, 
{imgId = 34, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 34, isDark = false}
, 
{imgId = 13, isDark = true}
}
, content = 230, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3}
, 
[24] = {
imgTween = {
{imgId = 13, isDark = false}
, 
{imgId = 34, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 13, isDark = true}
}
, content = 250, contentType = 4, speakerName = 11}
, 
[26] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 13, isDark = true}
, 
{imgId = 34, posId = 5, isDark = false, duration = 0.2}
}
, content = 260, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[27] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 2, isDark = true}
, 
{imgId = 13, posId = 1, isDark = false, duration = 0.2}
}
, content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 2}
}
}
, 
[30] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 2, posId = 5, isDark = false, duration = 0.2}
}
, content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[31] = {
imgTween = {
{imgId = 3, duration = 0.5, posId = 5}
}
, 
audio = {
sfx = {cue = "AVG_Walk", sheet = "AVG_gf", audioId = 0}
}
, content = 310, contentType = 4, speakerName = 11}
, 
[32] = {content = 320, contentType = 4, speakerName = 11}
, 
[33] = {
imgTween = {
{imgId = 2, duration = 0.5, posId = 4, isDark = false}
}
, content = 330, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[34] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[35] = {
imgTween = {
{imgId = 2, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 350, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[36] = {
imgTween = {
{imgId = 13, posId = 5}
, 
{imgId = 13, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 2, posId = 5, isDark = false, duration = 0.2}
}
, content = 360, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 3}
, 
[37] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 13, isDark = true}
}
, content = 370, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 2}
}
}
, 
[38] = {
imgTween = {
{imgId = 13, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 380, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 3}
, 
[39] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 13, isDark = true}
}
, content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[40] = {
imgTween = {
{imgId = 34, posId = 5}
, 
{imgId = 34, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 13, posId = 5, isDark = false, duration = 0.2}
}
, content = 400, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3}
, 
[41] = {
imgTween = {
{imgId = 13, posId = 5}
, 
{imgId = 13, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 34, posId = 5, isDark = false, duration = 0.2}
}
, content = 410, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 3}
, 
[42] = {
imgTween = {
{imgId = 34, posId = 5}
, 
{imgId = 34, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 13, posId = 5, isDark = false, duration = 0.2}
}
, content = 420, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3}
, 
[43] = {
imgTween = {
{imgId = 13, posId = 5}
, 
{imgId = 13, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 34, posId = 5, isDark = false, duration = 0.2}
}
, content = 430, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 3}
, 
[44] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 13, isDark = true}
}
, content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[46] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 13, posId = 5, isDark = false, duration = 0.2}
}
, content = 460, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[47] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 2, posId = 5, isDark = false, duration = 0.2}
}
, 
audio = {
sfx = {cue = "AVG_door_elecport", sheet = "AVG_gf", audioId = 0}
}
, content = 470, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[48] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 4, isDark = true}
}
, content = 480, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[49] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 490, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[50] = {
imgTween = {
{imgId = 13, posId = 5}
, 
{imgId = 13, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 4, posId = 5, isDark = false, duration = 0.2}
}
, content = 500, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 3}
, 
[51] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 13, posId = 5, isDark = false, duration = 0.2}
}
, content = 510, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[52] = {
imgTween = {
{imgId = 34, posId = 5}
, 
{imgId = 34, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 4, posId = 5, isDark = false, duration = 0.2}
}
, content = 520, contentType = 3, speakerHeroId = 1034, speakerHeroPosId = 3}
, 
[53] = {
imgTween = {
{imgId = 13, posId = 5}
, 
{imgId = 13, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 34, posId = 5, isDark = false, duration = 0.2}
}
, content = 530, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 3}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1013, speakerHeroPosId = 3}
, 
[55] = {
imgTween = {
{imgId = 4, posId = 5}
, 
{imgId = 4, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 13, posId = 5, isDark = false, duration = 0.2}
}
, content = 550, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[59] = {
imgTween = {
{imgId = 2, posId = 1}
, 
{imgId = 2, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 4, isDark = true}
, 
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
}
, content = 590, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[63] = {
imgTween = {
{imgId = 4, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 630, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[65] = {
imgTween = {
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 4, isDark = true}
, 
{imgId = 2, posId = 1, isDark = false, duration = 0.2}
}
, content = 650, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 2}
}
}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[68] = {
imgTween = {
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 4, posId = 5, isDark = false, duration = 0.2}
}
, content = 680, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[69] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 690, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[70] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 700, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
heroFace = {
{imgId = 5, faceId = 5}
}
}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[72] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 720, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[73] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 730, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[74] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 740, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 2}
}
}
, 
[75] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 750, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
heroFace = {
{imgId = 5, faceId = 0}
}
}
, 
[76] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 760, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 0}
}
}
, 
[77] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 770, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[78] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 780, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 5}
}
}
, 
[79] = {
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 790, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[81] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 810, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
heroFace = {
{imgId = 1, faceId = 0}
}
}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
}
return AvgCfg_cpt02_e_04_01

