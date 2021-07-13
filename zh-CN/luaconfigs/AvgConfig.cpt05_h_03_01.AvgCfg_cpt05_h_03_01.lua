-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt05_h_03_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt05/cpt05_e_bg005", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 34, imgType = 3, alpha = 0, imgPath = "odile_w_avg"}
, 
{imgId = 341, imgType = 3, alpha = 0, imgPath = "odile_b_avg"}
, 
{imgId = 35, imgType = 3, alpha = 0, imgPath = "wisdom_b_avg"}
}
, 
audio = {
bgm = {stop = true}
}
, content = 10, contentType = 1}
, 
[2] = {content = 20, contentType = 1, scrambleTypeWriter = true}
, 
[3] = {
imgTween = {
{imgId = 1, alpha = 0.75, duration = 0.5}
}
, 
audio = {
sfx = {cue = "AVG_Heartbeat", sheet = "AVG_gf"}
}
, content = 30, contentType = 2}
, 
[4] = {
imgTween = {
{imgId = 104, posId = 3}
}
, 
heroFace = {
{imgId = 104, faceId = 4}
}
, content = 40, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[5] = {
imgTween = {
{imgId = 104, alpha = 0}
, 
{imgId = 1, alpha = 0, duration = 0.5}
}
, content = 50, contentType = 2}
, 
[6] = {
imgTween = {
{imgId = 34, duration = 0.5, delay = 0.7, alpha = 1}
, 
{imgId = 34, posId = 3, alpha = 0}
, 
{imgId = 1, alpha = 0.75, duration = 0.5}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 60, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2}
, 
[7] = {
imgTween = {
{imgId = 102, posId = 3}
, 
{imgId = 34, alpha = 0}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
, 
audio = {
sfx = {cue = "AVG_Explosion", sheet = "AVG_gf"}
}
, content = 70, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, contentShake = true}
, 
[8] = {
imgTween = {
{imgId = 102, duration = 0.5, 
pos = {250, -330, 0}
, alpha = 0}
, 
{imgId = 102, delay = 1, posId = 3}
}
, content = 80, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, contentShake = true}
, 
[9] = {
imgTween = {
{imgId = 102, duration = 0.5, shake = true}
}
, 
audio = {
sfx = {cue = "AVG_Explode", sheet = "AVG_gf"}
}
, content = 90, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[10] = {
imgTween = {
{imgId = 102, alpha = 0}
}
, content = 100, contentType = 2}
, 
[11] = {
imgTween = {
{imgId = 104, posId = 3}
}
, 
heroFace = {
{imgId = 104, faceId = 6}
}
, content = 110, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, contentShake = true}
, 
[12] = {
imgTween = {
{imgId = 104, alpha = 0}
, 
{imgId = 1, alpha = 0, duration = 1}
}
, 
audio = {
bgm = {stop = true}
}
, autoContinue = true}
, 
[13] = {content = 130, contentType = 4, speakerName = 11}
, 
[14] = {
imgTween = {
{imgId = 102, delay = 2, duration = 0.2, alpha = 1}
, 
{imgId = 1, alpha = 1, duration = 2}
}
, content = 140, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[15] = {
imgTween = {
{imgId = 341, posId = 3}
, 
{imgId = 102, alpha = 0}
}
, 
heroFace = {
{imgId = 341, faceId = 3}
}
, content = 150, contentType = 3, speakerHeroId = 34, speakerHeroPosId = 2}
, 
[16] = {
imgTween = {
{imgId = 102, posId = 1}
, 
{imgId = 102, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 341, isDark = true, posId = 4, duration = 0.2}
}
, content = 160, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[19] = {
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 190, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[20] = {
imgTween = {
{imgId = 103, posId = 5}
, 
{imgId = 103, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 341, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 200, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[21] = {
imgTween = {
{imgId = 104, posId = 5}
, 
{imgId = 104, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 102, isDark = true}
, 
{imgId = 103, posId = 5, isDark = false, duration = 0.2}
}
, 
heroFace = {
{imgId = 104, faceId = 0}
}
, content = 210, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[22] = {
imgTween = {
{imgId = 102, isDark = false}
, 
{imgId = 104, posId = 5, isDark = false, duration = 0.2}
}
, content = 220, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 102, posId = 3, isDark = false, duration = 0.2}
}
, content = 230, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[24] = {
imgTween = {
{imgId = 35, posId = 3}
, 
{imgId = 102, alpha = 0}
}
, content = 240, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[25] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 102, alpha = 1}
}
, content = 250, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, contentShake = true}
, 
[26] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 260, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[27] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 102, alpha = 1}
}
, content = 270, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[28] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 280, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[29] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 102, alpha = 1}
}
, content = 290, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[31] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 310, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[32] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 102, alpha = 1}
}
, content = 320, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[33] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 330, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[34] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 102, alpha = 1}
}
, content = 340, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[35] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 350, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[37] = {
imgTween = {
{imgId = 35, isDark = true}
}
, 
audio = {
sfx = {cue = "Skill_Refactorer_01_Loop", sheet = "Mon_Refactorer", audioId = 14}
}
, content = 370, contentType = 2}
, 
[38] = {
imgTween = {
{imgId = 35, alpha = 0, isDark = false}
, 
{imgId = 102, alpha = 1}
}
, 
audio = {
stopAudioId = {14}
}
, content = 380, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[39] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 390, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[44] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 102, alpha = 1}
}
, content = 440, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[46] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 460, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[47] = {
imgTween = {
{imgId = 35, alpha = 0}
}
, 
audio = {
sfx = {cue = "Atk_Guardian_02", sheet = "Mon_Guardian"}
}
, content = 470, contentType = 2}
, 
[48] = {
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 102, duration = 0.2, shake = true}
}
, content = 480, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, contentShake = true}
, 
[50] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 500, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[56] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 101, posId = 3}
}
, 
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[57] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 101, alpha = 0}
}
, content = 570, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[59] = {
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 35, alpha = 0}
}
, content = 590, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[60] = {
imgTween = {
{imgId = 102, duration = 0.2, shake = true}
, 
{imgId = 102, delay = 0.5, duration = 0, alpha = 0}
}
, content = 600, contentType = 2}
, 
[61] = {
imgTween = {
{imgId = 35, alpha = 1}
}
, content = 610, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[64] = {
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 35, alpha = 0}
}
, content = 640, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[65] = {
imgTween = {
{imgId = 102, alpha = 0}
, 
{imgId = 35, alpha = 1}
}
, content = 650, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[67] = {
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 35, alpha = 0}
}
, content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, contentShake = true}
, 
[68] = {
imgTween = {
{imgId = 102, duration = 0.2, shake = true}
, 
{imgId = 102, delay = 0.5, duration = 0, alpha = 0}
}
, 
audio = {
sfx = {cue = "Skill_Refactorer_01_Loop", sheet = "Mon_Refactorer", audioId = 14}
}
, content = 680, contentType = 2}
, 
[69] = {
imgTween = {
{imgId = 35, alpha = 1}
}
, content = 690, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[70] = {
audio = {
bgm = {stop = true}
}
, content = 700, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[71] = {
imgTween = {
{imgId = 1, duration = 0.5, alpha = 0}
, 
{imgId = 35, alpha = 0}
}
, 
audio = {
stopAudioId = {14}
}
, autoContinue = true}
, 
[72] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 720, contentType = 2}
, 
[73] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, 
audio = {
sfx = {cue = "AVG_Heartbeat", sheet = "AVG_gf"}
}
, content = 730, contentType = 2}
, 
[74] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 740, contentType = 4, speakerName = 11}
, 
[75] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 750, contentType = 2}
, 
[76] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 760, contentType = 2}
, 
[77] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 770, contentType = 4, speakerName = 11}
, 
[78] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 780, contentType = 4, speakerName = 11}
, 
[79] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 790, contentType = 2}
, 
[80] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, content = 800, contentType = 4, speakerName = 11}
, 
[81] = {
imgTween = {
{imgId = 2, duration = 0.5, alpha = 1}
, 
{imgId = 2, duration = 0.5, delay = 1, alpha = 0}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 810, contentType = 4, speakerName = 11}
, 
[82] = {
imgTween = {
{imgId = 1, duration = 0.75, alpha = 1}
}
, autoContinue = true}
, 
[83] = {
imgTween = {
{imgId = 35, posId = 3}
}
, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 830, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[84] = {
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 35, alpha = 0}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 840, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[85] = {
imgTween = {
{imgId = 102, alpha = 0}
, 
{imgId = 35, alpha = 1}
}
, content = 850, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[87] = {
imgTween = {
{imgId = 35, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_weapon_reload", sheet = "AVG_gf"}
}
, content = 870, contentType = 2}
, 
[88] = {
heroFace = {
{imgId = 102, faceId = 0}
}
, 
imgTween = {
{imgId = 102, alpha = 1}
, 
{imgId = 35, alpha = 0, isDark = false}
}
, content = 880, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[89] = {
imgTween = {
{imgId = 102, alpha = 0}
, 
{imgId = 35, alpha = 1}
, 
{imgId = 35, duration = 0.2, shake = true}
}
, content = 890, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[90] = {
imgTween = {
{imgId = 35, alpha = 0}
}
, 
audio = {
sfx = {cue = "Skill_Anna_Ex_Start", sheet = "Chara_Anna"}
}
, content = 900, contentType = 2}
, 
[91] = {
imgTween = {
{imgId = 102, alpha = 1}
}
, content = 910, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[93] = {
imgTween = {
{imgId = 35, alpha = 1}
, 
{imgId = 102, alpha = 0}
}
, content = 930, contentType = 3, speakerHeroId = 35, speakerHeroPosId = 2}
, 
[94] = {
imgTween = {
{imgId = 35, alpha = 0}
, 
{imgId = 102, alpha = 1}
}
, content = 940, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[96] = {
imgTween = {
{imgId = 102, delay = 0.5, duration = 0.2, isDark = true}
}
, 
heroFace = {
{imgId = 102, faceId = 1}
}
, content = 960, contentType = 2}
, 
[97] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 970, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[98] = {content = 980, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
}
return AvgCfg_cpt05_h_03_01

