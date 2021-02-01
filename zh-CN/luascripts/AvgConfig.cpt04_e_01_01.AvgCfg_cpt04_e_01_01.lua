-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_01_01 = {
[1] = {content = 10, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2, 
images = {
{imgId = 1, imgType = 1, alpha = 1, imgPath = "cpt00/cpt00_e_bg001", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg010_1", fullScreen = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 4, imgType = 2, alpha = 0, imgPath = "cpt00/cpt00_e_bg005", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg", 
rot = {0, 180, 0}
}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 4, delay = 0, duration = 3, alpha = 0.25, isDark = false}
}
}
, 
[2] = {
heroFace = {
{imgId = 102, faceId = 5}
}
, content = 20, contentType = 4, speakerName = 21, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[3] = {content = 30, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[4] = {content = 40, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[5] = {content = 50, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[7] = {content = 70, contentType = 4, speakerName = 21, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[8] = {content = 80, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[9] = {content = 90, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2}
, 
[10] = {content = 100, contentType = 1, speakerHeroId = 1, speakerHeroPosId = 2, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Creepy"}
, 
sfx = {cue = "AVG_whitenoise", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 4, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[11] = {autoContinue = true}
, 
[12] = {content = 120, contentType = 1}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_General", sheet = "Music", fadeIn = 2, fadeOut = 3}
, 
sfx = {cue = "AVG_BaseDoor_Open", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 1}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
}
, 
[14] = {content = 140, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[17] = {content = 170, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1001, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 181, jumpAct = 19}
, 
{content = 182, jumpAct = 21}
}
}
, 
[19] = {
heroFace = {
{imgId = 101, faceId = 1}
}
, content = 190, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[20] = {content = 200, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, nextId = 23, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[21] = {
heroFace = {
{imgId = 101, faceId = 5}
}
, content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[22] = {content = 220, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, nextId = 23, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[23] = {
heroFace = {
{imgId = 101, faceId = 2}
}
, content = 230, contentType = 4, speakerName = 141, speakerHeroPosId = 2}
, 
[24] = {
heroFace = {
{imgId = 101, faceId = 0}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[26] = {content = 260, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[28] = {content = 280, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[30] = {content = 300, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, 
audio = {
bgm = {stop = true, sheet = "Mus_Story_Creepy"}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[31] = {autoContinue = true, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
imgTween = {
{imgId = 3, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[37] = {
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 370, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[41] = {content = 410, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
}
}
, 
[42] = {content = 420, contentType = 2}
, 
[43] = {
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 430, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[48] = {
heroFace = {
{imgId = 103, faceId = 5}
}
, content = 480, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 1, shake = true, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[58] = {content = 580, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 3, duration = 1, 
scale = {1.5, 1.5, 1.5}
, 
pos = {0, -200, 0}
}
}
}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 3, duration = 0.3, 
scale = {1, 1, 1}
, 
pos = {0, 0, 0}
}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
audio = {
sfx = {cue = "AVG_RunStep", sheet = "AVG_gf"}
}
, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
branch = {
{content = 671, jumpAct = 68}
, 
{content = 672, jumpAct = 70}
}
}
, 
[68] = {
heroFace = {
{imgId = 103, faceId = 6}
}
, content = 680, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[69] = {
heroFace = {
{imgId = 103, faceId = 4}
}
, content = 690, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, nextId = 72, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
, 
[71] = {
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 710, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 1, nextId = 72, 
imgTween = {
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
}
}
, 
[72] = {content = 720, contentType = 4, speakerName = 141, speakerHeroId = 2, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, isDark = true}
}
}
, 
[73] = {
heroFace = {
{imgId = 103, faceId = 3}
}
, content = 730, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
, 
{imgId = 105, duration = 0.2, posId = 5, alpha = 0, isDark = true}
}
}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
}
}
}
return AvgCfg_cpt04_e_01_01

