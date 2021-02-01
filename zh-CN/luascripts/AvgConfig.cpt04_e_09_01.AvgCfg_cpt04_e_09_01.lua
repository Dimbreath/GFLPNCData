-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_09_01 = {
[1] = {bgColor = 2, 
images = {
{imgId = 99, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true}
, 
{imgId = 98, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg005", fullScreen = true}
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
{imgId = 36, imgType = 3, alpha = 0, imgPath = "lam_avg"}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
imgTween = {
{imgId = 36, posId = 5}
, 
{imgId = 36, posId = 4, isDark = false, delay = 1, duration = 0.2}
, 
{imgId = 99, duration = 1, alpha = 1}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, content = 10, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[2] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 36, isDark = true}
}
, 
heroFace = {
{imgId = 1, faceId = 5}
}
, content = 20, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[3] = {
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 36, posId = 5, isDark = false, duration = 0.2}
}
, content = 30, contentType = 2, nextId = 5}
, 
[4] = {content = 40, contentType = 2}
, 
[5] = {content = 50, contentType = 4, speakerName = 11}
, 
[6] = {
heroFace = {
{imgId = 102, faceId = 3}
}
, 
imgTween = {
{imgId = 102, duration = 0.2, alpha = 1}
}
, content = 60, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[7] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 70, contentType = 4, speakerName = 11}
, 
[8] = {
heroFace = {
{imgId = 102, faceId = 4}
}
, 
imgTween = {
{imgId = 102, isDark = false}
}
, content = 80, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[10] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 100, contentType = 4, speakerName = 11}
, 
[11] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 110, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[13] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 130, contentType = 4, speakerName = 11}
, 
[14] = {content = 140, contentType = 4, speakerName = 11}
, 
[15] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 150, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[16] = {
heroFace = {
{imgId = 102, faceId = 5}
}
, content = 160, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[17] = {
imgTween = {
{imgId = 102, isDark = true}
}
, content = 170, contentType = 2}
, 
[18] = {
imgTween = {
{imgId = 102, isDark = false}
}
, content = 180, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2}
, 
[19] = {
heroFace = {
{imgId = 102, faceId = 0}
}
, 
imgTween = {
{imgId = 102, duration = 0.2, alpha = 0}
, 
{imgId = 5, posId = 5}
, 
{imgId = 5, posId = 4, isDark = false, duration = 0.2}
}
, content = 190, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[20] = {
imgTween = {
{imgId = 1, posId = 1}
, 
{imgId = 1, posId = 2, isDark = false, duration = 0.2}
, 
{imgId = 5, isDark = true}
}
, content = 200, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[22] = {
heroFace = {
{imgId = 5, faceId = 5}
}
, 
imgTween = {
{imgId = 5, isDark = false}
, 
{imgId = 1, isDark = true}
}
, content = 220, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3}
, 
[23] = {
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 5, isDark = true}
}
, content = 230, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[24] = {
heroFace = {
{imgId = 1, faceId = 4}
}
, content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[25] = {
imgTween = {
{imgId = 36, posId = 5}
, 
{imgId = 36, posId = 4, isDark = false, duration = 0.2}
, 
{imgId = 1, isDark = true}
, 
{imgId = 5, posId = 5, isDark = false, duration = 0.2}
}
, content = 250, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 3}
, 
[26] = {
heroFace = {
{imgId = 1, faceId = 0}
}
, 
imgTween = {
{imgId = 1, isDark = false}
, 
{imgId = 36, isDark = true}
}
, content = 260, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1}
, 
[27] = {
imgTween = {
{imgId = 1, posId = 1, isDark = false, duration = 0.2}
, 
{imgId = 99, alpha = 0, duration = 0.3}
, 
{imgId = 98, alpha = 1, delay = 0.3, duration = 0.3}
, 
{imgId = 36, posId = 5, isDark = false, duration = 0.2}
}
, autoContinue = true}
, 
[28] = {
images = {
{imgId = 1, delete = true}
, 
{imgId = 36, delete = true}
, 
{imgId = 102, delete = true}
}
, 
imgTween = {
{imgId = 101, posId = 3, isDark = false}
}
, content = 280, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[29] = {content = 290, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[30] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.2}
, 
{imgId = 3, posId = 3, isDark = false}
}
, 
heroFace = {
{imgId = 3, faceId = 4}
}
, content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2}
, 
[31] = {
imgTween = {
{imgId = 101, alpha = 1, isDark = false, duration = 0.2}
, 
{imgId = 3, alpha = 0, isDark = false, duration = 0.2}
}
, content = 310, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
branch = {
{content = 321, jumpAct = 33}
, 
{content = 322, jumpAct = 35}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, nextId = 37}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[37] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 370, contentType = 4, speakerName = 13}
, 
[38] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 380, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
branch = {
{content = 401, jumpAct = 41}
, 
{content = 402, jumpAct = 43}
}
}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, nextId = 44}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[44] = {content = 440, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[46] = {content = 460, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[49] = {
imgTween = {
{imgId = 101, isDark = true}
}
, content = 490, contentType = 2}
, 
[50] = {
imgTween = {
{imgId = 101, isDark = false}
}
, content = 500, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
branch = {
{content = 531, jumpAct = 54}
, 
{content = 532, jumpAct = 55}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, nextId = 56}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[56] = {content = 560, contentType = 4, speakerName = 13}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[62] = {
imgTween = {
{imgId = 101, alpha = 0, isDark = false, duration = 0.1}
, 
{imgId = 98, alpha = 0, isDark = false, duration = 0.1}
}
, 
audio = {
bgm = {stop = true}
}
, content = 620, contentType = 4, speakerName = 621}
, 
[63] = {content = 630, contentType = 4, speakerName = 12}
, 
[64] = {content = 640, contentType = 4, speakerName = 12}
, 
[65] = {content = 650, contentType = 4, speakerName = 12}
, 
[66] = {content = 660, contentType = 4, speakerName = 12}
, 
[67] = {
heroFace = {
{imgId = 2, faceId = 2}
}
, 
imgTween = {
{imgId = 2, posId = 3, isDark = true}
}
, content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[71] = {content = 710, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[72] = {
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, content = 720, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
}
return AvgCfg_cpt04_e_09_01

