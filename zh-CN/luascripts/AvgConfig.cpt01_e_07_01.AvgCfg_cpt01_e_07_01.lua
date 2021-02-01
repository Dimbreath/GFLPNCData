-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt01_e_07_01 = {
[1] = {content = 10, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, bgColor = 2, 
images = {
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_bg005", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 106, imgType = 3, alpha = 0, imgPath = "fresnel_avg"}
, 
{imgId = 109, imgType = 3, alpha = 0, imgPath = "mai_avg"}
, 
{imgId = 11, imgType = 3, alpha = 0, imgPath = "42lab_npc_01_avg"}
, 
{imgId = 13, imgType = 3, alpha = 0, imgPath = "riko_avg"}
, 
{imgId = 16, imgType = 3, alpha = 0, imgPath = "faith_avg"}
, 
{imgId = 1, imgType = 3, alpha = 0, imgPath = "anna_hood_avg"}
, 
{imgId = 6, imgType = 3, alpha = 0, imgPath = "turing_avg"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 1}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 11, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = true}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2}
, 
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 3, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 11, speakerHeroPosId = 3}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 1, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 1, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 1, delay = 1, duration = 0.6, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 2, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 2, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, contentShake = true, 
audio = {
bgm = {stop = true, cue = "Mus_Story_BattleTension", sheet = "Music"}
, 
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
}
, 
[10] = {content = 100, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
}
, 
[11] = {
audio = {
sfx = {cue = "Skill_Sol_Passive", sheet = "Chara_Sol", audioId = 1}
}
, content = 110, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.3, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[16] = {content = 160, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[23] = {content = 230, contentType = 2}
, 
[24] = {
images = {
{imgId = 1, delete = true}
}
, content = 240, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[25] = {
images = {
{imgId = 103, delete = true}
, 
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg002_2", 
scale = {1.8, 1.8, 1.8}
, 
pos = {0, -200, 0}
, fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_cg002_1", fullScreen = true}
}
, content = 250, contentType = 4, speakerName = 251}
, 
[26] = {content = 260, contentType = 2, 
imgTween = {
{imgId = 2, duration = 1, alpha = 0}
, 
{imgId = 99, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music"}
, 
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
}
, 
[27] = {content = 270, contentType = 4, speakerName = 271}
, 
[28] = {
imgTween = {
{imgId = 99, duration = 0.5, 
pos = {400, -400, 0}
}
}
, content = 280, contentType = 4, speakerName = 251}
, 
[29] = {content = 290, contentType = 2}
, 
[30] = {content = 300, contentType = 4, speakerName = 301}
, 
[31] = {content = 310, contentType = 4, speakerName = 271}
, 
[32] = {
imgTween = {
{imgId = 99, duration = 0.5, 
pos = {0, -200, 0}
}
}
, content = 320, contentType = 4, speakerName = 252}
, 
[33] = {
imgTween = {
{imgId = 99, duration = 0.5, 
pos = {400, -400, 0}
}
}
, content = 330, contentType = 4, speakerName = 251}
, 
[34] = {content = 340, contentType = 4, speakerName = 251}
, 
[35] = {content = 350, contentType = 4, speakerName = 251}
, 
[36] = {content = 360, contentType = 4, speakerName = 301}
, 
[37] = {
imgTween = {
{imgId = 99, duration = 1.5, alpha = 0}
, 
{imgId = 98, duration = 1.5, alpha = 1}
}
, content = 370, contentType = 4, speakerName = 251}
, 
[38] = {content = 380, contentType = 4, speakerName = 251}
, 
[39] = {content = 390, contentType = 4, speakerName = 251}
, 
[40] = {content = 400, contentType = 4, speakerName = 251}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 16, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 98, duration = 0.2, alpha = 0}
, 
{imgId = 2, duration = 0.2, alpha = 1}
}
}
, 
[42] = {
images = {
{imgId = 99, delete = true}
, 
{imgId = 98, delete = true}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
}
, content = 420, contentType = 3, speakerHeroId = 12, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false, shake = true}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 11, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 13, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 3}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 2, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 13, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 3, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[53] = {content = 530, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 3, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 3, 
branch = {
{content = 551, jumpAct = 56}
, 
{content = 552, jumpAct = 58}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 3}
, 
[57] = {content = 570, contentType = 4, speakerName = 11, nextId = 60, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 13, speakerHeroPosId = 3, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false, shake = true}
}
}
, 
[59] = {content = 590, contentType = 4, speakerName = 11, nextId = 60, 
imgTween = {
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[60] = {content = 600, contentType = 4, speakerName = 11}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1009, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 13, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 109, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 109, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 106, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 106, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1006, speakerHeroPosId = 3, 
imgTween = {
{imgId = 106, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 109, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[63] = {content = 630, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 106, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 109, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
}
}
, 
[64] = {content = 640, contentType = 4, speakerName = 11}
}
return AvgCfg_cpt01_e_07_01

