-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt03_h_05_01 = {
[1] = {content = 10, contentType = 1, scrambleTypeWriter = true, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg010_1", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt01/cpt01_e_bg002", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 104, imgType = 3, alpha = 0, imgPath = "simo_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
, 
{imgId = 6, imgType = 3, alpha = 0, imgPath = "turing_avg"}
, 
{imgId = 8, imgType = 3, alpha = 0, imgPath = "42lab_npc_02_avg"}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt02/cpt02_e_bg001", fullScreen = true}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 1}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
, 
branch = {
{content = 21, jumpAct = 3}
, 
{content = 22, jumpAct = 4}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, nextId = 5}
, 
[4] = {
heroFace = {
{imgId = 105, faceId = 1}
}
, content = 40, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, nextId = 5}
, 
[5] = {
heroFace = {
{imgId = 105, faceId = 0}
}
, content = 50, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 4, speakerName = 61, speakerHeroId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[8] = {content = 80, contentType = 4, speakerName = 61, speakerHeroId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[11] = {content = 110, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[12] = {autoContinue = true, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3, 
imgTween = {
{imgId = 4, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 104, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1004, speakerHeroPosId = 3}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 1, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[17] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 170, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[18] = {content = 180, contentType = 4, speakerName = 61, speakerHeroId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[20] = {autoContinue = true, 
imgTween = {
{imgId = 104, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 4, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
}
}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 211, jumpAct = 22}
, 
{content = 212, jumpAct = 26}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, nextId = 29}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[28] = {content = 280, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, nextId = 29}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
branch = {
{content = 301, jumpAct = 32}
, 
{content = 302, jumpAct = 34}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, nextId = 36}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, nextId = 36}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
branch = {
{content = 361, jumpAct = 37}
}
}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
branch = {
{content = 371, jumpAct = 38}
, 
{content = 372, jumpAct = 38}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2, 
branch = {
{content = 411, jumpAct = 42}
}
}
, 
[42] = {
heroFace = {
{imgId = 105, faceId = 1}
}
, content = 420, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[43] = {
heroFace = {
{imgId = 105, faceId = 0}
}
, content = 430, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 2}
, 
[46] = {content = 460, contentType = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Creepy"}
, 
sfx = {cue = "AVG_BaseDoor_Close", sheet = "AVG_gf"}
}
}
, 
[47] = {autoContinue = true, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 8, speakerHeroPosId = 2, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.3, alpha = 1, isDark = false}
, 
{imgId = 8, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 8, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 8, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 8, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 8, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 8, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 8, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0, posId = 5, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 6, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[59] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 590, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[60] = {autoContinue = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 6, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 3, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true, sheet = "Mus_gacha"}
, 
sfx = {cue = "AVG_Amb_Rain", sheet = "AVG_gf"}
}
}
, 
[61] = {content = 610, contentType = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 1, isDark = false}
}
}
, 
[62] = {content = 620, contentType = 2}
, 
[63] = {content = 630, contentType = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
}
return AvgCfg_cpt03_h_05_01

