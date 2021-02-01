-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_11_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 12, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 36, imgType = 3, alpha = 0, imgPath = "lam_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
imgTween = {
{imgId = 2, posId = 3, alpha = 0}
, 
{imgId = 2, alpha = 1, delay = 0.2, isDark = true, duration = 0.5}
}
, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
, content = 10, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 31, jumpAct = 4}
, 
{content = 32, jumpAct = 5}
}
}
, 
[4] = {
audio = {
sfx = {cue = "AVG_footsteps_cave", sheet = "AVG_gf", audioId = 4}
}
, content = 40, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, nextId = 6}
, 
[5] = {
audio = {
sfx = {cue = "AVG_footsteps_cave", sheet = "AVG_gf", audioId = 4}
}
, content = 50, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[6] = {
audio = {
stopAudioId = {4}
}
, content = 60, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 81, jumpAct = 9}
, 
{content = 82, jumpAct = 10}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, nextId = 11}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[11] = {content = 110, contentType = 4, speakerName = 11}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[14] = {content = 140, contentType = 4, speakerName = 11}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 191, jumpAct = 20}
, 
{content = 192, jumpAct = 23}
}
}
, 
[20] = {content = 200, contentType = 4, speakerName = 11}
, 
[21] = {content = 210, contentType = 4, speakerName = 11}
, 
[22] = {content = 220, contentType = 4, speakerName = 11}
, 
[23] = {content = 230, contentType = 4, speakerName = 11}
, 
[24] = {content = 240, contentType = 4, speakerName = 11}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 4, speakerName = 11}
, 
[27] = {content = 270, contentType = 4, speakerName = 11}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[31] = {content = 310, contentType = 4, speakerName = 11}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[34] = {content = 340, contentType = 4, speakerName = 11}
, 
[35] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.5}
}
, autoContinue = true}
, 
[36] = {
imgTween = {
{imgId = 2, alpha = 1, isDark = true, duration = 0.5}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 360, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[38] = {
audio = {
sfx = {cue = "Atk_Persicaria_01", sheet = "Chara_Persicaria"}
}
, 
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 380, contentType = 4, speakerName = 12}
, 
[39] = {content = 390, contentType = 4, speakerName = 12}
, 
[40] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 400, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[41] = {content = 410, contentType = 4, speakerName = 11}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[43] = {content = 430, contentType = 4, speakerName = 11}
, 
[44] = {content = 440, contentType = 4, speakerName = 11}
, 
[45] = {content = 450, contentType = 4, speakerName = 11}
, 
[46] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 460, contentType = 4, speakerName = 12}
, 
[47] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 470, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[48] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 480, contentType = 4, speakerName = 12}
, 
[49] = {content = 490, contentType = 4, speakerName = 12}
, 
[50] = {content = 500, contentType = 4, speakerName = 12}
, 
[51] = {content = 510, contentType = 4, speakerName = 12}
, 
[52] = {content = 520, contentType = 4, speakerName = 11}
, 
[53] = {content = 530, contentType = 4, speakerName = 11}
, 
[54] = {content = 540, contentType = 4, speakerName = 11}
, 
[55] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 550, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 561, jumpAct = 57}
, 
{content = 562, jumpAct = 62}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 4, speakerName = 11}
, 
[60] = {content = 600, contentType = 4, speakerName = 11}
, 
[61] = {content = 610, contentType = 4, speakerName = 11, nextId = 66}
, 
[62] = {content = 620, contentType = 4, speakerName = 11}
, 
[63] = {content = 630, contentType = 4, speakerName = 11}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[66] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 660, contentType = 4, speakerName = 12}
, 
[67] = {
imgTween = {
{imgId = 99, alpha = 1, isDark = false, duration = 1}
}
, 
audio = {
bgm = {stop = true}
}
, autoContinue = true}
, 
[68] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 102, posId = 3}
, 
{imgId = 102, shake = true, duration = 0.2}
}
, content = 680, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[69] = {
audio = {
sfx = {cue = "SupSkill_Cannon_4_chain", sheet = "SupSkill_Cannon"}
}
, 
imgTween = {
{imgId = 12, posId = 3, alpha = 0}
, 
{imgId = 12, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 690, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
, 
[70] = {
imgTween = {
{imgId = 12, alpha = 0, isDark = false, duration = 0.2}
}
, content = 700, contentType = 2}
, 
[71] = {
imgTween = {
{imgId = 1, posId = 3, alpha = 0}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 710, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[72] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 720, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[73] = {
imgTween = {
{imgId = 36, posId = 3, alpha = 0}
, 
{imgId = 36, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 730, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 2}
, 
[74] = {
audio = {
bgm = {stop = true}
, 
sfx = {cue = "AVG_Battlefield", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 99, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 98, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 36, alpha = 0, isDark = false, duration = 0.2}
}
, content = 740, contentType = 2}
, 
[75] = {
imgTween = {
{imgId = 98, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 99, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 1, delay = 0.2, isDark = false, duration = 0.2}
}
, content = 750, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[76] = {
images = {
{imgId = 98, delete = true}
}
, 
imgTween = {
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
}
, content = 760, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[77] = {
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 770, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[78] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 780, contentType = 2}
, 
[79] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 3, alpha = 0}
, 
{imgId = 3, alpha = 1, isDark = false, duration = 0.2}
}
, content = 790, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[80] = {
audio = {
sfx = {cue = "AVG_ClothingUp", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, alpha = 1, isDark = false}
, 
{imgId = 101, shake = true, duration = 0.5}
, 
{imgId = 101, alpha = 0, delay = 1, duration = 0.2}
}
, content = 800, contentType = 2}
, 
[81] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 810, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[82] = {
imgTween = {
{imgId = 2, posId = 5}
, 
{imgId = 2, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 820, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[83] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 2, isDark = true}
}
, content = 830, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[84] = {
imgTween = {
{imgId = 1, isDark = true}
}
, content = 840, contentType = 4, speakerName = 11}
, 
[85] = {
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 2, posId = 5, isDark = false, duration = 0.2}
}
, content = 850, contentType = 2}
, 
[86] = {
imgTween = {
{imgId = 101, alpha = 0.7, isDark = false, duration = 0.2}
}
, content = 860, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[87] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 870, contentType = 4, speakerName = 11}
, 
[88] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 880, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[89] = {content = 890, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[90] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 900, contentType = 4, speakerName = 11}
, 
[91] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 910, contentType = 2}
, 
[92] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Loop", sheet = "Mon_Guardian", audioId = 92}
}
, 
images = {
{imgId = 103, imgType = 3, alpha = 0, imgPath = "eniac_avg"}
, 
{imgId = 12, delete = true}
, 
{imgId = 36, delete = true}
}
, 
imgTween = {
{imgId = 103, posId = 3, alpha = 0}
, 
{imgId = 103, alpha = 1, isDark = false, duration = 1}
}
, content = 920, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[93] = {
audio = {
stopAudioId = {92}
}
, 
imgTween = {
{imgId = 101, alpha = 0.7, isDark = false, duration = 0.2}
, 
{imgId = 103, alpha = 0, isDark = false, duration = 0.2}
}
, content = 930, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[94] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 940, contentType = 2}
, 
[95] = {content = 950, contentType = 2}
, 
[96] = {
imgTween = {
{imgId = 103, alpha = 1, isDark = false, duration = 0.2}
}
, content = 960, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[97] = {content = 970, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[98] = {
imgTween = {
{imgId = 103, alpha = 0}
, 
{imgId = 101, alpha = 0.7}
, 
{imgId = 101, alpha = 0, isDark = false, duration = 3}
}
, 
audio = {
bgm = {stop = true}
, 
sfx = {cue = "Skill_Guardian_01_Loop", sheet = "Mon_Guardian", audioId = 92}
}
, content = 980, contentType = 2}
, 
[99] = {
audio = {
stopAudioId = {92}
}
, 
imgTween = {
{imgId = 103, alpha = 1, duration = 0.2}
}
, content = 990, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[100] = {
imgTween = {
{imgId = 103, alpha = 0, duration = 0.2}
, 
{imgId = 102, alpha = 1, duration = 0.2, isDark = false}
}
, content = 1000, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[101] = {content = 1010, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[102] = {content = 1020, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[103] = {
imgTween = {
{imgId = 102, alpha = 0, duration = 0.2}
, 
{imgId = 3, alpha = 1, duration = 0.2, isDark = false}
}
, content = 1030, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[105] = {
imgTween = {
{imgId = 102, alpha = 1, duration = 0.2}
, 
{imgId = 3, alpha = 0, duration = 0.2, isDark = false}
}
, content = 1050, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[106] = {content = 1060, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
}
return AvgCfg_cpt04_e_11_01

