-- params : ...
-- function num : 0 , upvalues : _ENV
local AvgCfg_cpt04_e_10_01 = {
[1] = {bgColor = 2, content = 10, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
images = {
{imgId = 1, imgType = 2, alpha = 0, imgPath = "cpt04/cpt04_e_bg007", fullScreen = true}
, 
{imgId = 101, imgType = 3, alpha = 0, imgPath = "persicaria_avg"}
, 
{imgId = 102, imgType = 3, alpha = 0, imgPath = "anna_avg"}
, 
{imgId = 103, imgType = 3, alpha = 0, imgPath = "sol_avg"}
, 
{imgId = 105, imgType = 3, alpha = 0, imgPath = "croque_avg"}
, 
{imgId = 112, imgType = 3, alpha = 0, imgPath = "max_avg"}
, 
{imgId = 136, imgType = 3, alpha = 0, imgPath = "lam_avg"}
, 
{imgId = 28, imgType = 3, alpha = 0, imgPath = "neumann_avg"}
, 
{imgId = 30, imgType = 3, alpha = 0, imgPath = "gabriel_avg"}
, 
{imgId = 29, imgType = 3, alpha = 0, imgPath = "eniac_avg"}
}
, 
imgTween = {
{imgId = 1, delay = 0, duration = 0.6, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Creepy", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 103, faceId = 6}
}
}
, 
[2] = {content = 20, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
heroFace = {
{imgId = 103, faceId = 4}
}
}
, 
[3] = {content = 30, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 28, faceId = 1}
}
}
, 
[4] = {content = 40, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[5] = {content = 50, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 1, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[6] = {content = 60, contentType = 5, tipsTypeWriter = true, tipsShowDuration = 1}
, 
[7] = {bgColor = 3, content = 70, contentType = 4, speakerName = 14, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[8] = {content = 80, contentType = 2, 
audio = {
sfx = {cue = "Atk_Simo_01", sheet = "Chara_Simo"}
}
}
, 
[9] = {content = 90, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 28, faceId = 0}
}
}
, 
[10] = {content = 100, contentType = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 1, alpha = 0.3, isDark = false}
, 
{imgId = 1, delay = 1, duration = 1, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 2, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_impact_gore", sheet = "AVG"}
}
}
, 
[11] = {content = 110, contentType = 3, contentShake = true, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
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
[12] = {content = 120, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "AVG_body_fall", sheet = "AVG"}
}
}
, 
[13] = {content = 130, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 28, delay = 0, duration = 1, posId = 3, alpha = 0.8, isDark = false}
}
, 
heroFace = {
{imgId = 28, faceId = 0}
}
}
, 
[14] = {content = 140, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 5}
}
}
, 
[15] = {content = 150, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, isDark = false}
}
}
, 
[16] = {content = 160, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, shake = true, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Sad", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[17] = {content = 170, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
heroFace = {
{imgId = 28, faceId = 1}
}
}
, 
[18] = {content = 180, contentType = 4, speakerName = 11, scrambleTypeWriter = true, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[19] = {content = 190, contentType = 4, speakerName = 11, scrambleTypeWriter = true}
, 
[20] = {content = 200, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[21] = {content = 210, contentType = 4, speakerName = 12, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[22] = {content = 220, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 0}
}
}
, 
[23] = {content = 230, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[24] = {content = 240, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 1, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.6, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = true}
, 
{imgId = 103, delay = 0, duration = 0.6, posId = 4, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[25] = {content = 250, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 3, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 103, faceId = 3}
}
}
, 
[26] = {content = 260, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 4, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 2, alpha = 0, isDark = true}
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
[27] = {content = 270, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
heroFace = {
{imgId = 30, faceId = 3}
}
}
, 
[28] = {content = 280, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[29] = {content = 290, contentType = 2, 
branch = {
{content = 291, jumpAct = 30}
, 
{content = 292, jumpAct = 30}
}
}
, 
[30] = {content = 300, contentType = 3, speakerHeroId = 1003, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 103, faceId = 5}
}
}
, 
[31] = {content = 310, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 103, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, isDark = false}
}
, 
heroFace = {
{imgId = 28, faceId = 0}
}
}
, 
[32] = {
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, isDark = true}
}
, 
branch = {
{content = 321, jumpAct = 33}
}
}
, 
[33] = {content = 330, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, isDark = false}
}
, 
branch = {
{content = 331, jumpAct = 34}
, 
{content = 332, jumpAct = 36}
}
}
, 
[34] = {content = 340, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
heroFace = {
{imgId = 28, faceId = 2}
}
}
, 
[35] = {content = 350, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, nextId = 38}
, 
[36] = {content = 360, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[37] = {content = 370, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
heroFace = {
{imgId = 28, faceId = 2}
}
}
, 
[38] = {content = 380, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
heroFace = {
{imgId = 28, faceId = 0}
}
}
, 
[39] = {content = 390, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[40] = {content = 400, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[41] = {content = 410, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
heroFace = {
{imgId = 28, faceId = 2}
}
}
, 
[42] = {content = 420, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[43] = {content = 430, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2}
, 
[44] = {bgColor = 2, content = 440, contentType = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, isDark = true}
}
, 
audio = {
sfx = {cue = "AVG_digital_typing", sheet = "AVG"}
}
}
, 
[45] = {content = 450, contentType = 3, speakerHeroId = 28, speakerHeroPosId = 2, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, isDark = false}
}
}
, 
[46] = {
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0.8, isDark = true}
}
, 
branch = {
{content = 461, jumpAct = 47}
}
}
, 
[47] = {autoContinue = true, 
imgTween = {
{imgId = 28, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = true}
, 
{imgId = 1, delay = 0, duration = 0.6, alpha = 0, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[48] = {content = 480, contentType = 2, 
audio = {
bgm = {cue = "Mus_YT_Story_Quiet", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
}
, 
[49] = {content = 490, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[50] = {content = 500, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 1}
}
}
, 
[51] = {content = 510, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
audio = {
sfx = {cue = "AVG_keyboardtype_sci", sheet = "AVG_gf"}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[52] = {content = 520, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[53] = {content = 530, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[54] = {content = 540, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[55] = {content = 550, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[56] = {content = 560, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[57] = {content = 570, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[58] = {content = 580, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[59] = {content = 590, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[60] = {content = 600, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 0}
}
}
, 
[61] = {content = 610, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[62] = {content = 620, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[63] = {content = 630, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 1}
}
}
, 
[64] = {content = 640, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[65] = {content = 650, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[66] = {content = 660, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[67] = {content = 670, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 0}
}
}
, 
[68] = {content = 680, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[69] = {content = 690, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[70] = {content = 700, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[71] = {content = 710, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[72] = {content = 720, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 102, faceId = 5}
}
}
, 
[73] = {content = 730, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[74] = {content = 740, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
, 
audio = {
bgm = {stop = true}
}
}
, 
[75] = {content = 750, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[76] = {content = 760, contentType = 4, speakerName = 13, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0.75, isDark = false}
}
}
, 
[77] = {content = 770, contentType = 4, speakerName = 13}
, 
[78] = {content = 780, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
imgTween = {
{imgId = 29, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 102, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[79] = {content = 790, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 1}
}
}
, 
[80] = {content = 800, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2}
, 
[81] = {content = 810, contentType = 3, speakerHeroId = 1002, speakerHeroPosId = 2, 
heroFace = {
{imgId = 102, faceId = 0}
}
}
, 
[82] = {autoContinue = true, 
imgTween = {
{imgId = 102, delay = 0, duration = 0.6, posId = 3, alpha = 0, isDark = false}
}
}
, 
[83] = {content = 830, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 1, delay = 0, duration = 1, alpha = 1, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 1, duration = 0.6, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Purifier", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 30, faceId = 5}
}
}
, 
[84] = {content = 840, contentType = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
}
, 
[85] = {content = 850, contentType = 3, speakerHeroId = 1036, speakerHeroPosId = 2, contentShake = true, 
imgTween = {
{imgId = 136, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 136, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[86] = {content = 860, contentType = 2, 
imgTween = {
{imgId = 136, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 1, delay = 0, duration = 0.6, alpha = 1, isDark = false, shake = true, shakeIntensity = 2}
}
, 
audio = {
sfx = {cue = "Skill_Lam_Ex_End", sheet = "Chara_Lam"}
}
}
, 
[87] = {content = 870, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
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
[88] = {content = 880, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[89] = {content = 890, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 3}
}
}
, 
[90] = {content = 900, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
heroFace = {
{imgId = 30, faceId = 5}
}
}
, 
[91] = {content = 910, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 5}
}
}
, 
[92] = {content = 920, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
audio = {
bgm = {stop = true}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[93] = {content = 930, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
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
[94] = {content = 940, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 2}
}
}
, 
[95] = {content = 950, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[96] = {content = 960, contentType = 3, contentShake = true, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 101, faceId = 4}
}
}
, 
[97] = {content = 970, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
heroFace = {
{imgId = 30, faceId = 0}
}
}
, 
[98] = {content = 980, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
, 
audio = {
bgm = {cue = "Mus_Story_Passion", sheet = "Music", fadeIn = 2, fadeOut = 3}
}
, 
heroFace = {
{imgId = 102, faceId = 2}
}
}
, 
[99] = {content = 990, contentType = 3, speakerHeroId = 1001, speakerHeroPosId = 2}
, 
[100] = {content = 1000, contentType = 3, speakerHeroId = 30, speakerHeroPosId = 2, 
imgTween = {
{imgId = 101, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = false}
}
}
, 
[101] = {content = 1010, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 30, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0, posId = 3, alpha = 0, isDark = false}
, 
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, shake = true, isDark = false}
}
}
, 
[102] = {content = 1020, contentType = 3, speakerHeroId = 1012, speakerHeroPosId = 2, 
heroFace = {
{imgId = 112, faceId = 3}
}
}
, 
[103] = {content = 1030, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 1, isDark = true}
}
}
, 
[104] = {content = 1040, contentType = 3, contentShake = true, speakerHeroId = 1012, speakerHeroPosId = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.6, posId = 3, alpha = 1, shake = true, isDark = false}
}
, 
heroFace = {
{imgId = 112, faceId = 0}
}
}
, 
[105] = {content = 1050, contentType = 2, 
imgTween = {
{imgId = 112, delay = 0, duration = 0.2, posId = 3, alpha = 0, isDark = false}
}
, 
audio = {
sfx = {cue = "Skill_Fresnel_02", sheet = "Chara_Fresnel"}
}
}
, 
[106] = {content = 1060, contentType = 3, speakerHeroId = 1005, speakerHeroPosId = 3, 
imgTween = {
{imgId = 105, delay = 0, duration = 0, posId = 4, alpha = 0, isDark = false, 
rot = {0, 180, 0}
}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, shake = true, isDark = false}
, 
{imgId = 136, delay = 0, duration = 0, posId = 2, alpha = 0, isDark = true}
, 
{imgId = 136, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = true}
}
, 
heroFace = {
{imgId = 105, faceId = 6}
}
}
, 
[107] = {content = 1070, contentType = 3, contentShake = true, speakerHeroId = 1036, speakerHeroPosId = 1, 
imgTween = {
{imgId = 136, delay = 0, duration = 0.2, posId = 2, alpha = 1, isDark = false}
, 
{imgId = 105, delay = 0, duration = 0.2, posId = 4, alpha = 1, isDark = true}
}
}
}
return AvgCfg_cpt04_e_10_01

