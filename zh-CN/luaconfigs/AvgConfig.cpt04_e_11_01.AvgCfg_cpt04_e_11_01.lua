-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_11_01 = {
[1] = {bgColor = 2, content = 10, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg007", fullScreen = true}
, 
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg"}
, 
{imgId = 112, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 29, imgType = 3, alpha = 0, imgPath = "eniac_avg"}
, 
{imgId = 28, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
, 
{imgId = 30, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
}
, 
imgTween = {
{imgId = 102, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 31, jumpAct = 4}
, 
{content = 32, jumpAct = 5}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, nextId = 6}
, 
[5] = {content = 50, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[6] = {content = 60, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 2}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[7] = {content = 70, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 1}
}
}
, 
[8] = {content = 80, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 81, jumpAct = 9}
, 
{content = 82, jumpAct = 10}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, nextId = 11, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[10] = {content = 100, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[11] = {
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
branch = {
{content = 111, jumpAct = 12}
}
}
, 
[12] = {content = 120, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 1}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[15] = {autoContinue = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 1, alpha = 1, isDark = true}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0.6, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 0}
}
}
, 
[18] = {content = 180, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[19] = {content = 190, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 3, fadeOut = 3}
}
}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[21] = {content = 210, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 211, jumpAct = 22}
, 
{content = 212, jumpAct = 25}
}
}
, 
[22] = {content = 220, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[23] = {content = 230, contentType = 4, speakerName = 11}
, 
[24] = {content = 240, contentType = 4, speakerName = 11, nextId = 27}
, 
[25] = {content = 250, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[26] = {content = 260, contentType = 4, speakerName = 11}
, 
[27] = {content = 270, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[28] = {
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
branch = {
{content = 281, jumpAct = 29}
}
}
, 
[29] = {content = 290, contentType = 4, speakerName = 11}
, 
[30] = {content = 300, contentType = 4, speakerName = 11}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[32] = {content = 320, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[34] = {content = 340, contentType = 3, contentShake = true, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 6}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[36] = {
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
branch = {
{content = 361, jumpAct = 37}
}
}
, 
[37] = {autoContinue = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 1, delay = 0, duration = 1, alpha = 0, isDark = true}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0.6, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 102, delay = 0.6, duration = 0, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 102, delay = 1.2, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 102, faceId = 0}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 2}
}
, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[40] = {content = 400, contentType = 4, speakerName = 12, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 29, faceId = 1}
}
}
, 
[41] = {content = 410, contentType = 4, speakerName = 12}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 1}
}
}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[44] = {
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
branch = {
{content = 441, jumpAct = 45}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[46] = {content = 460, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[47] = {content = 470, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[48] = {content = 480, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 491, jumpAct = 50}
, 
{content = 492, jumpAct = 51}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, nextId = 52}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[52] = {content = 520, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 1, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
, 
heroFace = {
{imgId = 29, faceId = 0}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
branch = {
{content = 591, jumpAct = 60}
, 
{content = 592, jumpAct = 65}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 0}
}
}
, 
[61] = {content = 610, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[62] = {content = 620, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[63] = {content = 630, contentType = 4, speakerName = 11}
, 
[64] = {content = 640, contentType = 4, speakerName = 11, nextId = 69}
, 
[65] = {content = 650, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[66] = {content = 660, contentType = 4, speakerName = 11}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 0}
}
}
, 
[68] = {content = 680, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[70] = {autoContinue = true, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 1, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[71] = {content = 710, contentType = 3, contentShake = true, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0.6, duration = 0.3, posId = 3, alpha = 1, shake = true, isDark = false, shakeIntensity = 2}
}
, 
audio = {
bgm = {cue = "Mus_Story_BattleTension", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 30, faceId = 4}
}
}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[73] = {content = 730, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[74] = {content = 740, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
images = {
{imgId = 29, imgType = 3, alpha = 0, imgPath = "eniac_avg", delete = true}
, 
{imgId = 136, imgType = 3, alpha = 0, imgPath = "lam_avg"}
}
, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 4}
}
}
, 
[76] = {content = 760, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 136, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 136, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[77] = {content = 770, contentType = 2, 
imgTween = {
{imgId = 136, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 3, delay = 0.6, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 3, delay = 1.2, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 2, delay = 1.2, duration = 0.6, alpha = 1, isDark = false}
}
}
, 
[78] = {content = 780, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 2, delay = 0, duration = 0.6, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0.6, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 1.2, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[79] = {content = 790, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.85, isDark = false}
}
, 
heroFace = {
{imgId = 28, faceId = 1}
}
}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
images = {
{imgId = 2, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001", fullScreen = true, delete = true}
, 
{imgId = 3, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg001_2", fullScreen = true, delete = true}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 136, imgType = 3, alpha = 0, imgPath = "lam_avg", delete = true}
, 
{imgId = 29, imgType = 3, alpha = 0, imgPath = "eniac_avg"}
}
, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.85, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 28, faceId = 2}
}
}
, 
[81] = {content = 810, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[82] = {content = 820, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[83] = {content = 830, contentType = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[84] = {content = 840, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 1}
}
}
, 
[86] = {content = 860, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[87] = {
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
branch = {
{content = 871, jumpAct = 88}
}
}
, 
[88] = {content = 880, contentType = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
}
}
, 
[89] = {content = 890, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
, 
heroFace = {
{imgId = 28, faceId = 0}
}
}
, 
[90] = {content = 900, contentType = 4, speakerName = 11, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = true}
}
}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[93] = {content = 930, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
heroFace = {
{imgId = 28, faceId = 2}
}
}
, 
[94] = {content = 940, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
branch = {
{content = 941, jumpAct = 95}
, 
{content = 942, jumpAct = 95}
}
}
, 
[95] = {content = 950, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 1.5, posId = 3, alpha = 1, isDark = false}
}
}
, 
[96] = {content = 960, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2}
, 
[97] = {content = 970, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
, 
heroFace = {
{imgId = 28, faceId = 0}
}
}
, 
[98] = {content = 980, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[99] = {content = 990, contentType = 2}
, 
[100] = {content = 1000, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
}
, 
[101] = {content = 1010, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
}
, 
[102] = {content = 1020, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 1, posId = 3, alpha = 0.75, isDark = false}
, 
{imgId = 28, delay = 3, duration = 5, posId = 3, alpha = 0.6, isDark = false, dissolve = true}
}
, 
audio = {
sfx = {cue = "AVG_paticle_dissipation", sheet = "AVG"}
}
, 
heroFace = {
{imgId = 28, faceId = 2}
}
}
, 
[103] = {content = 1030, contentType = 3, speakerHeroId = 29, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[104] = {content = 1040, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 30, faceId = 3}
}
}
, 
[105] = {content = 1050, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
heroFace = {
{imgId = 30, faceId = 0}
}
}
, 
[106] = {content = 1060, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
heroFace = {
{imgId = 30, faceId = 4}
}
}
, 
[107] = {content = 1070, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[108] = {content = 1080, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
}
}
, 
[109] = {content = 1090, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 4}
}
}
, 
[110] = {content = 1100, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, contentShake = true, 
heroFace = {
{imgId = 30, faceId = 5}
}
}
}
return AvgCfg_cpt04_e_11_01

