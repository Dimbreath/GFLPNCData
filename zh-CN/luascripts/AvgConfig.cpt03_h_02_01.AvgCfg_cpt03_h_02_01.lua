-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_h_02_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg002", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt03/cpt03_e_bg005", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "zion_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "helios_npc_01_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "helios_npc_02_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "choco_avg"}
}
, 
audio = {
bgm = {stop = true}
}
, content = 10, contentType = 1, scrambleTypeWriter = true}
, 
[2] = {
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 99, duration = 0.5, alpha = 1}
, 
{imgId = 101, duration = 0.2, delay = 1, alpha = 0}
}
, 
audio = {
bgm = {cue = "Mus_Story_Funny", sheet = "Music", fadeIn = 2, fadeOut = 2}
}
, content = 20, contentType = 2}
, 
[3] = {content = 30, contentType = 2}
, 
[4] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
}
, content = 40, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[5] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 50, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[6] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 60, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[7] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 70, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[9] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 90, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[10] = {
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 102, alpha = 0}
, 
{imgId = 101, posId = 1, isDark = false, duration = 0.5}
}
, content = 100, contentType = 2}
, 
[11] = {
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 1}
}
, content = 110, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[12] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
}
, content = 120, contentType = 2}
, 
[13] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
}
, content = 130, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[14] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 140, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[15] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 150, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[16] = {
imgTween = {
{imgId = 103, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 160, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[17] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 103, isDark = true}
}
, content = 170, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[18] = {
imgTween = {
{imgId = 101, posId = 3, duration = 0.5}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, autoContinue = true}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[21] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 210, contentType = 2}
, 
[22] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 220, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[23] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 230, contentType = 2}
, 
[24] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 240, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
, 
{imgId = 99, alpha = 0, duration = 0.5}
, 
{imgId = 99, alpha = 1, delay = 0.5, duration = 0.5}
}
, content = 250, contentType = 2}
, 
[26] = {
imgTween = {
{imgId = 101, posId = 1}
, 
{imgId = 101, posId = 2, isDark = false, duration = 0.2}
}
, content = 260, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 102, posId = 5}
, 
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 101, isDark = true}
}
, content = 270, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[28] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 280, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[29] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 290, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[30] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 102, isDark = true}
}
, content = 300, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[31] = {
audio = {
bgm = {stop = true}
}
, content = 310, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 1}
, 
[33] = {
imgTween = {
{imgId = 101, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
}
, content = 330, contentType = 2}
, 
[34] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 102, posId = 4, isDark = false, duration = 0.2}
}
, content = 340, contentType = 3, speakerHeroId = 14, speakerHeroPosId = 3}
, 
[35] = {
imgTween = {
{imgId = 102, posId = 5, isDark = false, duration = 0.2}
}
, content = 350, contentType = 2}
, 
[36] = {
imgTween = {
{imgId = 101, posId = 3}
, 
{imgId = 101, shake = true, duration = 0.2}
}
, content = 360, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[37] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 370, contentType = 4, speakerName = 11}
, 
[38] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 380, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[39] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 390, contentType = 2}
, 
[40] = {
imgTween = {
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 400, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[41] = {
audio = {
sfx = {cue = "Skill_Lam_01_Start", sheet = "Chara_Lam"}
}
, 
imgTween = {
{imgId = 101, alpha = 0, duration = 0.2}
}
, content = 410, contentType = 4, speakerName = 11}
, 
[42] = {
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol"}
}
, content = 420, contentType = 2}
, 
[43] = {
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 99, alpha = 0, duration = 0.5}
}
, content = 430, contentType = 2}
, 
[44] = {
imgTween = {
{imgId = 99, alpha = 1, duration = 0.5}
, 
{imgId = 101, alpha = 1, duration = 0.2}
}
, content = 440, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[45] = {
imgTween = {
{imgId = 101, alpha = 0, duration = 0.5}
}
, content = 450, contentType = 4, speakerName = 11}
, 
[46] = {
audio = {
sfx = {cue = "AVG_Explosion", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 1}
, 
{imgId = 101, duration = 0.5, delay = 1, shake = true}
}
, content = 460, contentType = 2}
, 
[47] = {
imgTween = {
{imgId = 99, alpha = 0, duration = 0.5}
, 
{imgId = 101, alpha = 0, duration = 0.2}
, 
{imgId = 98, alpha = 1, duration = 0.5, delay = 0.5}
}
, 
audio = {
sfx = {cue = "AVG_bigglassbreak", sheet = "AVG_gf"}
, 
bgm = {stop = true}
}
}
, 
[48] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, 
imgTween = {
{imgId = 104, posId = 3, alpha = 0}
, 
{imgId = 104, alpha = 1, duration = 0.2}
}
, content = 480, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[49] = {
heroFace = {
{imgId = 104, faceId = 7}
}
, content = 490, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[50] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 2, isDark = true, duration = 0.2}
}
, content = 500, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[51] = {
heroFace = {
{imgId = 104, faceId = 5}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 510, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[52] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 520, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[53] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 530, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[54] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 540, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[55] = {
heroFace = {
{imgId = 104, faceId = 0}
}
, 
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 550, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[56] = {
audio = {
bgm = {cue = "Mus_Story_Funny", sheet = "Music", fadeIn = 2, fadeOut = 2}
}
, 
imgTween = {
{imgId = 101, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 1, isDark = false, duration = 0.2}
}
, content = 560, contentType = 2}
, 
[57] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Start", sheet = "Mon_Guardian"}
}
, 
imgTween = {
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 99, duration = 0.5, alpha = 1}
}
, content = 570, contentType = 4, speakerName = 11}
, 
[58] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 1}
, 
{imgId = 99, duration = 0.5, alpha = 0}
, 
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 1, delay = 0.5}
}
, content = 580, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[59] = {
imgTween = {
{imgId = 99, duration = 0.5, alpha = 1}
, 
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 101, alpha = 0}
}
, content = 590, contentType = 4, speakerName = 11}
, 
[60] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 1}
, 
{imgId = 99, duration = 0.5, alpha = 0}
, 
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 1, delay = 0.5}
}
, content = 600, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 2}
, 
[61] = {
imgTween = {
{imgId = 98, duration = 0.5, alpha = 0}
, 
{imgId = 99, duration = 0.5, alpha = 1}
, 
{imgId = 101, alpha = 0}
, 
{imgId = 104, posId = 3, alpha = 0}
, 
{imgId = 104, duration = 0.2, alpha = 1, delay = 0.5}
}
, content = 610, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[62] = {
imgTween = {
{imgId = 104, isDark = true}
}
, content = 620, contentType = 4, speakerName = 11}
, 
[63] = {
heroFace = {
{imgId = 104, faceId = 7}
}
, 
imgTween = {
{imgId = 104, isDark = false}
}
, content = 630, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[64] = {
heroFace = {
{imgId = 104, faceId = 0}
}
, 
imgTween = {
{imgId = 104, isDark = true}
}
, content = 640, contentType = 4, speakerName = 11}
, 
[65] = {
imgTween = {
{imgId = 104, isDark = false}
}
, content = 650, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[66] = {
imgTween = {
{imgId = 104, isDark = true}
}
, content = 660, contentType = 4, speakerName = 11}
, 
[67] = {
imgTween = {
{imgId = 104, isDark = false}
}
, content = 670, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[68] = {
imgTween = {
{imgId = 104, isDark = true}
}
, content = 680, contentType = 4, speakerName = 11}
, 
[69] = {
imgTween = {
{imgId = 104, isDark = false}
}
, content = 690, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[70] = {
imgTween = {
{imgId = 104, isDark = true}
}
, content = 700, contentType = 4, speakerName = 11}
, 
[71] = {content = 710, contentType = 4, speakerName = 11}
, 
[72] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, 
imgTween = {
{imgId = 104, isDark = false}
}
, content = 720, contentType = 3, speakerHeroId = 23}
, 
[73] = {
imgTween = {
{imgId = 104, isDark = true}
}
, content = 730, contentType = 4, speakerName = 11}
, 
[74] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Start", sheet = "Mon_Guardian"}
}
, content = 740, contentType = 4, speakerName = 11}
, 
[75] = {
heroFace = {
{imgId = 104, faceId = 0}
}
, 
imgTween = {
{imgId = 104, isDark = false}
}
, content = 750, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 2}
, 
[76] = {
imgTween = {
{imgId = 101, posId = 5}
, 
{imgId = 101, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 104, posId = 2, duration = 0.2, isDark = true}
}
, content = 760, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[77] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 770, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[78] = {
audio = {
bgm = {stop = true}
}
, 
imgTween = {
{imgId = 98, duration = 0.5, alpha = 1}
, 
{imgId = 99, duration = 0.5, alpha = 0}
, 
{imgId = 101, alpha = 0}
, 
{imgId = 104, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 1, isDark = false, delay = 0.5}
, 
{imgId = 104, duration = 0.2, alpha = 1, isDark = true, delay = 0.5}
}
, content = 780, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[79] = {
imgTween = {
{imgId = 104, isDark = false}
, 
{imgId = 101, isDark = true}
}
, content = 790, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[80] = {
heroFace = {
{imgId = 104, faceId = 1}
}
, content = 800, contentType = 3, speakerHeroId = 23, speakerHeroPosId = 1}
, 
[81] = {
imgTween = {
{imgId = 101, isDark = false}
, 
{imgId = 104, isDark = true}
}
, content = 810, contentType = 3, speakerHeroId = 1027, speakerHeroPosId = 3}
, 
[82] = {
imgTween = {
{imgId = 101, duration = 0.2, alpha = 0}
, 
{imgId = 104, duration = 0.2, alpha = 0}
}
, content = 820, contentType = 2}
, 
[83] = {
imgTween = {
{imgId = 99, duration = 0.5, alpha = 1}
, 
{imgId = 98, duration = 0.5, alpha = 0}
}
, content = 830, contentType = 2}
}
return AvgCfg_cpt03_h_02_01

