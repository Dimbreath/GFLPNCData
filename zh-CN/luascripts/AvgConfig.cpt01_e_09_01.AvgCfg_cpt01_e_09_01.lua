-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_09_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeOut = 10}
}
, bgColor = 2, 
images = {
{imgId = 98, imgType = 2, alpha = 1, order = 1, imgPath = "cpt01/cpt01_e_bg005", fullScreen = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 2, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 3, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "faith_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "42lab_npc_01_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "turing_avg"}
}
, 
imgTween = {
{imgId = 1, delay = 0, duration = 0, posId = 1}
, 
{imgId = 1, delay = 0, duration = 0.2, posId = 2}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1, delay = 0, duration = 0, isDark = true}
, 
{imgId = 2, delay = 0, duration = 0, posId = 5}
, 
{imgId = 2, delay = 0, duration = 0.2, posId = 4}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.2, posId = 5}
, 
{imgId = 3, delay = 0, duration = 0, posId = 5}
, 
{imgId = 3, delay = 0, duration = 0.2, posId = 4}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.2, posId = 4}
, 
{imgId = 3, delay = 0, duration = 0.2, posId = 5}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 1}
, 
{imgId = 1, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 0}
}
}
, 
[8] = {
images = {
{imgId = 1, delete = true}
}
, content = 80, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 3, delay = 0, duration = 0, posId = 3, alpha = 0}
, 
{imgId = 3, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
}
, 
[9] = {
images = {
{imgId = 97, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg002_2", 
scale = {1.5, 1.5, 1.5}
, 
pos = {300, -200, 0}
, fullScreen = true}
, 
{imgId = 96, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg002_1", fullScreen = true}
, 
{imgId = 95, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg003_2", 
scale = {1.5, 1.5, 1.5}
, 
pos = {300, -200, 0}
, fullScreen = true}
, 
{imgId = 94, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg003_1", fullScreen = true}
}
, content = 90, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 1}
, 
{imgId = 3, delay = 0, duration = 0.2, alpha = 0}
}
}
, 
[10] = {content = 100, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2}
, 
{imgId = 101, delay = 0.2, duration = 0.2, shake = true}
, 
{imgId = 101, delay = 0.7, duration = 0.2, alpha = 0}
}
, 
audio = {
sfx = {cue = "Atk_Xin_01", sheet = "Mon_Xin"}
}
}
, 
[11] = {content = 110, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3}
, 
{imgId = 102, delay = 0, duration = 0.5, posId = 4}
, 
{imgId = 102, delay = 0.5, duration = 0.2, shake = true}
, 
{imgId = 102, delay = 1, duration = 0.2, alpha = 0}
}
, 
audio = {
sfx = {cue = "AVG_Broken_Glass", sheet = "AVG_gf", audioId = 1}
}
}
, 
[12] = {content = 120, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 97, duration = 1.5, alpha = 1}
, 
{imgId = 98, duration = 1.5, alpha = 0}
}
}
, 
[13] = {content = 130, contentType = 4, speakerName = 11}
, 
[14] = {content = 140, contentType = 4, speakerName = 11}
, 
[15] = {content = 150, contentType = 2}
, 
[16] = {content = 160, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 97, delay = 1, duration = 0.5, 
pos = {301, -200, 0}
}
}
}
, 
[17] = {content = 170, contentType = 2, 
imgTween = {
{imgId = 97, duration = 1, alpha = 0}
, 
{imgId = 95, duration = 1, alpha = 1}
}
}
, 
[18] = {content = 180, contentType = 4, speakerName = 12}
, 
[19] = {content = 190, contentType = 4, speakerName = 12}
, 
[20] = {content = 200, contentType = 4, speakerName = 11}
, 
[21] = {content = 210, contentType = 4, speakerName = 12}
, 
[22] = {content = 220, contentType = 4, speakerName = 11}
, 
[23] = {content = 230, contentType = 4, speakerName = 11, 
audio = {
bgm = {stop = true}
}
}
, 
[24] = {content = 240, contentType = 4, speakerName = 11}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 3, delay = 0, duration = 0, posId = 1}
, 
{imgId = 3, delay = 0, duration = 0.2, posId = 2}
, 
{imgId = 95, duration = 0.2, alpha = 0}
, 
{imgId = 98, duration = 0.2, alpha = 1}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 2, delay = 0, duration = 0, posId = 5}
, 
{imgId = 2, delay = 0, duration = 0.2, posId = 4}
, 
{imgId = 3, delay = 0, duration = 0, isDark = true}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3}
, 
[28] = {content = 280, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 95, alpha = 0}
, 
{imgId = 98, duration = 1.5, alpha = 0}
, 
{imgId = 94, duration = 1.5, alpha = 1}
}
}
, 
[29] = {
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 3, fadeOut = 4}
}
, content = 290, contentType = 4, speakerName = 13}
, 
[30] = {content = 300, contentType = 4, speakerName = 11}
, 
[31] = {content = 310, contentType = 4, speakerName = 11}
, 
[32] = {content = 320, contentType = 4, speakerName = 11}
, 
[33] = {content = 330, contentType = 4, speakerName = 13}
, 
[34] = {content = 340, contentType = 4, speakerName = 11}
, 
[35] = {content = 350, contentType = 4, speakerName = 11}
, 
[36] = {content = 360, contentType = 4, speakerName = 11}
, 
[37] = {content = 370, contentType = 4, speakerName = 13}
, 
[38] = {
imgTween = {
{imgId = 94, duration = 1.5, alpha = 0}
, 
{imgId = 95, 
pos = {0, -200, 0}
, alpha = 0}
, 
{imgId = 95, duration = 1.5, 
pos = {0, -200, 0}
, alpha = 1}
}
, content = 380, contentType = 4, speakerName = 12}
, 
[39] = {content = 390, contentType = 4, speakerName = 13}
, 
[40] = {content = 400, contentType = 4, speakerName = 12}
, 
[41] = {content = 410, contentType = 4, speakerName = 11}
, 
[42] = {content = 420, contentType = 4, speakerName = 13}
, 
[43] = {content = 430, contentType = 4, speakerName = 11}
, 
[44] = {content = 440, contentType = 4, speakerName = 11}
, 
[45] = {
images = {
{imgId = 97, delete = true}
, 
{imgId = 96, delete = true}
, 
{imgId = 95, delete = true}
, 
{imgId = 94, delete = true}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
}
, content = 450, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 4}
, 
{imgId = 102, delay = 0, duration = 2, posId = 3}
, 
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 98, duration = 0.2, alpha = 1}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 2}
, 
{imgId = 102, delay = 0.2, duration = 1, posId = 4}
, 
{imgId = 102, delay = 1.2, duration = 0, isDark = true}
}
, 
branch = {
{content = 461, jumpAct = 47}
, 
{content = 462, jumpAct = 49}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 1}
, 
[48] = {content = 480, contentType = 2, nextId = 52, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.5, alpha = 0}
, 
{imgId = 103, delay = 0, duration = 0.5, alpha = 0}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 1}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0.2, shake = true, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[51] = {content = 510, contentType = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 103, delay = 0, duration = 0.2, alpha = 0}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0, posId = 3, alpha = 0}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, posId = 3, alpha = 0}
, 
{imgId = 101, duration = 0.2, alpha = 1}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 0}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 3, delay = 0, duration = 0, posId = 3, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, isDark = false}
}
}
, 
[56] = {content = 560, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 3, delay = 0, duration = 0, posId = 4}
, 
{imgId = 3, delay = 0, duration = 1, posId = 3}
}
}
, 
[57] = {content = 570, contentType = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.5, alpha = 0}
}
}
, 
[58] = {content = 580, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, alpha = 1}
, 
{imgId = 103, delay = 0, duration = 2, alpha = 0.5}
}
, 
audio = {
sfx = {cue = "Skill_Guardian_01_Loop", sheet = "Mon_Guardian", audioId = 58}
}
}
, 
[59] = {
audio = {
bgm = {stop = true}
}
, content = 590, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 7, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 2, alpha = 0}
}
}
, 
[61] = {
images = {
{imgId = 103, delete = true}
}
, content = 610, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0.5, duration = 0.2, alpha = 1}
}
, 
audio = {
stopAudioId = {58}
}
}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[64] = {
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 640, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 101, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 101, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 1}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 0}
}
}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0}
, 
{imgId = 102, delay = 0, duration = 0.2, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf", audioId = 1}
}
}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 2}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 18, speakerHeroPosId = 2}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 18, speakerHeroPosId = 2}
, 
[73] = {content = 730, contentType = 3, speakerHeroId = 18, speakerHeroPosId = 2}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 2, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.2, alpha = 0}
, 
{imgId = 101, delay = 0, duration = 0.2, alpha = 1}
}
}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, contentShake = true}
, 
[77] = {content = 770, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[78] = {content = 780, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2, contentShake = true}
, 
[79] = {content = 790, contentType = 3, speakerHeroId = 16, speakerHeroPosId = 2}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.5, alpha = 0}
, 
{imgId = 3, delay = 0, duration = 0, posId = 1}
, 
{imgId = 3, delay = 0.5, duration = 0.2, posId = 2, isDark = false}
}
}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 3, delay = 0, duration = 0, isDark = true}
, 
{imgId = 2, delay = 0, duration = 0, posId = 5}
, 
{imgId = 2, delay = 0, duration = 0.2, posId = 4, isDark = false}
}
}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, 
imgTween = {
{imgId = 2, delay = 0, duration = 0, isDark = true}
, 
{imgId = 3, delay = 0, duration = 0, isDark = false}
}
}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 3, 
imgTween = {
{imgId = 2, delay = 0, duration = 0, isDark = false}
, 
{imgId = 3, delay = 0, duration = 0, isDark = true}
}
}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.2, posId = 1}
, 
{imgId = 2, delay = 0, duration = 0, isDark = true}
, 
{imgId = 1, delay = 0, duration = 0, posId = 1}
, 
{imgId = 1, delay = 0, duration = 0.2, posId = 2, isDark = false}
}
}
}
return AvgCfg_cpt01_e_09_01

