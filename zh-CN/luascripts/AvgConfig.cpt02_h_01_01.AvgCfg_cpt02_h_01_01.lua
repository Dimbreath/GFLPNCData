-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt02_h_01_01 = {
[1] = {bgColor = 2, content = 10, contentType = 1, nextId = 122, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg003", fullScreen = true}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "simo_avg"}
, 
{imgId = 20, imgType = 3, alpha = 0, imgPath = "arrow_avg"}
, 
{imgId = 31, imgType = 3, alpha = 0, imgPath = "cyclopes_npc_01_avg"}
, 
{imgId = 32, imgType = 3, alpha = 0, imgPath = "cyclopes_npc_02_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 1, alpha = 0.25}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0.5}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 2}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
images = {
{imgId = 1005, imgType = 3, alpha = 0, imgPath = "croque_avg", comm = true}
}
, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 1005, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[13] = {autoContinue = true, 
images = {
{imgId = 1005, imgType = 3, alpha = 0, imgPath = "croque_avg", comm = false}
}
, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_tele_disconnect", sheet = "AVG_gf"}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[18] = {autoContinue = true, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 1}
, 
{imgId = 31, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 32, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[30] = {autoContinue = true, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[33] = {content = 330, contentType = 4, speakerName = 331, speakerHeroId = 31, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[34] = {content = 340, contentType = 4, speakerName = 341, speakerHeroId = 32}
, 
[35] = {content = 350, contentType = 4, speakerName = 351, speakerHeroId = 31}
, 
[36] = {content = 360, contentType = 4, speakerName = 341, speakerHeroId = 32}
, 
[37] = {content = 370, contentType = 4, speakerName = 341, speakerHeroId = 32}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = true, cue = "Mus_YT_Story_Quiet"}
}
}
, 
[39] = {autoContinue = true, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 31, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 32, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[47] = {content = 470, contentType = 4, speakerName = 351, speakerHeroId = 1004, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 4, speakerName = 351, speakerHeroId = 1004, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 32, speakerHeroPosId = 3, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 1}
, 
[54] = {autoContinue = true, 
imgTween = {
{imgId = 32, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[63] = {autoContinue = true, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[64] = {content = 640, contentType = 4, speakerName = 641, speakerHeroId = 1}
, 
[65] = {content = 650, contentType = 4, speakerName = 641, speakerHeroId = 1}
, 
[66] = {content = 660, contentType = 4, speakerName = 641, speakerHeroId = 1}
, 
[67] = {content = 670, contentType = 4, speakerName = 641, speakerHeroId = 1}
, 
[68] = {content = 680, contentType = 4, speakerName = 681, speakerHeroId = 1}
, 
[69] = {content = 690, contentType = 4, speakerName = 681, speakerHeroId = 1}
, 
[70] = {content = 700, contentType = 4, speakerName = 641, speakerHeroId = 1}
, 
[71] = {content = 710, contentType = 4, speakerName = 641, speakerHeroId = 1}
, 
[72] = {content = 720, contentType = 4, speakerName = 681, speakerHeroId = 1, 
audio = {
sfx = {cue = "AVG_weapon_reload", sheet = "AVG_gf"}
}
}
, 
[73] = {content = 730, contentType = 4, speakerName = 641, speakerHeroId = 1}
, 
[74] = {content = 740, contentType = 4, speakerName = 681, speakerHeroId = 1, 
audio = {
sfx = {cue = "AVG_pistol_finalshot_sup", sheet = "AVG_gf"}
}
}
, 
[75] = {autoContinue = true, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[77] = {content = 770, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[78] = {content = 780, contentType = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[79] = {content = 790, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2}
, 
[88] = {content = 880, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[89] = {content = 890, contentType = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.3, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[93] = {content = 930, contentType = 3, speakerHeroId = 31, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[94] = {content = 940, contentType = 2, 
imgTween = {
{imgId = 31, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[96] = {content = 960, contentType = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[97] = {autoContinue = true, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Creepy"}
, 
sfx = {cue = "AVG_tele_connect", sheet = "AVG_gf"}
}
}
, 
[98] = {content = 980, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[99] = {content = 990, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
images = {
{imgId = 1005, imgType = 3, alpha = 0, imgPath = "croque_avg", comm = true}
}
, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 1005, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[100] = {content = 1000, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[101] = {content = 1010, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[102] = {content = 1020, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[103] = {content = 1030, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[105] = {content = 1050, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[106] = {content = 1060, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 1, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[107] = {content = 1070, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[108] = {autoContinue = true, 
images = {
{imgId = 1005, imgType = 3, alpha = 0, imgPath = "croque_avg", comm = false}
}
, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 1005, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
}
}
, 
[109] = {content = 1090, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2}
, 
[110] = {content = 1100, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Creepy"}
}
}
, 
[111] = {content = 1110, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
}
, 
[112] = {content = 1120, contentType = 4, speakerName = 1121, speakerHeroId = 4, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[113] = {content = 1130, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[114] = {content = 1140, contentType = 4, speakerName = 1121, speakerHeroId = 4, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[115] = {content = 1150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[116] = {content = 1160, contentType = 4, speakerName = 1121, speakerHeroId = 4, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[117] = {content = 1170, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[118] = {content = 1180, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[119] = {content = 1190, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 2, 
imgTween = {
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[120] = {content = 1200, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 20, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[121] = {content = 1210, contentType = 3, speakerHeroId = 20, speakerHeroPosId = 2, isEnd = true}
, 
[122] = {content = 1220, contentType = 1, scrambleTypeWriter = true, nextId = 2}
}
return AvgCfg_cpt02_h_01_01

