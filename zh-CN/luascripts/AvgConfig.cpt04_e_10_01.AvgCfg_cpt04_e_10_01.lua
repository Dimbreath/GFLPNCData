-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_10_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
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
{imgId = 36, imgType = 3, alpha = 0, imgPath = "lam_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 99, alpha = 1, delay = 0.5, duration = 0.5}
, 
{imgId = 3, posId = 3, alpha = 0}
, 
{imgId = 3, alpha = 1, delay = 0.5, isDark = false, duration = 0.2}
}
, content = 10, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[3] = {
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 0, isDark = false, duration = 0.2}
}
, content = 30, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[5] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 50, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 0.5}
, 
[6] = {content = 60, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 0.5}
, 
[7] = {
imgTween = {
{imgId = 102, posId = 3, alpha = 0}
, 
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
}
, content = 70, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[8] = {
audio = {
sfx = {cue = "Skill_Gangyi_01", sheet = "Mon_Gangyi"}
}
, 
imgTween = {
{imgId = 99, duration = 0.5, shake = true}
, 
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 80, contentType = 2}
, 
[9] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false}
, 
{imgId = 101, duration = 0.5, shake = true}
}
, content = 90, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[10] = {
audio = {
sfx = {cue = "SupSkill_Block_1", sheet = "SupSkill_Block"}
}
, 
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 100, contentType = 2}
, 
[11] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 110, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[12] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 120, contentType = 2}
, 
[13] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
}
, content = 130, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[14] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 140, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[15] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 150, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[18] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 180, contentType = 4, speakerName = 12}
, 
[19] = {content = 190, contentType = 4, speakerName = 12}
, 
[20] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
}
, content = 200, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[21] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 210, contentType = 4, speakerName = 11}
, 
[22] = {
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
}
, content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[23] = {
imgTween = {
{imgId = 3, posId = 5}
, 
{imgId = 3, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
}
, content = 230, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[24] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 3, isDark = true}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 5, isDark = false, duration = 0.2}
, 
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
}
, content = 250, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[27] = {
audio = {
sfx = {cue = "Skill_Guardian_01_Start", sheet = "Mon_Guardian"}
}
, 
imgTween = {
{imgId = 102, duration = 0.5, shake = true}
, 
{imgId = 102, alpha = 0, delay = 0.6, isDark = false, duration = 0.2}
}
, content = 270, contentType = 2}
, 
[28] = {content = 280, contentType = 2, 
branch = {
{content = 281, jumpAct = 29}
, 
{content = 282, jumpAct = 29}
}
}
, 
[29] = {
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
, content = 290, contentType = 4, speakerName = 11}
, 
[30] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
}
, content = 300, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
branch = {
{content = 311, jumpAct = 32}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[33] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
}
, content = 330, contentType = 2}
, 
[34] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
}
, content = 340, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[35] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 99, alpha = 0, duration = 1}
}
, 
audio = {
bgm = {stop = true}
}
, autoContinue = true}
, 
[36] = {content = 360, contentType = 2}
, 
[37] = {
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 2, posId = 3, alpha = 0}
, 
{imgId = 2, alpha = 1, isDark = true, duration = 0.2}
}
, content = 370, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[40] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 400, contentType = 4, speakerName = 13}
, 
[41] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 410, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[45] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 450, contentType = 4, speakerName = 13}
, 
[46] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 460, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[49] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 490, contentType = 4, speakerName = 13}
, 
[50] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 500, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[56] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 560, contentType = 4, speakerName = 13}
, 
[57] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 570, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[59] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 590, contentType = 4, speakerName = 13}
, 
[60] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 600, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[62] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 620, contentType = 4, speakerName = 13}
, 
[63] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 630, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[64] = {
imgTween = {
{imgId = 2, alpha = 0, duration = 0.2}
}
, content = 640, contentType = 4, speakerName = 13}
, 
[65] = {content = 650, contentType = 4, speakerName = 13}
, 
[66] = {
imgTween = {
{imgId = 2, alpha = 1, duration = 0.2}
}
, content = 660, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[69] = {
audio = {
bgm = {stop = true}
}
, content = 690, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[70] = {
imgTween = {
{imgId = 99, alpha = 1, duration = 1}
, 
{imgId = 2, alpha = 0, duration = 0.2}
}
, autoContinue = true}
, 
[71] = {
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 3, posId = 3, alpha = 0}
, 
{imgId = 3, alpha = 1, isDark = false, duration = 0.2}
}
, content = 710, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[72] = {
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 0, isDark = false, duration = 0.2}
}
, content = 720, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[73] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 1, isDark = false, duration = 0.2}
}
, content = 730, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[74] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 0, isDark = false, duration = 0.2}
}
, content = 740, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[75] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
}
, content = 750, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[76] = {
audio = {
sfx = {cue = "AVG_Rope", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
}
, content = 760, contentType = 2}
, 
[77] = {
imgTween = {
{imgId = 36, posId = 3, alpha = 0}
, 
{imgId = 36, alpha = 1, isDark = false, duration = 0.2}
}
, content = 770, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 2}
, 
[78] = {
audio = {
sfx = {cue = "Skill_Lam_01_Start", sheet = "Chara_Lam"}
}
, 
imgTween = {
{imgId = 36, duration = 0.5, shake = true}
, 
{imgId = 36, alpha = 0, delay = 0.6, duration = 0.2}
}
, content = 780, contentType = 2}
, 
[79] = {
imgTween = {
{imgId = 1, posId = 3, alpha = 0}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 790, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[81] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 810, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[83] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 830, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[85] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 850, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[86] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 860, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[87] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 870, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[88] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 880, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[89] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 890, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[90] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 1, isDark = false, duration = 0.2}
}
, content = 900, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[92] = {
imgTween = {
{imgId = 102, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 1, alpha = 0, isDark = false, duration = 0.2}
}
, content = 920, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[93] = {
imgTween = {
{imgId = 102, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 12, posId = 3, alpha = 0}
, 
{imgId = 12, alpha = 1, isDark = false, duration = 0.2}
}
, content = 930, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
, 
[94] = {content = 940, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
, 
[95] = {
audio = {
sfx = {cue = "Atk_Maimai_01", sheet = "Chara_Maimai"}
}
, 
imgTween = {
{imgId = 12, duration = 0.5, shake = true}
, 
{imgId = 12, alpha = 0, delay = 0.6, duration = 0.2}
}
, content = 950, contentType = 2}
, 
[96] = {
imgTween = {
{imgId = 12, alpha = 1}
, 
{imgId = 12, duration = 0.5, shake = true}
}
, content = 960, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2}
, 
[97] = {
audio = {
sfx = {cue = "Atk_Maimai_01", sheet = "Chara_Maimai"}
}
, 
imgTween = {
{imgId = 12, alpha = 0, isDark = false, duration = 0.2}
}
, content = 970, contentType = 2}
, 
[98] = {
imgTween = {
{imgId = 5, posId = 1}
, 
{imgId = 5, posId = 2, isDark = false, duration = 0.2}
}
, content = 980, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1}
, 
[99] = {
imgTween = {
{imgId = 36, posId = 5}
, 
{imgId = 36, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, content = 990, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
}
return AvgCfg_cpt04_e_10_01

